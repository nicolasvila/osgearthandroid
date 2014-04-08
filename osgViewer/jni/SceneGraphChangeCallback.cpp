#include "SceneGraphChangeCallback.hpp"
#include <osgEarthDrivers/wms/SceneGraphChanges>
#include <osgEarthDrivers/wms/GeoNode>

#include <osg/Group>

SceneGraphChangeCallback::SceneGraphChangeCallback(){}

void SceneGraphChangeCallback::operator()( osg::Node* node, osg::NodeVisitor* nv )
{
	osg::ref_ptr<SceneGraphChanges> changesQueue = dynamic_cast<SceneGraphChanges*> (node->getUserData() );
	osg::Group* nodeAsGroup = node->asGroup();

	if( changesQueue && nodeAsGroup )
	{
		std::map< std::string, std::list< GeoNode* > > queue = changesQueue->getMap();

		for( std::map< std::string, std::list< GeoNode* > >::iterator it = queue.begin() ; it != queue.end(); ++it )
		{
			for( std::list< GeoNode* >::iterator itl = it->second.begin(); itl != it->second.end(); ++itl )
			{
				if( (*itl)->toRemove() && (*itl)->inGraph() )
				{
					nodeAsGroup->removeChild( (*itl)->getNode() );
					(*itl)->setInGraph(false);
					changesQueue->checkRemove();
				}
				else if( !(*itl)->toRemove() && !(*itl)->inGraph() )
				{
					nodeAsGroup->addChild( (*itl)->getNode() );
					(*itl)->setInGraph(true);
				}
		    }
		}
	}
	traverse(node, nv);
}

SceneGraphChangeCallback::~SceneGraphChangeCallback(){}
