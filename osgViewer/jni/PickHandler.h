#ifndef PICKHANDLER_CLASS_H
#define PICKHANDLER_CLASS_H

#include <osg/Node>
#include <osgViewer/Viewer>

#include <osgEarth/Pickers>

#include <jni.h>

class PickHandler : public osgGA::GUIEventHandler{
	public:
		PickHandler(osg::ref_ptr<osg::Node> root, JNIEnv * env, jobject gjo, osgViewer::Viewer* viewer);
		virtual bool handle( const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa );

	protected:
		osg::ref_ptr<osg::Node> _root;
		JNIEnv* _genv;
		jobject _gjo;
		osgViewer::Viewer* _viewer;
};

#endif
