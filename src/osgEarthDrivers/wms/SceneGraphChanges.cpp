#include "SceneGraphChanges"

#include <osgEarth/Notify>
#include <osgEarth/GeoMath>

SceneGraphChanges::SceneGraphChanges(){
	std::map< std::string, std::list< GeoNode* > > _nodeMap;
	std::list<std::string> _layersToRemove;
}

void SceneGraphChanges::put(std::string layer, osgEarth::GeoExtent bounds, osg::ref_ptr<osg::Node> node){
	checkRemove();
	if(!toRemove(layer)){
		GeoNode* gn = new GeoNode(bounds, node, false);
		std::map< std::string, std::list< GeoNode* > >::iterator it = _nodeMap.find(layer);
		if( it != _nodeMap.end() ){
			it->second.push_back(gn);
		} else{
			std::list< GeoNode* > newlist;
			newlist.push_back(gn);
			_nodeMap[layer] = newlist;
		}
	}
}

bool SceneGraphChanges::toRemove(std::string layer){
	bool found = false;
	for(std::list<std::string>::iterator it = _layersToRemove.begin(); it!=_layersToRemove.end()&&!found; it++){
		found = ((*it).compare(layer) == 0);
	}
	return found;
}

void SceneGraphChanges::checkRemove(){
	std::list<std::string> canRemove;
	for(std::list<std::string>::iterator it = _layersToRemove.begin(); it!=_layersToRemove.end(); it++){
		std::list< GeoNode* > nodelist = _nodeMap[*it];
		std::list< GeoNode* >::iterator itnl = nodelist.begin();
		bool existsNodeinGraph = false;
		while(!existsNodeinGraph && itnl!=nodelist.end()){
			existsNodeinGraph = (*itnl)->inGraph();
			itnl++;
		}
		if(itnl==nodelist.end()){
			_nodeMap.erase(*it);
			canRemove.push_back(*it);
		}
	}
	for(std::list<std::string>::iterator it2 = canRemove.begin(); it2!=canRemove.end(); it2++){
		_layersToRemove.remove(*it2);
	}
}

void SceneGraphChanges::onMove(osg::Vec3d point, float maxDistance, const osgEarth::SpatialReference* srs){
	for(std::map< std::string, std::list< GeoNode* > >::iterator it = _nodeMap.begin() ; it != _nodeMap.end(); ++it)
	{
		for(std::list< GeoNode* >::iterator itl = it->second.begin(); itl != it->second.end(); ++itl)
		{
			osgEarth::GeoExtent bounds = (*itl)->getBounds();
			if( bounds.isValid() )
			{
				osg::Vec3d bout = bounds.getCentroid();
				OE_NOTICE << "DEBUG: centroid " << bout.x() << ";" << bout.y() << std::endl;

				double distance = osgEarth::GeoMath::distance( point, bout, srs );
				OE_NOTICE << "DEBUG: distance " << distance << std::endl;
				if(distance > maxDistance)
				{
					(*itl)->setToRemove(true);
				}
				else
				{
					(*itl)->setToRemove(false);
				}
			}
		}
	}
}

std::map< std::string, std::list< GeoNode* > > SceneGraphChanges::getMap(){
	return _nodeMap;
}

void SceneGraphChanges::cleanNodes(std::string name){
	std::list< GeoNode* > nodelist = _nodeMap[name];
	for(std::list< GeoNode* >::iterator it = nodelist.begin(); it!=nodelist.end(); it++){
		(*it)->setToRemove(true);
	}
	_layersToRemove.push_back(name);
}

bool SceneGraphChanges::isIn(std::string layer, osgEarth::GeoExtent bounds){
	checkRemove();
	std::list< GeoNode* > nodelist = _nodeMap[layer];
	std::list< GeoNode* >::iterator it = nodelist.begin();
	bool found = false;
	while( !found && it!=nodelist.end()) {
		osgEarth::GeoExtent cachedBounds = (*it)->getBounds();
		found = cachedBounds.contains(bounds);
		it++;
	}
	return it!=nodelist.end();
}

SceneGraphChanges::~SceneGraphChanges(){}

