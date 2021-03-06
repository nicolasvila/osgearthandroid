#include "KMLNodeInfo"

KMLNodeInfo::KMLNodeInfo(){
	_layer = "";
	_id = "";
	_position = osg::Vec3();
	_description = "";
}

KMLNodeInfo::KMLNodeInfo(std::string layer, std::string id, osg::Vec3 position, std::string description){
	_layer = layer;
	_id = id;
	_position = position;
	_description = description;
}

std::string KMLNodeInfo::getLayer(){
	return _layer;
}

void KMLNodeInfo::setLayer(std::string layer){
	_layer = layer;
}

std::string KMLNodeInfo::getId(){
	return _id;
}

osg::Vec3 KMLNodeInfo::getPosition(){
	return _position;
}

std::string KMLNodeInfo::getDescription(){
	return _description;
}

KMLNodeInfo::~KMLNodeInfo(){}

