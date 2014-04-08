#include "DemoScene.h"

#include <osgDB/Registry>

#include <osgEarthDrivers/wms/WMSOptions>
#include <osgEarthDrivers/tms/TMSOptions>
#include <osgEarthDrivers/xyz/XYZOptions>
#include <osgEarthDrivers/kml/KMLNodeInfo>

#include <osgEarth/ImageLayer>

#include <cmath>

#ifndef ANDROID
#include <osgViewer/api/IOS/GraphicsWindowIOS>
#else
#include <osgEarth/AndroidCapabilities>
#endif
#include "OsgAndroidNotifyHandler.hpp"

DemoScene::DemoScene(JNIEnv * env, jobject gjo)
    :osg::Referenced()
{
    _genv = env;
    _gjo = gjo;

    _gles2ShaderGen = new osgUtil::GLES2ShaderGenVisitor();
}

DemoScene::~DemoScene()
{
    
}

void DemoScene::addModel(std::string address){
	osgEarth::Util::MapNode* mapNode = this->getMapNode();
	if( mapNode )
	{
		osgDB::Options* opt = new osgDB::Options;
		osg::ref_ptr<osg::Node> nodekml = osgEarth::Drivers::KML::load( osgEarth::URI( address ), mapNode,
				opt, *_kml_options );

		osgEarth::GeoExtent bounds;
		_changesQueue->put( "user", bounds, nodekml );

		osg::Group* asGroup = nodekml.get()->asGroup();
		bool found = false;
		for( int i = 0; i < asGroup->getNumChildren() && !found; i++ )
		{
			KMLNodeInfo* ni = dynamic_cast<KMLNodeInfo*>(
					asGroup->getChild( i )->asGroup()->getUserData() );
			if ( ni )
			{
				_manip->setViewpoint( osgEarth::Viewpoint( osg::Vec3d( ni->getPosition().x(),
						ni->getPosition().y(), 0.0 ), 0.0, -45.0, 50 ), 15.0f);
				found = true;
			}
		}
	}
}

void DemoScene::setBaseLayerWMS(std::string url)
{
	osgEarth::Util::MapNode* mapNode = this->getMapNode();

	if( mapNode )
	{
		osgEarth::ImageLayerVector layers;
		mapNode->getMap()->getImageLayers(layers);

		for( osgEarth::ImageLayerVector::const_iterator it = layers.begin(); it != layers.end(); ++it )
		{
			if( ((*it)->getTerrainLayerRuntimeOptions().name()).compare("BASE") == 0 )
				mapNode->getMap()->removeImageLayer( (*it).get() );
		}

		osgEarth::Drivers::WMSOptions wms;
		wms.url() = url;
		osgEarth::ImageLayer* layer = new osgEarth::ImageLayer( "BASE", wms );
		mapNode->getMap()->addImageLayer( layer );

		_gles2ShaderGen->apply(*mapNode);

		OE_WARN << "DemoScene::setBaseLayerWMS	" << url << std::endl;
	}
}

void DemoScene::setBaseLayerTMS( std::string url )
{
	osgEarth::Util::MapNode* mapNode = this->getMapNode();

	if( mapNode )
	{
		osgEarth::ImageLayerVector layers;
		mapNode->getMap()->getImageLayers(layers);

		for( osgEarth::ImageLayerVector::const_iterator it = layers.begin(); it != layers.end(); ++it )
		{
			OE_NOTICE << "DEBUG: " << (*it)->getTerrainLayerRuntimeOptions().name() << std::endl;
			if( ((*it)->getTerrainLayerRuntimeOptions().name()).compare("BASE") == 0 )
				mapNode->getMap()->removeImageLayer( (*it).get() );
		}

		osgEarth::Drivers::TMSOptions tms;
		tms.url() = url;
		osgEarth::ImageLayer* layer = new osgEarth::ImageLayer( "BASE", tms );
		mapNode->getMap()->addImageLayer( layer );

		_gles2ShaderGen->apply(*mapNode);

		OE_WARN << "DemoScene::setBaseLayerTMS	" << url << std::endl;
	}
}

void DemoScene::setBaseLayerXYZ(std::string url)
{
	osgEarth::Util::MapNode* mapNode = this->getMapNode();

	if( mapNode )
	{
		osgEarth::ImageLayerVector layers;
		mapNode->getMap()->getImageLayers(layers);

		for( osgEarth::ImageLayerVector::const_iterator it = layers.begin(); it != layers.end(); ++it )
		{
			OE_NOTICE << "DEBUG: " << (*it)->getTerrainLayerRuntimeOptions().name() << std::endl;
			if( ((*it)->getTerrainLayerRuntimeOptions().name()).compare("BASE") == 0 )
				mapNode->getMap()->removeImageLayer( (*it).get() );
		}

		osgEarth::Drivers::XYZOptions xyz;
		xyz.url() = url;
		//xyz.profile() = "spherical-mercator";
		osgEarth::ImageLayer* layer = new osgEarth::ImageLayer( "BASE", xyz );
		mapNode->getMap()->addImageLayer( layer );

		_gles2ShaderGen->apply(*mapNode);

		OE_WARN << "DemoScene::setBaseLayerXYZ	" << url << std::endl;
	}
}

void DemoScene::removeLayer( std::string name )
{
	OE_NOTICE <<"DEBUG: addLayer->" << name << std::endl;
	osgEarth::Util::MapNode* mapNode = this->getMapNode();

	if( mapNode )
	{
		osgEarth::ImageLayerVector layers;
		mapNode->getMap()->getImageLayers(layers);

		for( osgEarth::ImageLayerVector::const_iterator it = layers.begin(); it != layers.end(); ++it )
		{
			OE_NOTICE << "DEBUG: " << (*it)->getTerrainLayerRuntimeOptions().name() << std::endl;
			if( ((*it)->getTerrainLayerRuntimeOptions().name()).compare(name) == 0 )
				mapNode->getMap()->removeImageLayer( (*it).get() );
		}
		_changesQueue->cleanNodes(name);
	}
}

void DemoScene::addLayer( std::string url, std::string layer, std::string style, int minLevel )
{
	OE_NOTICE << "DEBUG: addLayer->" << layer << std::endl;
    osgEarth::Drivers::WMSOptions wms;
    wms.url() = url;
    wms.layers() = layer;
    wms.format() = "kml";
    wms.style() = style;
    wms.tileSize() = 256;
    wms.mapNode() = (void*) (_mapNode.get());
    wms.kmlOptions() = (void*) (_kml_options);

    wms.root() = (void*) (_root.get());

    osgEarth::ImageLayerOptions* imgLayerOpt = new osgEarth::ImageLayerOptions(layer, wms);
    imgLayerOpt->minLevel() = minLevel;

    osgEarth::ImageLayer* newlayer = new osgEarth::ImageLayer( *imgLayerOpt );
    _mapNode->getMap()->addImageLayer( newlayer );
}

void DemoScene::onMove( float x, float y )
{
	osgEarth::Util::EarthManipulator* manip =
			dynamic_cast<osgEarth::Util::EarthManipulator*>(_viewer->getCameraManipulator());

	if( manip )
	{
		osg::Vec3d out;
		bool valid = manip->screenToWorld(x, y, _viewer, out );

		if( valid )
		{
			osgEarth::Util::MapNode* mapNode = this->getMapNode();
			osg::Vec3d outll;
			mapNode->getMap()->getSRS()->transformFromWorld(out, outll);

			if( abs(outll.z()) < 500 )
			{
				_changesQueue->onMove( outll, 2000, mapNode->getMap()->getSRS() );
			}
		}
	}
}

void DemoScene::init(const std::string& file, osg::Vec2 viewSize, UIView* view)
{
	OsgAndroidNotifyHandler* notifyHandler = new OsgAndroidNotifyHandler();
	notifyHandler->setTag("osgEarth Viewer");
    osg::setNotifyHandler(notifyHandler);
    osgEarth::setNotifyHandler(notifyHandler);

    osg::setNotifyLevel(osg::INFO);
    osgEarth::setNotifyLevel(osg::INFO);

    osgDB::Registry::instance()->addMimeTypeExtensionMapping("vnd.google-earth.kml+xml", "kml");
    //osgEarth::Registry::instance()->setDefaultTerrainEngineDriverName("quadtree");
    osgEarth::Registry::instance()->setDefaultTerrainEngineDriverName("mp");
	//osgEarth::Registry::instance()->setCapabilities(new osgEarth::AndroidCapabilities());

    //create the viewer
	_viewer = new osgViewer::Viewer();
    
#ifndef ANDROID
    UIScreen* screen = [UIScreen mainScreen];
    float scale = 1.0f;
#if defined(__IPHONE_4_0) && (__IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0)
    scale = [screen scale];
#endif
    
	osg::ref_ptr<osg::GraphicsContext::Traits> traits = new osg::GraphicsContext::Traits;
    
	// Setup the traits parameters
	traits->x = 0;
	traits->y = 0;
	traits->width = viewSize.x();
	traits->height = viewSize.y();
	traits->depth = 24; //keep memory down, default is currently 24
	traits->alpha = 8;
    traits->samples = 4;
    traits->sampleBuffers = 2;
	traits->stencil = 0;
	traits->windowDecoration = true;
	traits->doubleBuffer = true;
	traits->sharedContext = 0;
	traits->setInheritedWindowPixelFormat = true;
    
	osg::ref_ptr<osg::Referenced> windata = new osgViewer::GraphicsWindowIOS::WindowData( view,
			osgViewer::GraphicsWindowIOS::WindowData::PORTRAIT_ORIENTATION, scale);
	traits->inheritedWindowData = windata;
    
	// Create the Graphics Context
	osg::ref_ptr<osg::GraphicsContext> graphicsContext = osg::GraphicsContext::createGraphicsContext(traits.get());
	
	if(graphicsContext)
	{
        _viewer->getCamera()->setGraphicsContext(graphicsContext);
    }
    
#else
    _viewer->setUpViewerAsEmbeddedInWindow(0, 0, viewSize.x(), viewSize.y());
#endif
    
    
    _viewer->getCamera()->setViewport(new osg::Viewport(0, 0, viewSize.x(), viewSize.y()));
    _viewer->getCamera()->setClearMask(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    _viewer->getCamera()->setClearColor(osg::Vec4(0.098f,0.098f,0.439f,1.0f));
    //_viewer->getCamera()->setComputeNearFarMode(osg::CullSettings::COMPUTE_NEAR_FAR_USING_PRIMITIVES);
    _viewer->getCamera()->setProjectionMatrixAsPerspective(45.0f,(float)viewSize.x()/viewSize.y(),
                                                           0.1, 1000.0);

    _viewer->getEventQueue()->getCurrentEventState()->setMouseYOrientation(osgGA::GUIEventAdapter::Y_INCREASING_UPWARDS);
    
    // configure the near/far so we don't clip things that are up close
    _viewer->getCamera()->setNearFarRatio(0.00002);
    
    //optimize viewer and db pager
    _viewer->setThreadingModel(osgViewer::ViewerBase::SingleThreaded);
    _viewer->getCamera()->setLODScale(_viewer->getCamera()->getLODScale()*1.0);
    
    // osgEarth benefits from pre-compilation of GL objects in the pager. In newer versions of
    // OSG, this activates OSG's IncrementalCompileOpeartion in order to avoid frame breaks.
    _viewer->getDatabasePager()->setIncrementalCompileOperation(new osgUtil::IncrementalCompileOperation());
    _viewer->getDatabasePager()->setDoPreCompile( true );
    _viewer->getDatabasePager()->setTargetMaximumNumberOfPageLOD(0);
    _viewer->getDatabasePager()->setUnrefImageDataAfterApplyPolicy(true,true);
    _viewer->setRunFrameScheme( osgViewer::ViewerBase::ON_DEMAND );
    
    //init scene
    this->initDemo(file);
}

void DemoScene::frame()
{
	std::cout << "FrameNumber: " << _viewer->getViewerFrameStamp()->getFrameNumber() << std::endl;
    if (_viewer->getRunFrameScheme() == osgViewer::ViewerBase::CONTINUOUS ||
        _viewer->checkNeedToDoFrame() )
    {
        _viewer->frame();
    }else{

    }
}
