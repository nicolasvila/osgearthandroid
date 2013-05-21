/*
 * GeoShapes.h
 *
 *  Created on: 2 de Nov de 2012
 *      Author: paulo
 */

#ifndef GEOSHAPES_H_
#define GEOSHAPES_H_

#include <osg/ShapeDrawable>

#include <osgEarthUtil/ExampleResources>
#include <osgEarthUtil/ObjectLocator>

class GeoShapes {
public:
	GeoShapes();
	void setShape(osg::ref_ptr<osg::ShapeDrawable> shape);
	osg::ref_ptr<osg::ShapeDrawable> getShape();
	void setLocator(osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> locatorNode);
	osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> getLocator();
	void setPosition(osg::Vec3 position);
	void setCenter(osg::Vec3 center);
	void placeInWorld(osg::ref_ptr<osgEarth::MapNode> mapNode);

	virtual ~GeoShapes();

protected:
	osg::ref_ptr<osg::ShapeDrawable> _shape;
	osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> _locatorNode;
	osgEarth::Map* _map;
};

#endif /* GEOSHAPES_H_ */
