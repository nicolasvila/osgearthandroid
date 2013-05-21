#ifndef SELECTIVENODESTATEMODIFIER_CLASS_H
#define SELECTIVENODESTATEMODIFIER_CLASS_H

#include <osg/NodeVisitor>
#include <osg/Vec4>
#include <osg/Geode>

class  SelectiveNodeStateModifier : public osg::NodeVisitor {

public:
	SelectiveNodeStateModifier();
	SelectiveNodeStateModifier( const osg::Vec4 &color );

	virtual ~SelectiveNodeStateModifier();

	virtual void apply( osg::Node &node );
	virtual void apply( osg::Geode &geode );

	void setColor( const float r, const float g, const float b, const float a = 1.0f );
	void setColor( const osg::Vec4 &color  );

protected :
    osg::Vec4 m_color;
    osg::ref_ptr< osg::Vec4Array > m_colorArrays;
};

#endif
