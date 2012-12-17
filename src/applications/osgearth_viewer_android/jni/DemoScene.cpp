//
//  DemoScene.cpp
//  osgearthDemos
//

#include "DemoScene.h"

#include <osgViewer/api/IOS/GraphicsWindowIOS>
#include "OsgAndroidNotifyHandler.hpp"

DemoScene::DemoScene()
    :osg::Referenced()
{
    
}

DemoScene::~DemoScene()
{
    
}

void DemoScene::init(const std::string& file, osg::Vec2 viewSize, UIView* view)
{
    //osgEarth::Registry::instance()->setDefaultTerrainEngineDriverName("quadtree");

	OsgAndroidNotifyHandler* notifyHandler = new OsgAndroidNotifyHandler();
	notifyHandler->setTag("osgEarth Viewer");
    osg::setNotifyHandler(notifyHandler);
    osgEarth::setNotifyHandler(notifyHandler);

    osg::setNotifyLevel(osg::INFO);
    osgEarth::setNotifyLevel(osg::INFO);
    
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
	traits->windowDecoration = false;
	traits->doubleBuffer = true;
	traits->sharedContext = 0;
	traits->setInheritedWindowPixelFormat = true;
    
	osg::ref_ptr<osg::Referenced> windata = new osgViewer::GraphicsWindowIOS::WindowData(view, osgViewer::GraphicsWindowIOS::WindowData::PORTRAIT_ORIENTATION, scale);
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
    _viewer->getCamera()->setClearColor(osg::Vec4(1.0f,0.0f,0.0f,0.0f));
    //_viewer->getCamera()->setComputeNearFarMode(osg::CullSettings::COMPUTE_NEAR_FAR_USING_PRIMITIVES);
    _viewer->getCamera()->setProjectionMatrixAsPerspective(45.0f,(float)viewSize.x()/viewSize.y(),
                                                           0.1, 1000.0);
    
    //
    _viewer->getEventQueue()->getCurrentEventState()->setMouseYOrientation(osgGA::GUIEventAdapter::Y_INCREASING_UPWARDS);
    
    // configure the near/far so we don't clip things that are up close
    _viewer->getCamera()->setNearFarRatio(0.00002);
    
    //optimize viewer and db pager
    _viewer->setThreadingModel(osgViewer::ViewerBase::SingleThreaded);
    _viewer->getCamera()->setLODScale(_viewer->getCamera()->getLODScale()*1.5);
    
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
    if (_viewer->getRunFrameScheme() == osgViewer::ViewerBase::CONTINUOUS ||
        _viewer->checkNeedToDoFrame() )
    {
        _viewer->frame();
    }else{

    }
}
