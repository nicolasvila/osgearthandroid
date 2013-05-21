#include "SelectiveNodeStateModifier.h"

#include <osg/Array>
#include <osg/Geometry>
#include <osg/PrimitiveSet>
#include <osgEarth/Notify>


SelectiveNodeStateModifier::SelectiveNodeStateModifier() :
		NodeVisitor( NodeVisitor::TRAVERSE_ALL_CHILDREN ) {
	m_color.set( 0.0, 0.0, 0.0, 0.0 );
	m_colorArrays = new osg::Vec4Array;
	m_colorArrays->push_back( m_color );
};


SelectiveNodeStateModifier::SelectiveNodeStateModifier( const osg::Vec4 &color ) :
		NodeVisitor( NodeVisitor::TRAVERSE_ALL_CHILDREN ) {
	m_color = m_color;
	m_colorArrays = new osg::Vec4Array;
	m_colorArrays->push_back( m_color );
};

SelectiveNodeStateModifier::~SelectiveNodeStateModifier(){};


void SelectiveNodeStateModifier::apply ( osg::Node &node ){
	traverse( node );
}

void SelectiveNodeStateModifier::apply( osg::Geode &geode ){
	osg::StateSet *state = NULL;
	unsigned int vertNum = 0;

	unsigned int numGeoms = geode.getNumDrawables();
	for( unsigned int geodeIdx = 0; geodeIdx < numGeoms; geodeIdx++ ) {
		osg::Geometry *curGeom = geode.getDrawable( geodeIdx )->asGeometry();
		if ( curGeom ) {
			for (unsigned int ipr=0; ipr<curGeom->getNumPrimitiveSets(); ipr++) {
				osg::PrimitiveSet* prset = curGeom->getPrimitiveSet(ipr);
				OE_WARN << prset->getMode() << std::endl;
				(prset->getMode() == osg::PrimitiveSet::TRIANGLES)?
						prset->setMode(osg::PrimitiveSet::LINES):
						prset->setMode(osg::PrimitiveSet::TRIANGLES);
			}
		}
	}
}

void SelectiveNodeStateModifier::setColor( const float r, const float g, const float b, const float a ){
	osg::Vec4 *c = &m_colorArrays->operator []( 0 );
	m_color.set( r,g,b,a );
	*c = m_color;
}

void SelectiveNodeStateModifier::setColor( const osg::Vec4 &color  ){
	osg::Vec4 *c = &m_colorArrays->operator []( 0 );
	m_color = color;
	*c = m_color;
}
