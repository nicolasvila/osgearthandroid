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
#include <osgEarth/ElevationLayer>
#include <osgEarth/VerticalDatum>
#include <osgEarth/HeightFieldUtils>
#include <osg/Version>

using namespace osgEarth;
using namespace OpenThreads;

#define LC "[ElevationLayer] \"" << getName() << "\" : "

//------------------------------------------------------------------------

ElevationLayerOptions::ElevationLayerOptions( const ConfigOptions& options ) :
TerrainLayerOptions( options )
{
    setDefaults();
    fromConfig( _conf );
}

ElevationLayerOptions::ElevationLayerOptions( const std::string& name, const TileSourceOptions& driverOptions ) :
TerrainLayerOptions( name, driverOptions )
{
    setDefaults();
    fromConfig( _conf );
}

void
ElevationLayerOptions::setDefaults()
{
    //NOP
}

Config
ElevationLayerOptions::getConfig( bool isolate ) const
{
    return TerrainLayerOptions::getConfig( isolate );
}

void
ElevationLayerOptions::fromConfig( const Config& conf )
{
    //NOP
}

void
ElevationLayerOptions::mergeConfig( const Config& conf )
{
    TerrainLayerOptions::mergeConfig( conf );
    fromConfig( conf );
}

//------------------------------------------------------------------------

namespace
{
    struct ElevationLayerPreCacheOperation : public TileSource::HeightFieldOperation
    {
        osg::ref_ptr<CompositeValidValueOperator> ops;

        ElevationLayerPreCacheOperation( TileSource* source )
        {
            ops = new CompositeValidValueOperator;
            ops->getOperators().push_back(new osgTerrain::NoDataValue(source->getNoDataValue()));
            ops->getOperators().push_back(new osgTerrain::ValidRange(source->getNoDataMinValue(), source->getNoDataMaxValue()));
        }

        void operator()( osg::ref_ptr<osg::HeightField>& hf )
        {
            //Modify the heightfield data so that is contains a standard value for NO_DATA
            ReplaceInvalidDataOperator op;
            op.setReplaceWith(NO_DATA_VALUE);
            op.setValidDataOperator(ops.get());
            op( hf.get() );
        }
    };
}

//------------------------------------------------------------------------

ElevationLayer::ElevationLayer( const ElevationLayerOptions& options ) :
TerrainLayer   ( options, &_runtimeOptions ),
_runtimeOptions( options )
{
    init();
}

ElevationLayer::ElevationLayer( const std::string& name, const TileSourceOptions& driverOptions ) :
TerrainLayer   ( ElevationLayerOptions(name, driverOptions), &_runtimeOptions ),
_runtimeOptions( ElevationLayerOptions(name, driverOptions) )
{
    init();
}

ElevationLayer::ElevationLayer( const ElevationLayerOptions& options, TileSource* tileSource ) :
TerrainLayer   ( options, &_runtimeOptions, tileSource ),
_runtimeOptions( options )
{
    init();
}

void
ElevationLayer::init()
{
    _tileSize = 32;
}

std::string
ElevationLayer::suggestCacheFormat() const
{
#if OSG_MIN_VERSION_REQUIRED(2,8,0)
        //OSG 2.8 onwards should use TIF for heightfields
        return "tif";
#else
        //OSG 2.8 and below should use DDS
        return "dds";
#endif
}

void
ElevationLayer::addCallback( ElevationLayerCallback* cb )
{
    _callbacks.push_back( cb );
}

void
ElevationLayer::removeCallback( ElevationLayerCallback* cb )
{
    ElevationLayerCallbackList::iterator i = std::find( _callbacks.begin(), _callbacks.end(), cb );
    if ( i != _callbacks.end() ) 
        _callbacks.erase( i );
}

void
ElevationLayer::fireCallback( TerrainLayerCallbackMethodPtr method )
{
    for( ElevationLayerCallbackList::const_iterator i = _callbacks.begin(); i != _callbacks.end(); ++i )
    {
        ElevationLayerCallback* cb = i->get();
        (cb->*method)( this );
    }
}

void
ElevationLayer::fireCallback( ElevationLayerCallbackMethodPtr method )
{
    for( ElevationLayerCallbackList::const_iterator i = _callbacks.begin(); i != _callbacks.end(); ++i )
    {
        ElevationLayerCallback* cb = i->get();
        (cb->*method)( this );
    }
}

void
ElevationLayer::initTileSource()
{
    // call superclass first.
    TerrainLayer::initTileSource();

    if ( _tileSource.valid() )
        _preCacheOp = new ElevationLayerPreCacheOperation( _tileSource.get() );
}


osg::HeightField*
ElevationLayer::createHeightFieldFromTileSource(const TileKey&    key,
                                                ProgressCallback* progress)
{
    osg::HeightField* result = 0L;

    TileSource* source = getTileSource();
    if ( !source )
        return 0L;

    // If the key is blacklisted, fail.
    if ( source->getBlacklist()->contains( key.getTileId() ) )
    {
        OE_DEBUG << LC << "Tile " << key.str() << " is blacklisted " << std::endl;
        return 0L;
    }

    // If the profiles are horizontally equivalent (different vdatums is OK), take the
    // quick route:
    if ( key.getProfile()->isHorizEquivalentTo( getProfile() ) )
    {
        // Only try to get data if the source actually has data
        if ( !source->hasData(key) )
        {
            OE_DEBUG << LC << "Source for layer has no data at " << key.str() << std::endl;
            return 0L;
        }

        // Make it from the source:
        result = source->createHeightField( key, _preCacheOp.get(), progress );

        // If the result is good, we how have a heightfield but it's vertical values
        // are still relative to the tile source's vertical datum. Convert them.
        if ( result )
        {
            if ( ! key.getExtent().getSRS()->isVertEquivalentTo( getProfile()->getSRS() ) )
            {
                VerticalDatum::transform(
                    getProfile()->getSRS()->getVerticalDatum(),    // from
                    key.getExtent().getSRS()->getVerticalDatum(),  // to
                    key.getExtent(),
                    result );
            }
        }
        
        // Blacklist the tile if it is the same projection as the source and we can't get it and it wasn't cancelled
        if ( !result && (!progress || !progress->isCanceled()))
        {
            source->getBlacklist()->add( key.getTileId() );
        }
    }

    // Otherwise, profiles don't match so we need to composite:
    else
    {
        // note: this method takes care of the vertical datum shift internally.
        result = assembleHeightFieldFromTileSource( key, progress );
    }

#if 0
    // If the profiles don't match, use a more complicated technique to assemble the tile:
    if ( !key.getProfile()->isEquivalentTo( getProfile() ) )
    {
        result = assembleHeightFieldFromTileSource( key, progress );
    }
    else
    {
        // Only try to get data if the source actually has data
        if ( !source->hasData( key ) )
        {
            OE_DEBUG << LC << "Source for layer has no data at " << key.str() << std::endl;
            return 0L;
        }

        // Make it from the source:
        result = source->createHeightField( key, _preCacheOp.get(), progress );
    }
#endif



    return result;
}


osg::HeightField*
ElevationLayer::assembleHeightFieldFromTileSource(const TileKey&    key,
                                                  ProgressCallback* progress)
{			
    osg::HeightField* result = 0L;

    // Collect the heightfields for each of the intersecting tiles.
    GeoHeightFieldVector heightFields;

    //Determine the intersecting keys
    std::vector< TileKey > intersectingTiles;
    getProfile()->getIntersectingTiles( key, intersectingTiles );

    // collect heightfield for each intersecting key. Note, we're hitting the
    // underlying tile source here, so there's no vetical datum shifts happening yet.
    // we will do that later.
    if ( intersectingTiles.size() > 0 )
    {
        for (unsigned int i = 0; i < intersectingTiles.size(); ++i)
        {
            const TileKey& layerKey = intersectingTiles[i];

            if ( isKeyValid(layerKey) )
            {
                osg::HeightField* hf = createHeightFieldFromTileSource( layerKey, progress );
                if ( hf )
                {
                    heightFields.push_back( GeoHeightField(hf, layerKey.getExtent()) );
                }
                else
                { 
                    //We couldn't get a heightfield at the given key so fall back on parent tiles
                    TileKey parentKey = layerKey.createParentKey();
                    while (!hf && parentKey.valid())
                    {
                        hf = createHeightFieldFromTileSource( parentKey, progress );
                        if (hf)
                        {
                            heightFields.push_back( GeoHeightField(hf, parentKey.getExtent()) );
                            break;
                        }                        
                        parentKey = parentKey.createParentKey();
                    }                    
                }
            }
        }
    }

    // If we actually got a HeightField, resample/reproject it to match the incoming TileKey's extents.
    if (heightFields.size() > 0)
    {		
        unsigned int width = 0;
        unsigned int height = 0;

        for (GeoHeightFieldVector::iterator itr = heightFields.begin(); itr != heightFields.end(); ++itr)
        {
            if (itr->getHeightField()->getNumColumns() > width)
                width = itr->getHeightField()->getNumColumns();
            if (itr->getHeightField()->getNumRows() > height) 
                height = itr->getHeightField()->getNumRows();
        }

        result = new osg::HeightField();
        result->allocate(width, height);

        //Go ahead and set up the heightfield so we don't have to worry about it later
        double minx, miny, maxx, maxy;
        key.getExtent().getBounds(minx, miny, maxx, maxy);
        double dx = (maxx - minx)/(double)(width-1);
        double dy = (maxy - miny)/(double)(height-1);

        //Create the new heightfield by sampling all of them.
        for (unsigned int c = 0; c < width; ++c)
        {
            double x = minx + (dx * (double)c);
            for (unsigned r = 0; r < height; ++r)
            {
                double y = miny + (dy * (double)r);

                //For each sample point, try each heightfield.  The first one with a valid elevation wins.
                float elevation = NO_DATA_VALUE;
                for (GeoHeightFieldVector::iterator itr = heightFields.begin(); itr != heightFields.end(); ++itr)
                {
                    // get the elevation value, at the same time transforming it vertically into the 
                    // requesting key's vertical datum.
                    float e = 0.0;
                    if (itr->getElevation(key.getExtent().getSRS(), x, y, INTERP_BILINEAR, key.getExtent().getSRS(), e))
                    {
                        elevation = e;
                        break;
                    }
                }
                result->setHeight( c, r, elevation );                
            }
        }
    }

    return result;
}


GeoHeightField
ElevationLayer::createHeightField(const TileKey&    key, 
                                  ProgressCallback* progress )
{
    osg::HeightField* result = 0L;

    // If the layer is disabled, bail out.
    if ( _runtimeOptions.enabled().isSetTo( false ) )
    {
        return GeoHeightField::INVALID;
    }

    CacheBin* cacheBin = getCacheBin( key.getProfile() );

    // validate that we have either a valid tile source, or we're cache-only.
    if ( ! (getTileSource() || (isCacheOnly() && cacheBin) ) )
    {
        OE_WARN << LC << "Error: layer does not have a valid TileSource, cannot create heightfield" << std::endl;
        _runtimeOptions.enabled() = false;
        return GeoHeightField::INVALID;
    }

    // validate the existance of a valid layer profile.
    if ( !isCacheOnly() && !getProfile() )
    {
        OE_WARN << LC << "Could not establish a valid profile" << std::endl;
        _runtimeOptions.enabled() = false;
        return GeoHeightField::INVALID;
    }

    // First, attempt to read from the cache. Since the cached data is stored in the
    // map profile, we can try this first.
    bool fromCache = false;
    if ( cacheBin && getCachePolicy().isCacheReadable() )
    {
        ReadResult r = cacheBin->readObject( key.str() );
        if ( r.succeeded() )
        {
            result = r.release<osg::HeightField>();
            if ( result )
                fromCache = true;
        }
    }

    // if we're cache-only, but didn't get data from the cache, fail silently.
    if ( !result && isCacheOnly() )
    {
        return GeoHeightField::INVALID;
    }

    if ( !result )
    {
        // bad tilesource? fail
        if ( !getTileSource() || !getTileSource()->isOK() )
            return GeoHeightField::INVALID;

        if ( !isKeyValid(key) )
            return GeoHeightField::INVALID;

        // build a HF from the TileSource.
        result = createHeightFieldFromTileSource( key, progress );
    }

    // cache if necessary
    if ( result        && 
         cacheBin      && 
         !fromCache    &&
         getCachePolicy().isCacheWriteable() )
    {
        cacheBin->write( key.str(), result );
    }

    if ( result )
    {
        // Set up the heightfield so we don't have to worry about it later
        double minx, miny, maxx, maxy;
        key.getExtent().getBounds(minx, miny, maxx, maxy);
        result->setOrigin( osg::Vec3d( minx, miny, 0.0 ) );
        double dx = (maxx - minx)/(double)(result->getNumColumns()-1);
        double dy = (maxy - miny)/(double)(result->getNumRows()-1);
        result->setXInterval( dx );
        result->setYInterval( dy );
        result->setBorderWidth( 0 );
    }

    return result ?
        GeoHeightField( result, key.getExtent() ) :
        GeoHeightField::INVALID;
}


//------------------------------------------------------------------------


bool
ElevationLayerVector::createHeightField(const TileKey&                  key,
                                        bool                            fallback,
                                        const Profile*                  haeProfile,
                                        ElevationInterpolation          interpolation,
                                        ElevationSamplePolicy           samplePolicy,
                                        osg::ref_ptr<osg::HeightField>& out_result,
                                        bool*                           out_isFallback,
                                        ProgressCallback*               progress )  const
{        
    unsigned lowestLOD = key.getLevelOfDetail();
    bool hfInitialized = false;

    //Get a HeightField for each of the enabled layers
    GeoHeightFieldVector heightFields;

    //The number of fallback heightfields we have
    int numFallbacks = 0;

    //Default to being fallback data.
    if ( out_isFallback )
    {
        *out_isFallback = true;
    }

    // if the caller provided an "HAE map profile", he wants an HAE elevation grid even if
    // the map profile has a vertical datum. This is the usual case when building the 3D
    // terrain, for example. Construct a temporary key that doesn't have the vertical
    // datum info and use that to query the elevation data.
    TileKey keyToUse = key;
    if ( haeProfile )
    {
        keyToUse = TileKey(key.getLevelOfDetail(), key.getTileX(), key.getTileY(), haeProfile );
    }

    // Generate a heightfield for each elevation layer.

    unsigned defElevSize = 8;

    for( ElevationLayerVector::const_iterator i = this->begin(); i != this->end(); i++ )
    {
        ElevationLayer* layer = i->get();
        if ( layer->getVisible() )
        {
            GeoHeightField geoHF = layer->createHeightField( keyToUse, progress );

            // if "fallback" is set, try to fall back on lower LODs.
            if ( !geoHF.valid() && fallback )
            {
                TileKey hf_key = keyToUse.createParentKey();

                while ( hf_key.valid() && !geoHF.valid() )
                {
                    geoHF = layer->createHeightField( hf_key, progress );
                    if ( !geoHF.valid() )
                        hf_key = hf_key.createParentKey();
                }

                if ( geoHF.valid() )
                {
                    if ( hf_key.getLevelOfDetail() < lowestLOD )
                        lowestLOD = hf_key.getLevelOfDetail();

                    //This HeightField is fallback data, so increment the count.
                    numFallbacks++;
                }
            }

            if ( geoHF.valid() )
            {
                heightFields.push_back( geoHF );
            }
        }
    }

    //If any of the layers produced valid data then it's not considered a fallback
    if ( out_isFallback )
    {
        *out_isFallback = (numFallbacks == heightFields.size());
        //OE_NOTICE << "Num fallbacks=" << numFallbacks << " numHeightFields=" << heightFields.size() << " is fallback " << *out_isFallback << std::endl;
    }   

    if ( heightFields.size() == 0 )
    {            
        //If we got no heightfields but were requested to fallback, create an empty heightfield.
        if ( fallback )
        {
            out_result = HeightFieldUtils::createReferenceHeightField( keyToUse.getExtent(), defElevSize, defElevSize );                
            return true;
        }
        else
        {
            //We weren't requested to fallback so just return.
            return false;
        }
    }

    else if (heightFields.size() == 1)
    {
        if ( lowestLOD == key.getLevelOfDetail() )
        {
            //If we only have on heightfield, just return it.
            out_result = heightFields[0].takeHeightField();
        }
        else
        {
            GeoHeightField geoHF = heightFields[0].createSubSample( key.getExtent(), interpolation);
            out_result = geoHF.takeHeightField();
            hfInitialized = true;
        }
    }

    else
    {
        //If we have multiple heightfields, we need to composite them together.
        unsigned int width = 0;
        unsigned int height = 0;

        for (GeoHeightFieldVector::const_iterator i = heightFields.begin(); i < heightFields.end(); ++i)
        {
            if (i->getHeightField()->getNumColumns() > width) 
                width = i->getHeightField()->getNumColumns();
            if (i->getHeightField()->getNumRows() > height) 
                height = i->getHeightField()->getNumRows();
        }
        out_result = new osg::HeightField();
        out_result->allocate( width, height );

        //Go ahead and set up the heightfield so we don't have to worry about it later
        double minx, miny, maxx, maxy;
        key.getExtent().getBounds(minx, miny, maxx, maxy);
        double dx = (maxx - minx)/(double)(out_result->getNumColumns()-1);
        double dy = (maxy - miny)/(double)(out_result->getNumRows()-1);

        const SpatialReference* keySRS = keyToUse.getProfile()->getSRS();

        //Create the new heightfield by sampling all of them.
        for (unsigned int c = 0; c < width; ++c)
        {
            double x = minx + (dx * (double)c);
            for (unsigned r = 0; r < height; ++r)
            {
                double y = miny + (dy * (double)r);

                //Collect elevations from all of the layers. Iterate BACKWARDS because the last layer
                // is the highest priority.
                std::vector<float> elevations;
                for( GeoHeightFieldVector::reverse_iterator itr = heightFields.rbegin(); itr != heightFields.rend(); ++itr )
                {
                    const GeoHeightField& geoHF = *itr;

                    float elevation = 0.0f;
                    if ( geoHF.getElevation(keySRS, x, y, interpolation, keySRS, elevation) )
                    {
                        if (elevation != NO_DATA_VALUE)
                        {
                            elevations.push_back(elevation);
                        }
                    }
                }

                float elevation = NO_DATA_VALUE;

                //The list of elevations only contains valid values
                if (elevations.size() > 0)
                {
                    if (samplePolicy == SAMPLE_FIRST_VALID)
                    {
                        elevation = elevations[0];
                    }
                    else if (samplePolicy == SAMPLE_HIGHEST)
                    {
                        elevation = -FLT_MAX;
                        for (unsigned int i = 0; i < elevations.size(); ++i)
                        {
                            if (elevation < elevations[i]) elevation = elevations[i];
                        }
                    }
                    else if (samplePolicy == SAMPLE_LOWEST)
                    {
                        elevation = FLT_MAX;
                        for (unsigned i = 0; i < elevations.size(); ++i)
                        {
                            if (elevation > elevations[i]) elevation = elevations[i];
                        }
                    }
                    else if (samplePolicy == SAMPLE_AVERAGE)
                    {
                        elevation = 0.0;
                        for (unsigned i = 0; i < elevations.size(); ++i)
                        {
                            elevation += elevations[i];
                        }
                        elevation /= (float)elevations.size();
                    }
                }
                out_result->setHeight(c, r, elevation);
            }
        }
    }

    // Replace any NoData areas with the reference value. This is zero for HAE datums,
    // and some geoid height for orthometric datums.
    if (out_result.valid())
    {
        const Geoid*         geoid = 0L;
        const VerticalDatum* vdatum = key.getProfile()->getSRS()->getVerticalDatum();

        if ( haeProfile && vdatum )
        {
            geoid = vdatum->getGeoid();
        }

        HeightFieldUtils::resolveInvalidHeights(
            out_result.get(),
            key.getExtent(),
            NO_DATA_VALUE,
            geoid );

        //ReplaceInvalidDataOperator o;
        //o.setValidDataOperator(new osgTerrain::NoDataValue(NO_DATA_VALUE));
        //o( out_result.get() );
    }

    //Initialize the HF values for osgTerrain
    if (out_result.valid() && !hfInitialized )
    {   
        //Go ahead and set up the heightfield so we don't have to worry about it later
        double minx, miny, maxx, maxy;
        key.getExtent().getBounds(minx, miny, maxx, maxy);
        out_result->setOrigin( osg::Vec3d( minx, miny, 0.0 ) );
        double dx = (maxx - minx)/(double)(out_result->getNumColumns()-1);
        double dy = (maxy - miny)/(double)(out_result->getNumRows()-1);
        out_result->setXInterval( dx );
        out_result->setYInterval( dy );
        out_result->setBorderWidth( 0 );
    }

    return out_result.valid();
}
