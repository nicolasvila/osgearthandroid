
#ifndef CLAMPOBJECTLOCATORCALLBACK_H_
#define CLAMPOBJECTLOCATORCALLBACK_H_

#include <osgEarth/Terrain>
#include <osgEarthUtil/ObjectLocator>

class ClampObjectLocatorCallback: public osgEarth::TerrainCallback{
public:
	ClampObjectLocatorCallback(osgEarth::Util::ObjectLocatorNode* locator);
	virtual void onTileAdded(const osgEarth::TileKey& tileKey, osg::Node* terrain, osgEarth::TerrainCallbackContext&);

    osg::ref_ptr< osgEarth::Util::ObjectLocatorNode > _locator;
    int _maxLevel;
    int _minLevel;
    float _alt;
};

#endif /* CLAMPOBJECTLOCATORCALLBACK_H_ */
