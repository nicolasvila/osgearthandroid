#include "PickHandler.h"

#include <osgViewer/Viewer>

#include <osgEarthAnnotation/PlaceNode>
#include <osgEarthAnnotation/LabelNode>
#include <osgEarthAnnotation/LocalGeometryNode>
#include <osgEarthAnnotation/FeatureNode>
#include <osgEarthAnnotation/ModelNode>

#include <osgEarthUtil/ObjectLocator>

#include <osgEarthDrivers/kml/KMLNodeInfo>

#include <osg/MatrixTransform>
#include <osg/ShapeDrawable>
#include <osg/PolygonMode>
#include <osgFX/Scribe>
#include <osgFX/Outline>
#include <osg/BoundingSphere>
#include <osg/CopyOp>

#include <jni.h>


PickHandler::PickHandler(osg::ref_ptr<osg::Node> root, JNIEnv * env, jobject gjo, osgViewer::Viewer* viewer){
	_root = root;
	_genv = env;
	_gjo = gjo;
	_viewer = viewer;
}

bool PickHandler::handle( const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa ){
	if (	ea.getEventType()!=osgGA::GUIEventAdapter::RELEASE ||
			ea.getButton()!=osgGA::GUIEventAdapter::LEFT_MOUSE_BUTTON||
			!(ea.getModKeyMask()&osgGA::GUIEventAdapter::MODKEY_CTRL))	return false;

	OE_NOTICE << "We're picking" << std::endl;
	osgViewer::Viewer* viewer = dynamic_cast<osgViewer::Viewer*>(&aa);

	if ( viewer ){
		float x = ea.getX();
		float y = ea.getY();
		osgEarth::Picker picker(viewer, _root);
		osgEarth::Picker::Hits hits;

		if (picker.pick(x, y, hits)){
			for(osgEarth::Picker::Hits::const_iterator h = hits.begin(); h != hits.end(); ++h){
				osgEarth::Util::ObjectLocatorNode* geo = picker.getNode<osgEarth::Util::ObjectLocatorNode>(*h);
				if(geo && geo->getNodeInfo()){
					jclass clazz = _genv->FindClass("osgearth/Common/osgNativeLib");
					if (!clazz) {
						OE_WARN << "[PickHandler]\tJNI getClass error." << std::endl;
						return true;
					}
					jmethodID method = _genv->GetStaticMethodID(clazz, "displayInfo",
							"(Ljava/lang/String;Ljava/lang/String;DDLjava/lang/String;)V");
					if (!method) {
						OE_WARN << "[PickHandler]\tJNI getMethod error." << std::endl;
						return true;
					}
					jstring layer = _genv->NewStringUTF(geo->getNodeInfo()->getLayer().c_str());
					jstring id = _genv->NewStringUTF(geo->getNodeInfo()->getId().c_str());
					jstring description = _genv->NewStringUTF(geo->getNodeInfo()->getDescription().c_str());
					_genv->CallStaticVoidMethod( _gjo, method, layer, id, geo->getLocator()->getPosition().y(),
							geo->getLocator()->getPosition().x(), description );

					return true;
				}
			}
		}
	}
	else OE_NOTICE << "Unable to find viewer" << std::endl;
	return false;
}
