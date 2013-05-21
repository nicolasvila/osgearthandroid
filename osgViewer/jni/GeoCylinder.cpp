/*
 * GeoCylinder.cpp
 *
 *  Created on: 2 de Nov de 2012
 *      Author: paulo
 */

#include "GeoCylinder.h"

GeoCylinder::GeoCylinder() {
	osg::ref_ptr<osg::ShapeDrawable> shape = new osg::ShapeDrawable;
	shape->setShape(new osg::Cylinder(osg::Vec3(0.0f, 0.0f, 0.0f), 1.0f, 5.0f));
	shape->setColor(osg::Vec4(0.0f, 1.0f, 0.0f, 1.0f));
	_shape = shape;
	_map = new osgEarth::Map;
}

GeoCylinder::GeoCylinder(osgEarth::Map* map, osg::Quat rotat, osg::Vec3 center, osg::Vec4 color, float radius, float height){
	osg::ref_ptr<osg::ShapeDrawable> shape = new osg::ShapeDrawable;
	osg::Cylinder* c = new osg::Cylinder(center, radius, height);
	c->setRotation(rotat);
	shape.get()->setShape(c);
	shape.get()->setColor(color);
	_shape = shape;
	_map = map;
}

GeoCylinder::~GeoCylinder() {
	_shape.release();
	_locatorNode.release();
}
