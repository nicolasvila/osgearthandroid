#include "GetWorldCoordOfNodeVisitor.h"

#include <osgEarth/Notify>

GetWorldCoordOfNodeVisitor::GetWorldCoordOfNodeVisitor():
	osg::NodeVisitor( NodeVisitor::TRAVERSE_PARENTS ), done( false )
{
	wcMatrix= new osg::Matrixd();
}

void GetWorldCoordOfNodeVisitor::apply(osg::Node &node)
{
	if ( !done )
	{
		if ( 0 == node.getNumParents() )
		{
			wcMatrix->set( osg::computeLocalToWorld( this->getNodePath() ) );
			done = true;
		}
		traverse( node );
	}
}

osg::Matrixd* GetWorldCoordOfNodeVisitor::giveUpDaMat()
{
	return wcMatrix;
}
