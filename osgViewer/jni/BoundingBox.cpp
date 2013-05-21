/*
 * BoundingBox.cpp
 *
 *  Created on: 2 de Nov de 2012
 *      Author: paulo
 */

#include "BoundingBox.h"

BoundingBox::BoundingBox(): NodeVisitor( NodeVisitor::TRAVERSE_ALL_CHILDREN ) {
    m_transformMatrix.makeIdentity();
}

BoundingBox::~BoundingBox(){}

void BoundingBox::apply( osg::Geode &geode ) {
	osg::BoundingBox bbox;
	for(  unsigned int i = 0; i < geode.getNumDrawables(); ++i ){
		bbox.expandBy( geode.getDrawable( i )->getBound());
	}

	osg::BoundingBox bboxTrans;
	for( unsigned int i = 0; i < 8; ++i ) {
		osg::Vec3 xvec = bbox.corner( i ) * m_transformMatrix;
		bboxTrans.expandBy( xvec );
	}

	m_boundingBox.expandBy( bboxTrans );
	traverse( geode );
}

void BoundingBox::apply( osg::MatrixTransform &node ) {
	m_transformMatrix *= node.getMatrix();
	traverse( node );
}

void BoundingBox::apply( osg::Billboard &node ){
	traverse( node );
}

void BoundingBox::apply( osg::Node &node ) {
	osg::BoundingBox bbox;
	bbox.expandBy( node.getBound());

	osg::BoundingBox bboxTrans;
	for( unsigned int i = 0; i < 8; ++i ) {
		osg::Vec3 xvec = bbox.corner( i ) * m_transformMatrix;
		bboxTrans.expandBy( xvec );
	}

	m_boundingBox.expandBy( bboxTrans );
	traverse( node );
}

osg::BoundingBox &BoundingBox::getBoundBox() { return m_boundingBox; }
