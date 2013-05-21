/* -*-c++-*- */
/* osgEarth - Dynamic map generation toolkit for OpenSceneGraph
* Copyright 2008-2012 Pelican Mapping
* http://osgearth.org
*
* osgEarth is free software; you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>
*/
#include "MPTerrainEngineNode"
#include "SerialKeyNodeFactory"
#include "TerrainNode"
#include "TileModelFactory"
#include "TileModelCompiler"

#include <osgEarth/HeightFieldUtils>
#include <osgEarth/ImageUtils>
#include <osgEarth/Registry>
#include <osgEarth/VirtualProgram>
#include <osgEarth/ShaderFactory>
#include <osgEarth/MapModelChange>

#include <osg/TexEnv>
#include <osg/TexEnvCombine>
#include <osg/PagedLOD>
#include <osg/Timer>
#include <osg/Depth>
#include <osg/BlendFunc>

#define LC "[MPTerrainEngineNode] "

using namespace osgEarth_engine_mp;
using namespace osgEarth;

//------------------------------------------------------------------------

namespace
{
    // adapter that lets MPTerrainEngineNode listen to Map events
    struct MPTerrainEngineNodeMapCallbackProxy : public MapCallback
    {
        MPTerrainEngineNodeMapCallbackProxy(MPTerrainEngineNode* node) : _node(node) { }
        osg::observer_ptr<MPTerrainEngineNode> _node;

        void onMapInfoEstablished( const MapInfo& mapInfo ) {
            _node->onMapInfoEstablished( mapInfo );
        }

        void onMapModelChanged( const MapModelChange& change ) {
            _node->onMapModelChanged( change );
        }
    };
}

//---------------------------------------------------------------------------

static Threading::ReadWriteMutex s_engineNodeCacheMutex;
//Caches the MapNodes that have been created
typedef std::map<UID, osg::observer_ptr<MPTerrainEngineNode> > EngineNodeCache;

static
EngineNodeCache& getEngineNodeCache()
{
    static EngineNodeCache s_cache;
    return s_cache;
}

void
MPTerrainEngineNode::registerEngine(MPTerrainEngineNode* engineNode)
{
    Threading::ScopedWriteLock exclusiveLock( s_engineNodeCacheMutex );
    getEngineNodeCache()[engineNode->_uid] = engineNode;
    OE_DEBUG << LC << "Registered engine " << engineNode->_uid << std::endl;
}

void
MPTerrainEngineNode::unregisterEngine( UID uid )
{
    Threading::ScopedWriteLock exclusiveLock( s_engineNodeCacheMutex );
    EngineNodeCache::iterator k = getEngineNodeCache().find( uid );
    if (k != getEngineNodeCache().end())
    {
        getEngineNodeCache().erase(k);
        OE_DEBUG << LC << "Unregistered engine " << uid << std::endl;
    }
}

// since this method is called in a database pager thread, we use a ref_ptr output
// parameter to avoid the engine node being destructed between the time we 
// return it and the time it's accessed; this could happen if the user removed the
// MapNode from the scene during paging.
void
MPTerrainEngineNode::getEngineByUID( UID uid, osg::ref_ptr<MPTerrainEngineNode>& output )
{
    Threading::ScopedReadLock sharedLock( s_engineNodeCacheMutex );
    EngineNodeCache::const_iterator k = getEngineNodeCache().find( uid );
    if (k != getEngineNodeCache().end())
        output = k->second.get();
}

UID
MPTerrainEngineNode::getUID() const
{
    return _uid;
}

//------------------------------------------------------------------------

MPTerrainEngineNode::ElevationChangedCallback::ElevationChangedCallback( MPTerrainEngineNode* terrain ):
_terrain( terrain )
{
    //nop
}

void
MPTerrainEngineNode::ElevationChangedCallback::onVisibleChanged( TerrainLayer* layer )
{    
    osgEarth::Registry::instance()->clearBlacklist();
    _terrain->refresh();
}

//------------------------------------------------------------------------

MPTerrainEngineNode::MPTerrainEngineNode() :
TerrainEngineNode     ( ),
_terrain              ( 0L ),
_update_mapf          ( 0L ),
_tileCount            ( 0 ),
_tileCreationTime     ( 0.0 ),
_textureImageUnit     ( 0 ),
_batchUpdateInProgress( false ),
_refreshRequired      ( false ),
_shaderUpdateRequired ( false )
{
    _uid = Registry::instance()->createUID();

    // install an elevation callback so we can update elevation data
    _elevationCallback = new ElevationChangedCallback( this );
}

MPTerrainEngineNode::~MPTerrainEngineNode()
{
    unregisterEngine( _uid );

    if ( _update_mapf )
    {
        delete _update_mapf;
    }
}

void
MPTerrainEngineNode::preInitialize( const Map* map, const TerrainOptions& options )
{
    TerrainEngineNode::preInitialize( map, options );

    // override the compositor technique because we want to do unit
    // reservations but nothing else.
    getTextureCompositor()->setTechnique( 0L );
}

void
MPTerrainEngineNode::postInitialize( const Map* map, const TerrainOptions& options )
{
    TerrainEngineNode::postInitialize( map, options );

    // Initialize the map frames. We need one for the update thread and one for the
    // cull thread. Someday we can detect whether these are actually the same thread
    // (depends on the viewer's threading mode).
    _update_mapf = new MapFrame( map, Map::MASKED_TERRAIN_LAYERS, "mp-update" );

    // merge in the custom options:
    _terrainOptions.merge( options );

    // a shared registry for tile nodes in the scene graph.
    _liveTiles = new TileNodeRegistry("live");

    // set up a registry for quick release:
    if ( _terrainOptions.quickReleaseGLObjects() == true )
    {
        _deadTiles = new TileNodeRegistry("dead");
    }
    
    // initialize the model factory:
    _tileModelFactory = new TileModelFactory(getMap(), _liveTiles.get(), _terrainOptions );


    // handle an already-established map profile:
    if ( _update_mapf->getProfile() )
    {
        // NOTE: this will initialize the map with the startup layers
        onMapInfoEstablished( MapInfo(map) );
    }

    // populate the terrain with whatever data is in the map to begin with:
    if ( _terrain )
    {
        this->getTextureCompositor()->reserveTextureImageUnit( _textureImageUnit );
        updateShaders();
    }

    // install a layer callback for processing further map actions:
    map->addMapCallback( new MPTerrainEngineNodeMapCallbackProxy(this) );

    // Attach to all of the existing elevation layers
    ElevationLayerVector elevationLayers;
    map->getElevationLayers( elevationLayers );
    for( ElevationLayerVector::const_iterator i = elevationLayers.begin(); i != elevationLayers.end(); ++i )
    {
        i->get()->addCallback( _elevationCallback.get() );
    }

    // register this instance to the osgDB plugin can find it.
    registerEngine( this );

    // now that we have a map, set up to recompute the bounds
    dirtyBound();
}


osg::BoundingSphere
MPTerrainEngineNode::computeBound() const
{
    if ( _terrain && _terrain->getNumChildren() > 0 )
    {
        return _terrain->getBound();
    }
    else
    {
        return TerrainEngineNode::computeBound();
    }
}


void
MPTerrainEngineNode::refresh()
{
    if ( _batchUpdateInProgress )
    {
        _refreshRequired = true;
    }
    else
    {
        // remove the old one:
        this->removeChild( _terrain );

        // and create a new one.
        createTerrain();

        _refreshRequired = false;
    }
}

void
MPTerrainEngineNode::onMapInfoEstablished( const MapInfo& mapInfo )
{
    OE_INFO << LC << "Sample ratio = " << _terrainOptions.heightFieldSampleRatio().value() << std::endl;

    createTerrain();
}

void
MPTerrainEngineNode::createTerrain()
{
    // scrub the heightfield cache.
    if (_tileModelFactory)
        _tileModelFactory->getHeightFieldCache()->clear();

    // New terrain
    _terrain = new TerrainNode( _deadTiles.get() );
    this->addChild( _terrain );

    // Factory to create the root keys:
    KeyNodeFactory* factory = getKeyNodeFactory();

    // Build the first level of the terrain.
    // Collect the tile keys comprising the root tiles of the terrain.
    std::vector< TileKey > keys;
    _update_mapf->getProfile()->getRootKeys( keys );

    // create a root node for each root tile key.
    OE_INFO << LC << "Creating root keys (" << keys.size() << ")" << std::flush;

    for( unsigned i=0; i<keys.size(); ++i )
    {
        osg::Node* node = factory->createRootNode( keys[i] );
        OE_INFO_CONTINUE << "." << std::flush;
        if ( node )
            _terrain->addChild( node );
        else
            OE_WARN << LC << "Couldn't make tile for root key: " << keys[i].str() << std::endl;
    }

    OE_INFO_CONTINUE << "done." << std::endl;

    updateShaders();
}


KeyNodeFactory*
MPTerrainEngineNode::getKeyNodeFactory()
{
    osg::ref_ptr<KeyNodeFactory>& knf = _perThreadKeyNodeFactories.get(); // thread-safe get
    if ( !knf.valid() )
    {
        // create a compiler for compiling tile models into geometry
        bool optimizeTriangleOrientation = 
            getMap()->getMapOptions().elevationInterpolation() != INTERP_TRIANGULATE;

        // A compiler specific to this thread:
        TileModelCompiler* compiler = new TileModelCompiler(
            _update_mapf->terrainMaskLayers(),
            _textureImageUnit,
            optimizeTriangleOrientation,
            _terrainOptions );

        // initialize a key node factory.
        knf = new SerialKeyNodeFactory( 
            _tileModelFactory.get(),
            compiler,
            _liveTiles.get(),
            _deadTiles.get(),
            _terrainOptions, 
            MapInfo( getMap() ),
            _terrain, 
            _uid );
    }

    return knf.get();
}


osg::Node*
MPTerrainEngineNode::createNode( const TileKey& key )
{
    // if the engine has been disconnected from the scene graph, bail out and don't
    // create any more tiles
    if ( getNumParents() == 0 )
        return 0L;

    OE_DEBUG << LC << "Create node for \"" << key.str() << "\"" << std::endl;

    osg::Node* result =  getKeyNodeFactory()->createNode( key );
    return result;
}

osg::Node*
MPTerrainEngineNode::createTile( const TileKey& key )
{
    return getKeyNodeFactory()->createNode( key );
}


void
MPTerrainEngineNode::onMapModelChanged( const MapModelChange& change )
{
    if ( change.getAction() == MapModelChange::BEGIN_BATCH_UPDATE )
    {
        _batchUpdateInProgress = true;
    }

    else if ( change.getAction() == MapModelChange::END_BATCH_UPDATE )
    {
        _batchUpdateInProgress = false;

        if ( _refreshRequired )
            refresh();

        if ( _shaderUpdateRequired )
            updateShaders();
    }

    else
    {
        // update the thread-safe map model copy:
        _update_mapf->sync();

        // dispatch the change handler
        if ( change.getLayer() )
        {
            // first inform the texture compositor with the new model changes:
            if ( _texCompositor.valid() && change.getImageLayer() )
            {
                _texCompositor->applyMapModelChange( change );
            }

            // then apply the actual change:
            switch( change.getAction() )
            {
            case MapModelChange::ADD_IMAGE_LAYER:
                addImageLayer( change.getImageLayer() );
                break;
            case MapModelChange::REMOVE_IMAGE_LAYER:
                removeImageLayer( change.getImageLayer() );
                break;
            case MapModelChange::ADD_ELEVATION_LAYER:
                addElevationLayer( change.getElevationLayer() );
                break;
            case MapModelChange::REMOVE_ELEVATION_LAYER:
                removeElevationLayer( change.getElevationLayer() );
                break;
            case MapModelChange::MOVE_IMAGE_LAYER:
                moveImageLayer( change.getFirstIndex(), change.getSecondIndex() );
                break;
            case MapModelChange::MOVE_ELEVATION_LAYER:
                moveElevationLayer( change.getFirstIndex(), change.getSecondIndex() );
                break;
            case MapModelChange::ADD_MODEL_LAYER:
            case MapModelChange::REMOVE_MODEL_LAYER:
            case MapModelChange::MOVE_MODEL_LAYER:
            default: 
                break;
            }
        }
    }
}


void
MPTerrainEngineNode::addImageLayer( ImageLayer* layerAdded )
{
    refresh();
}


void
MPTerrainEngineNode::removeImageLayer( ImageLayer* layerRemoved )
{
    refresh();
}

void
MPTerrainEngineNode::moveImageLayer( unsigned int oldIndex, unsigned int newIndex )
{
    updateShaders();
}

void
MPTerrainEngineNode::addElevationLayer( ElevationLayer* layer )
{
    if ( !layer )
        return;

    layer->addCallback( _elevationCallback.get() );

    refresh();
}

void
MPTerrainEngineNode::removeElevationLayer( ElevationLayer* layerRemoved )
{
    layerRemoved->removeCallback( _elevationCallback.get() );

    refresh();
}

void
MPTerrainEngineNode::moveElevationLayer( unsigned int oldIndex, unsigned int newIndex )
{
    refresh();
}

void
MPTerrainEngineNode::validateTerrainOptions( TerrainOptions& options )
{
    TerrainEngineNode::validateTerrainOptions( options );
    
    //nop for now.
    //note: to validate plugin-specific features, we would create an MPTerrainEngineOptions
    // and do the validation on that. You would then re-integrate it by calling
    // options.mergeConfig( osgTerrainOptions ).
}


// Generates the main shader code for rendering the terrain.
void
MPTerrainEngineNode::updateShaders()
{
    if ( _batchUpdateInProgress )
    {
        _shaderUpdateRequired = true;
    }
    else
    {
        osg::StateSet* terrainStateSet = _terrain->getOrCreateStateSet();

        VirtualProgram* vp = new VirtualProgram();
        vp->setName( "engine_mp:TerrainNode" );
        terrainStateSet->setAttributeAndModes( vp, osg::StateAttribute::ON );

        // Vertex shader template:
        std::string vs =
            "#version " GLSL_VERSION_STR "\n"
            GLSL_DEFAULT_PRECISION_FLOAT "\n"
            "varying vec4 osg_FrontColor; \n"
            "varying vec4 osg_FrontSecondaryColor; \n"
            "varying vec4 oe_layer_tc;\n"
            "void osgearth_vert_setupColoring() \n"
            "{ \n"
            "    osg_FrontColor          = gl_Color; \n"
            "    osg_FrontSecondaryColor = vec4(0.0);\n"
            "    oe_layer_tc             = __GL_MULTITEXCOORD__;\n"
            "}\n";

        // Fragment shader template:
        std::string fs =
            "#version " GLSL_VERSION_STR "\n"
            GLSL_DEFAULT_PRECISION_FLOAT "\n"
            "varying vec4      oe_layer_tc; \n"
            "uniform sampler2D oe_layer_tex; \n"
            "uniform int       oe_layer_uid; \n"
            "uniform int       oe_layer_order; \n"
            "uniform float     oe_layer_opacity; \n"
            "__COLOR_FILTER_HEAD__"
            "void osgearth_frag_applyColoring( inout vec4 color ) \n"
            "{ \n"
            "    vec4 texel = texture2D(oe_layer_tex, oe_layer_tc.st);\n"
            "    float alpha = texel.a * oe_layer_opacity; \n"
            "    if (oe_layer_order == 0) \n"
            "        color = vec4(color.rgb * (1.0 - alpha) + (texel.rgb * alpha), 1.0); \n"
            "    else \n"
            "        color = vec4(texel.rgb, color.a * alpha); \n"
            "    __COLOR_FILTER_BODY__"
            "} \n";

        // install the gl_MultiTexCoord* variable that uses the proper texture
        // image unit:
        replaceIn( vs, "__GL_MULTITEXCOORD__", Stringify() << "gl_MultiTexCoord" << _textureImageUnit );

        // assemble color filter code snippets.
        {
            std::stringstream cf_head;
            std::stringstream cf_body;

            // second, install the per-layer color filter functions.
            bool ifStarted = false;
            const char* I = "    ";
            int numImageLayers = _update_mapf->imageLayers().size();
            for( int i=0; i<numImageLayers; ++i )
            {
                ImageLayer* layer = _update_mapf->getImageLayerAt(i);
                if ( layer->getEnabled() )
                {
                    const ColorFilterChain& chain = layer->getColorFilters();
                    if ( chain.size() > 0 )
                    {
                        if ( ifStarted ) cf_body << I << "else if ";
                        else             cf_body << I << "if ";
                        cf_body << "(oe_layer_uid == " << layer->getUID() << ") {\n";
                        for( ColorFilterChain::const_iterator j = chain.begin(); j != chain.end(); ++j )
                        {
                            const ColorFilter* filter = j->get();
                            cf_head << "void " << filter->getEntryPointFunctionName() << "(in int slot, inout vec4 color);\n";
                            cf_body << I << I << filter->getEntryPointFunctionName() << "(" << _textureImageUnit << ", color);\n";
                            filter->install( terrainStateSet );
                        }
                        cf_body << I << "}\n";
                        ifStarted = true;
                    }
                }
            }

            std::string cf_head_str, cf_body_str;
            cf_head_str = cf_head.str();
            cf_body_str = cf_body.str();

            replaceIn( fs, "__COLOR_FILTER_HEAD__", cf_head_str );
            replaceIn( fs, "__COLOR_FILTER_BODY__", cf_body_str );
        }

        vp->setShader(
            "osgearth_vert_setupColoring",
            new osg::Shader( osg::Shader::VERTEX, vs ),
            osg::StateAttribute::ON | osg::StateAttribute::PROTECTED );

        vp->setShader(
            "osgearth_frag_applyColoring",
            new osg::Shader( osg::Shader::FRAGMENT, fs ),
            osg::StateAttribute::ON | osg::StateAttribute::PROTECTED );

        // required for multipass tile rendering to work
        terrainStateSet->setAttributeAndModes(
            new osg::Depth(osg::Depth::LEQUAL, 0, 1, true) );

        // blend multipass image layers
        terrainStateSet->setAttributeAndModes(
            new osg::BlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA), 1);
        
        // binding for the terrain texture
        terrainStateSet->getOrCreateUniform( 
            "oe_layer_tex", osg::Uniform::SAMPLER_2D )->set( _textureImageUnit );

        // uniform that controls per-layer opacity
        terrainStateSet->getOrCreateUniform(
            "oe_layer_opacity", osg::Uniform::FLOAT )->set( 1.0f );

        // uniform that conveys the layer UID to the shaders; necessary
        // for per-layer branching (like color filters)
        terrainStateSet->getOrCreateUniform(
            "oe_layer_uid", osg::Uniform::INT )->set( 0 );

        // uniform that conveys the render order, since the shaders
        // need to know which is the first layer in order to blend properly
        terrainStateSet->getOrCreateUniform(
            "oe_layer_order", osg::Uniform::INT )->set( 0 );

        _shaderUpdateRequired = false;
    }
}


namespace
{
    class UpdateElevationVisitor : public osg::NodeVisitor
    {
    public:
        UpdateElevationVisitor( TileModelCompiler* compiler ):
          osg::NodeVisitor(osg::NodeVisitor::TRAVERSE_ALL_CHILDREN),
          _compiler(compiler)
          {}

          void apply(osg::Node& node)
          {
              TileNode* tile = dynamic_cast<TileNode*>(&node);
              if (tile)
              {
                  tile->compile( _compiler );
              }

              traverse(node);
          }

          TileModelCompiler* _compiler;
    };
}


void
MPTerrainEngineNode::onVerticalScaleChanged()
{
    _terrainOptions.verticalScale() = getVerticalScale();
    UpdateElevationVisitor visitor( getKeyNodeFactory()->getCompiler() );
    this->accept(visitor);
}
