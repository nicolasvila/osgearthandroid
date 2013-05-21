#include "GeoNode"

GeoNode::GeoNode(osgEarth::GeoExtent bounds, osg::ref_ptr<osg::Node> node, bool inGraph){
	_bounds = bounds;
	_node = node;
	_inGraph = inGraph;
	_toRemove = false;
}

osgEarth::GeoExtent GeoNode::getBounds(){
	return _bounds;
}

osg::ref_ptr<osg::Node> GeoNode::getNode(){
	return _node;
}

bool GeoNode::inGraph(){
	return _inGraph;
}

bool GeoNode::toRemove(){
	return _toRemove;
}

void GeoNode::setToRemove(bool toRemove){
	_toRemove = toRemove;
}

void GeoNode::setInGraph(bool inGraph){
	_inGraph = inGraph;
}

GeoNode::~GeoNode(){}
