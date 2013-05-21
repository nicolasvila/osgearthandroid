/*
 * GeoShapes.cpp
 *
 *  Created on: 2 de Nov de 2012
 *      Author: paulo
 */

#include "GeoShapes.h"
#include "ClampObjectLocatorCallback.h"

GeoShapes::GeoShapes() {
	osg::ref_ptr<osg::ShapeDrawable> shape = new osg::ShapeDrawable;
	_shape = shape;
	osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> locatorNode = new osgEarth::Util::ObjectLocatorNode;
	_locatorNode = locatorNode;
	_map = new osgEarth::Map;
}

GeoShapes::~GeoShapes() {
	_shape.release();
	_locatorNode.release();
}

osg::ref_ptr<osg::ShapeDrawable> GeoShapes::getShape(){return _shape;}
void GeoShapes::setShape(osg::ref_ptr<osg::ShapeDrawable> shape){_shape = shape;}

osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> GeoShapes::getLocator(){return _locatorNode;}
void GeoShapes::setLocator(osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> locatorNode){_locatorNode = locatorNode;}

void GeoShapes::setPosition(osg::Vec3 position){
	osg::ref_ptr<osgEarth::Util::ObjectLocatorNode> locatorNode = new osgEarth::Util::ObjectLocatorNode(_map);
	locatorNode.get()->getLocator()->setPosition(position);
	_locatorNode = locatorNode;
}

void GeoShapes::placeInWorld(osg::ref_ptr<osgEarth::MapNode> mapNode){
	osg::ref_ptr<osg::Geode> geode = new osg::Geode;
	geode->addDrawable(_shape.get());

	//   Set the material of this shape
	osg::ref_ptr<osg::Material> pMaterial = new osg::Material;
	pMaterial->setDiffuse(osg::Material::FRONT, _shape->getColor());
	geode->getOrCreateStateSet()->setAttribute( pMaterial, osg::StateAttribute::OVERRIDE );

	_locatorNode->addChild(geode);

	mapNode->addChild(_locatorNode);
	mapNode->getTerrain()->addTerrainCallback( new ClampObjectLocatorCallback(_locatorNode) );
}
