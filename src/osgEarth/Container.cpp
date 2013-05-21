#include <osgEarth/Container>

#define LC "[Container]"

Container::Container(osgEarth::MapNode* mapNode){
	_mapNode = mapNode;
}

osgEarth::MapNode* Container::getMapNode(){
	return _mapNode;
}

Container::~Container(){}
