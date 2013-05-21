#include "ClampObjectLocatorCallback.h"


ClampObjectLocatorCallback::ClampObjectLocatorCallback(osgEarth::Util::ObjectLocatorNode* locator){
	_locator = locator;
	_maxLevel = -1;
	_minLevel = 0;
	_alt = locator->getLocator()->getPosition().z();
}

void ClampObjectLocatorCallback::onTileAdded(const osgEarth::TileKey& tileKey, osg::Node* terrain, osgEarth::TerrainCallbackContext&){
	if ((int)tileKey.getLevelOfDetail() > _minLevel && _maxLevel < (int)tileKey.getLevelOfDetail()){
		osg::Vec3d position = _locator->getLocator()->getPosition();

		if (tileKey.getExtent().contains(position.x(), position.y())){
			//Compute our location in geocentric
			const osg::EllipsoidModel* ellipsoid = tileKey.getProfile()->getSRS()->getEllipsoid();
			double x, y, z;
			ellipsoid->convertLatLongHeightToXYZ(
					osg::DegreesToRadians(position.y()), osg::DegreesToRadians(position.x()), 0.0f,
					x, y, z);
			//Compute the up vector
			osg::Vec3d up = ellipsoid->computeLocalUpVector(x, y, z );
			up.normalize();
			osg::Vec3d world(x, y, z);

			double segOffset = 50000;

			osg::Vec3d start = world + (up * segOffset);
			osg::Vec3d end = world - (up * segOffset);

			osgUtil::LineSegmentIntersector* i = new osgUtil::LineSegmentIntersector( start, end );

			osgUtil::IntersectionVisitor iv;
			iv.setIntersector( i );
			terrain->accept( iv );

			osgUtil::LineSegmentIntersector::Intersections& results = i->getIntersections();
			if ( !results.empty() ){
				const osgUtil::LineSegmentIntersector::Intersection& result = *results.begin();
				osg::Vec3d hit = result.getWorldIntersectPoint();
				double lat, lon, height;

				ellipsoid->convertXYZToLatLongHeight(hit.x(), hit.y(), hit.z(), lat, lon, height);
				position.z() = height + _alt;

				_maxLevel = tileKey.getLevelOfDetail();
				_locator->getLocator()->setPosition( position );
			}
		}
	}

}
