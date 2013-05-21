/*
 * GeoCylinder.h
 *
 *  Created on: 2 de Nov de 2012
 *      Author: paulo
 */

#ifndef GEOCYLINDER_H_
#define GEOCYLINDER_H_

#include "GeoShapes.h"

class GeoCylinder: public GeoShapes {
public:
	GeoCylinder();
	GeoCylinder(osgEarth::Map* map, osg::Quat quat, osg::Vec3 center, osg::Vec4 color, float radius, float height);

	virtual ~GeoCylinder();

};

#endif /* GEOCYLINDER_H_ */
