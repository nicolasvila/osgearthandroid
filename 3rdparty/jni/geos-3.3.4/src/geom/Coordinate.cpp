/**********************************************************************
 * $Id: Coordinate.cpp 3521 2011-11-29 14:01:25Z strk $
 *
 * GEOS - Geometry Engine Open Source
 * http://geos.refractions.net
 *
 * Copyright (C) 2001-2002 Vivid Solutions Inc.
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the GNU Lesser General Public Licence as published
 * by the Free Software Foundation. 
 * See the COPYING file for more information.
 *
 **********************************************************************/

#include <geos/geom/Coordinate.h>
#include <cmath>
#include <geos/platform.h> // for isnan

#include <sstream>
#include <string>
#include <iomanip>

#ifndef GEOS_INLINE
# include <geos/geom/Coordinate.inl>
#endif

namespace geos {
namespace geom { // geos::geom

Coordinate Coordinate::nullCoord=Coordinate(DoubleNotANumber,DoubleNotANumber,DoubleNotANumber);

Coordinate&
Coordinate::getNull()
{
	return nullCoord;
}

std::string
Coordinate::toString() const
{
	std::ostringstream s;
	s << std::setprecision(17) << *this;
	return s.str();
}

std::ostream& operator<< (std::ostream& os, const Coordinate& c)
{
	if ( isnan(c.z) )
	{
		os << c.x << " " << c.y;
	} else {
		os << c.x << " " << c.y << " " << c.z;
	}
	return os;
}

} // namespace geos::geom
} // namespace geos

