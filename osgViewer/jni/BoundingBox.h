#ifndef BOUNDINGBOX_CLASS_H
#define BOUNDINGBOX_CLASS_H

#include <osg/NodeVisitor>
#include <osg/BoundingBox>
#include <osg/BoundingSphere>
#include <osg/MatrixTransform>
#include <osg/Billboard>

class  BoundingBox : public osg::NodeVisitor {

public:
	BoundingBox();
	virtual ~BoundingBox();

	virtual void apply( osg::Geode &geode );
	virtual void apply( osg::MatrixTransform &node );
	virtual void apply( osg::Billboard &node );
	virtual void apply( osg::Node &node );

	osg::BoundingBox &getBoundBox();

protected :
    osg::BoundingBox m_boundingBox;
    osg::Matrix      m_transformMatrix;

};

#endif

