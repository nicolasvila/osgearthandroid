#include <osgEarth/EntityCache>

#define LC "[EntityCache]"

EntityCache::EntityCache(){
	_description = std::string("DEFAULT DESCRIPTION");
}

EntityCache::EntityCache(std::string description){
	_description = description;
}

bool EntityCache::insert(std::string key, osg::Node* node, osg::Vec3 pos){
	_mapEntity.insert( std::pair<std::string, osg::Node*>( key, node) );
	_mapPosition.insert( std::pair<std::string, osg::Vec3>( key, pos) );
	return true;
}

osg::Node* EntityCache::get(std::string key){
	std::map<std::string, osg::Node*>::iterator it;

	it = _mapEntity.find(key);

	if(it != _mapEntity.end()) return it->second;
	return NULL;
}

bool EntityCache::existsInPosition(std::string key, osg::Vec3 pos){
	std::map<std::string, osg::Vec3>::iterator it;

	it = _mapPosition.find(key);

	if(it != _mapPosition.end()){
		return it->second == pos;
	}
	return false;
}

bool EntityCache::exists(std::string key){
	if( _mapEntity.count(key) > 0 ) return true;
	return false;
}

std::string EntityCache::getDescription(){
	return _description;
}

int EntityCache::remove(std::string key){
	_mapPosition.erase(key);
	return _mapEntity.erase(key);
}

EntityCache::~EntityCache(){
	_mapEntity.~map();
	_mapPosition.~map();
}
