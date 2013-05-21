/* -*-c++-*- Present3D - Copyright (C) 1999-2006 Robert Osfield
 *
 * This software is open source and may be redistributed and/or modified under
 * the terms of the GNU General Public License (GPL) version 2.0.
 * The full license is in LICENSE.txt file included with this distribution,.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * include LICENSE.txt for more details.
*/

#include <osgPresentation/SlideShowConstructor>

#include <osg/Geometry>
#include <osg/PolygonOffset>
#include <osg/Geode>
#include <osg/Texture2D>
#include <osg/TextureRectangle>
#include <osg/MatrixTransform>
#include <osg/PositionAttitudeTransform>
#include <osg/TexMat>
#include <osg/ShapeDrawable>
#include <osg/ImageSequence>
#include <osg/ImageUtils>
#include <osg/Notify>
#include <osg/io_utils>

#include <osgUtil/TransformCallback>

#include <osgDB/ReadFile>
#include <osgDB/WriteFile>
#include <osgDB/FileUtils>
#include <osgDB/Input>
#include <osgDB/FileNameUtils>

#include <osgWidget/PdfReader>

#include <osgViewer/ViewerEventHandlers>

#include <osgText/Text>

#include <osgFX/SpecularHighlights>

#include <osgVolume/Volume>
#include <osgVolume/RayTracedTechnique>
#include <osgVolume/FixedFunctionTechnique>

#include <sstream>
#include <algorithm>

#include <osgPresentation/AnimationMaterial>
#include <osgPresentation/PickEventHandler>

#include <osgManipulator/TabBoxDragger>
#include <osgManipulator/TabBoxTrackballDragger>
#include <osgManipulator/TrackballDragger>

using namespace osgPresentation;

#define USE_CLIENT_STORAGE_HINT 0

class SetToTransparentBin : public osg::NodeVisitor
{
public:

    SetToTransparentBin():
        osg::NodeVisitor(osg::NodeVisitor::TRAVERSE_ALL_CHILDREN) {}

    virtual void appply(osg::Node& node)
    {
        if (node.getStateSet())
        {
            node.getStateSet()->setMode(GL_BLEND,osg::StateAttribute::ON);
            node.getStateSet()->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
        }
    }

    virtual void apply(osg::Geode& geode)
    {
        if (geode.getStateSet())
        {
            geode.getStateSet()->setMode(GL_BLEND,osg::StateAttribute::ON);
            geode.getStateSet()->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
        }
        for(unsigned int i=0;i<geode.getNumDrawables();++i)
        {
            if (geode.getDrawable(i)->getStateSet())
            {
                geode.getDrawable(i)->getStateSet()->setMode(GL_BLEND,osg::StateAttribute::ON);
                geode.getDrawable(i)->getStateSet()->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
            }
        }
    }
};


HUDSettings::HUDSettings(double slideDistance, float eyeOffset, unsigned int leftMask, unsigned int rightMask):
    _slideDistance(slideDistance),
    _eyeOffset(eyeOffset),
    _leftMask(leftMask),
    _rightMask(rightMask)
{
}

HUDSettings::~HUDSettings()
{
}

bool HUDSettings::getModelViewMatrix(osg::Matrix& matrix, osg::NodeVisitor* nv) const
{
    matrix.makeLookAt(osg::Vec3d(0.0,0.0,0.0),osg::Vec3d(0.0,_slideDistance,0.0),osg::Vec3d(0.0,0.0,1.0));

    if (nv->getTraversalMask()==_leftMask)
    {
        matrix.postMultTranslate(osg::Vec3(_eyeOffset,0.0,0.0));
    }
    else if (nv->getTraversalMask()==_rightMask)
    {
        matrix.postMultTranslate(osg::Vec3(-_eyeOffset,0.0,0.0));
    }
    return true;
}

bool HUDSettings::getInverseModelViewMatrix(osg::Matrix& matrix, osg::NodeVisitor* nv) const
{
    osg::Matrix modelView;
    getModelViewMatrix(modelView,nv);
    matrix.invert(modelView);
    return true;
}


HUDTransform::HUDTransform(HUDSettings* hudSettings):
    _hudSettings(hudSettings)
{
    setDataVariance(osg::Object::DYNAMIC);
    setReferenceFrame(osg::Transform::ABSOLUTE_RF);
}

HUDTransform::~HUDTransform() {}

bool HUDTransform::computeLocalToWorldMatrix(osg::Matrix& matrix,osg::NodeVisitor* nv) const
{
    return _hudSettings->getModelViewMatrix(matrix,nv);
}

bool HUDTransform::computeWorldToLocalMatrix(osg::Matrix& matrix,osg::NodeVisitor* nv) const
{
    return _hudSettings->getInverseModelViewMatrix(matrix,nv);
}

SlideShowConstructor::SlideShowConstructor(osgDB::Options* options):
    _options(options)
{
    const osg::DisplaySettings* ds = osg::DisplaySettings::instance().get();

    _slideHeight = ds->getScreenHeight();
    _slideWidth = ds->getScreenWidth();
    _slideDistance = ds->getScreenDistance();
    _leftEyeMask = 0x01;
    _rightEyeMask = 0x02;

    _hudSettings = new HUDSettings(_slideDistance, ds->getEyeSeparation()*0.5, _leftEyeMask, _rightEyeMask);

    _backgroundColor.set(0.0f,0.0f,0.0f,1.0f);

    _presentationDuration = -1.0;

    // set up title defaults
    _titleFontDataDefault.font = "fonts/arial.ttf";
    _titleFontDataDefault.color.set(1.0f,1.0f,1.0f,1.0f);
    _titleFontDataDefault.layout =osgText::Text::LEFT_TO_RIGHT;
    _titleFontDataDefault.alignment = osgText::Text::CENTER_BASE_LINE;
    _titleFontDataDefault.axisAlignment = osgText::Text::XZ_PLANE;
    _titleFontDataDefault.characterSize = 0.06f;
    _titleFontDataDefault.maximumWidth = 0.9f;

    _titlePositionDataDefault.position.set(0.5f,0.92f,0.0f);

    // set up text defaults
    _textFontDataDefault.font = "fonts/arial.ttf";
    _textFontDataDefault.color.set(1.0f,1.0f,1.0f,1.0f);
    _textFontDataDefault.layout = osgText::Text::LEFT_TO_RIGHT;
    _textFontDataDefault.alignment = osgText::Text::LEFT_BASE_LINE;
    _textFontDataDefault.axisAlignment = osgText::Text::XZ_PLANE;
    _textFontDataDefault.characterSize = 0.04f;
    _textFontDataDefault.maximumWidth = 0.8f;

    _textPositionDataDefault.position.set(0.1f,0.85f,0.0f);

    _loopPresentation = false;
    _autoSteppingActive = false;

    _slideBackgroundAsHUD = false;

    _layerToApplyEventCallbackTo = 0;
    _currentEventCallbackToApply = 0;
}

void SlideShowConstructor::setPresentationAspectRatio(float aspectRatio)
{
    _slideWidth = _slideHeight*aspectRatio;
}

void SlideShowConstructor::setPresentationAspectRatio(const std::string& str)
{
    if (str=="Reality Theatre") setPresentationAspectRatio(3.0f);
    else if (str=="Desktop") setPresentationAspectRatio(1280.0f/1024.0f);
    else
    {
        float ratio = (float)atof(str.c_str());
        if (ratio!=0.0) setPresentationAspectRatio(1280.0f/1024.0f);
        else
        {
            OSG_WARN<<"Error: presentation aspect ratio incorrect type"<<std::endl;
            OSG_WARN<<"       valid types are \"Reality Theatre\", \"Desktop\" or a numerical value."<<std::endl;
        }
    }
}

void SlideShowConstructor::createPresentation()
{
    _slideOrigin.set(-_slideWidth*0.5f,_slideDistance,-_slideHeight*0.5f);

#if 0
    _titleFontDataDefault.characterSize = 0.06f;
    _titleFontDataDefault.maximumWidth = 0.9f;

    _textFontDataDefault.characterSize = 0.04f;
    _textFontDataDefault.maximumWidth = 0.8f;
#endif

    OSG_INFO<<"_titlePositionDataDefault.position="<<_titlePositionDataDefault.position<<std::endl;

    _textPositionDataDefault.position.set(0.1f,_titlePositionDataDefault.position.y()-_titleFontDataDefault.characterSize,0.0f);
    _imagePositionDataDefault.position.set(0.5f,0.5f,0.0f);
    _modelPositionDataDefault.position.set(0.5f,0.5f,0.0f);

    _root = new osg::Group;

    _presentationSwitch = new osg::Switch;
    _presentationSwitch->setName(std::string("Presentation_")+_presentationName);

    _root->addChild(_presentationSwitch.get());

    osg::Vec3 slideCenter = _slideOrigin + osg::Vec3(_slideWidth*0.5f,0.0f,_slideHeight*0.5f);

    HomePosition* hp = new HomePosition;
    hp->eye.set(0.0f,0.0f,0.0f);
    hp->center = slideCenter;
    hp->up.set(0.0f,0.0f,1.0f);

    OSG_INFO<<" slideCenter "<<slideCenter<<std::endl;

    if (_presentationDuration>=0.0)
    {
        setDuration(_presentationSwitch.get(),_presentationDuration);
    }

    _root->setUserData(hp);

    if (_loopPresentation) _root->addDescription("loop");
    if (_autoSteppingActive) _root->addDescription("auto");
}

LayerAttributes* SlideShowConstructor::getOrCreateLayerAttributes(osg::Node* node)
{
    LayerAttributes* la = dynamic_cast<LayerAttributes*>(node->getUserData());
    if (!la)
    {
        if (node->getUserData())
        {
            OSG_NOTICE<<"UserData already assigned, overriding to set LayerAttributes."<<std::endl;
        }

        la = new LayerAttributes;
        node->setUserData(la);
    }

    return la;
}

void SlideShowConstructor::setBackgroundColor(const osg::Vec4& color, bool updateClearNode)
{
    _backgroundColor = color;
    if (updateClearNode && _slideClearNode.valid()) _slideClearNode->setClearColor(_backgroundColor);
}

void SlideShowConstructor::setTextColor(const osg::Vec4& color)
{
    _titleFontDataDefault.color = color;
    _textFontDataDefault.color = color;

    _titleFontData.color = _titleFontDataDefault.color;
    _textFontData.color = _textFontDataDefault.color;

}

void SlideShowConstructor::setPresentationName(const std::string& name)
{
    _presentationName = name;
    if (_presentationSwitch.valid()) _presentationSwitch->setName(std::string("Presentation_")+_presentationName);
}

void SlideShowConstructor::setPresentationDuration(double duration)
{
    _presentationDuration = duration;
    if (_presentationDuration>=0.0 && _presentationSwitch.valid())
    {
        setDuration(_presentationSwitch.get(),_presentationDuration);
    }
}

void SlideShowConstructor::addSlide()
{
    if (!_presentationSwitch) createPresentation();

    // reset fonts
    _titleFontData = _titleFontDataDefault;
    _textFontData = _textFontDataDefault;

    // reset cursors
    _titlePositionData = _titlePositionDataDefault;
    _textPositionData = _textPositionDataDefault;
    _imagePositionData =  _imagePositionDataDefault;
    _modelPositionData =  _modelPositionDataDefault;

    _slide = new osg::Switch;
    _slide->setName(std::string("Slide_")+_slideTitle);

    _slideClearNode = new osg::ClearNode;
    _slideClearNode->setClearColor(_backgroundColor);
    _slideClearNode->addChild(_slide.get());

    _presentationSwitch->addChild(_slideClearNode.get());

    _previousLayer = 0;
    _currentLayer = 0;


    _filePathData = new FilePathData(osgDB::getDataFilePathList());

    _slideClearNode->setUserData(_filePathData.get());
}

void SlideShowConstructor::selectSlide(int slideNum)
{
    if (slideNum<0)
    {
        addSlide();
    }
    else if (slideNum>=static_cast<int>(_presentationSwitch->getNumChildren()))
    {
        addSlide();
    }
    else
    {
        _slideClearNode = dynamic_cast<osg::ClearNode*>(_presentationSwitch->getChild(slideNum));
        if (!_slideClearNode || _slideClearNode->getNumChildren()==0 || _slideClearNode->getChild(0)->asSwitch()==0)
        {
            addSlide();
        }
        else
        {
            _slide = _slideClearNode->getChild(0)->asSwitch();
            _previousLayer = _slide->getChild(_slide->getNumChildren()-1)->asGroup();
            _currentLayer = 0;
        }
    }
}

void SlideShowConstructor::setSlideDuration(double duration)
{
    if (!_slide) addSlide();

    if (_slide.valid())
    {
        setDuration(_slide.get(),duration);
    }
}

void SlideShowConstructor::addLayer(bool inheritPreviousLayers, bool defineAsBaseLayer)
{
    if (!_slide) addSlide();

    _currentLayer = new osg::Group;

    // OSG_NOTICE<<"addLayer"<<std::endl;

    if (!_previousLayer || !inheritPreviousLayers)
    {
        _textPositionData = _textPositionDataDefault;
        _imagePositionData =  _imagePositionDataDefault;
        _modelPositionData =  _modelPositionDataDefault;

        // OSG_NOTICE<<"   new layer background = "<<_slideBackgroundImageFileName<<std::endl;

        osg::ref_ptr<osg::Image> image = !_slideBackgroundImageFileName.empty() ?
            osgDB::readImageFile(_slideBackgroundImageFileName, _options.get()) :
            0;

        // create the background and title..
        if (image.valid())
        {
            osg::Geode* background = new osg::Geode;

            osg::StateSet* backgroundStateSet = background->getOrCreateStateSet();
            backgroundStateSet->setAttributeAndModes(
                        new osg::PolygonOffset(1.0f,2.0f),
                        osg::StateAttribute::ON);


            bool useTextureRectangle = true;
            float s = useTextureRectangle ? image->s() : 1.0;
            float t = useTextureRectangle ? image->t() : 1.0;
            osg::Geometry* backgroundQuad = osg::createTexturedQuadGeometry(_slideOrigin,
                                                            osg::Vec3(_slideWidth,0.0f,0.0f),
                                                            osg::Vec3(0.0f,0.0f,_slideHeight),
                                                            s, t);
            // OSG_NOTICE<<"Image loaded "<<image.get()<<"  "<<_slideBackgroundImageFileName<<std::endl;

            if (useTextureRectangle)
            {
                osg::TextureRectangle* texture = new osg::TextureRectangle(image.get());
                backgroundStateSet->setTextureAttributeAndModes(0,
                            texture,
                            osg::StateAttribute::ON);
            }
            else
            {
                osg::Texture2D* texture = new osg::Texture2D(image.get());
                texture->setResizeNonPowerOfTwoHint(false);
                texture->setFilter(osg::Texture::MIN_FILTER,osg::Texture::LINEAR);
                texture->setFilter(osg::Texture::MAG_FILTER,osg::Texture::LINEAR);
#if USE_CLIENT_STORAGE_HINT
                texture->setClientStorageHint(true);
#endif
                backgroundStateSet->setTextureAttributeAndModes(0,
                            texture,
                            osg::StateAttribute::ON);
            }

            background->addDrawable(backgroundQuad);

            if (_slideBackgroundAsHUD)
            {
                HUDTransform* hudTransform = new HUDTransform(_hudSettings.get());
                hudTransform->addChild(background);
                addToCurrentLayer(hudTransform);
            }
            else
            {
                addToCurrentLayer(background);
            }
        }

        if (!_slideTitle.empty())
        {
            osg::Geode* geode = new osg::Geode;

            osg::Vec3 localPosition = computePositionInModelCoords(_titlePositionData);

            osgText::Text* text = new osgText::Text;
            text->setFont(_titleFontData.font);
            text->setColor(_titleFontData.color);
            text->setCharacterSize(_titleFontData.characterSize*_slideHeight);
            text->setFontResolution(110,120);
            text->setMaximumWidth(_titleFontData.maximumWidth*_slideWidth);
            text->setLayout(_titleFontData.layout);
            text->setAlignment(_titleFontData.alignment);
            text->setAxisAlignment(_titleFontData.axisAlignment);
            //text->setPosition(_titlePositionData.position);
            text->setPosition(localPosition);

            text->setText(_slideTitle);

            geode->addDrawable(text);

            addToCurrentLayer(decorateSubgraphForPosition(geode, _titlePositionData));
        }

    }
    else
    {
        // copy previous layer's children across into new layer.
        for(unsigned int i=0;i<_previousLayer->getNumChildren();++i)
        {
            addToCurrentLayer(_previousLayer->getChild(i));
        }
    }

    if (!defineAsBaseLayer)
    {
        _slide->addChild(_currentLayer.get());
    }

    _previousLayer = _currentLayer;
}

void SlideShowConstructor::selectLayer(int layerNum)
{
    if (!_slide)
    {
        addSlide();
        addLayer();
    }
    else if (layerNum>=0 && layerNum<static_cast<int>(_slide->getNumChildren()) && _slide->getChild(layerNum)->asGroup())
    {
        _currentLayer = _slide->getChild(layerNum)->asGroup();
        _previousLayer = _currentLayer;
    }
    else
    {
        addLayer();
    }

}


void SlideShowConstructor::setLayerDuration(double duration)
{
    if (!_currentLayer) addLayer();

    if (_currentLayer.valid())
    {
        setDuration(_currentLayer.get(),duration);
    }
}

void SlideShowConstructor::addToCurrentLayer(osg::Node* subgraph)
{
    if (!subgraph) return;

    if (!_currentLayer) addLayer();

    if (_currentEventCallbackToApply.valid())
    {
        if (subgraph->getEventCallback()==0)
        {
            if (_layerToApplyEventCallbackTo==0 || _currentLayer==_layerToApplyEventCallbackTo)
            {
                OSG_INFO<<"Assigning event callback."<<std::endl;
                subgraph->setEventCallback(_currentEventCallbackToApply.get());
            }
            else
            {
                OSG_INFO<<"Ignoring event callback from previous layer."<<std::endl;
            }
        }
        else
        {
            OSG_NOTICE<<"Warning: subgraph already has event callback assigned, cannot add second event callback."<<std::endl;
        }
        _currentEventCallbackToApply = 0;
    }
    _currentLayer->addChild(subgraph);
}

void SlideShowConstructor::layerClickToDoOperation(Operation operation, bool relativeJump, int slideNum, int layerNum)
{
    _layerToApplyEventCallbackTo = _currentLayer;
    _currentEventCallbackToApply = new PickEventHandler(operation, relativeJump, slideNum, layerNum);
}


void SlideShowConstructor::layerClickToDoOperation(const std::string& command, Operation operation, bool relativeJump, int slideNum, int layerNum)
{
    _layerToApplyEventCallbackTo = _currentLayer;
    _currentEventCallbackToApply = new PickEventHandler(command, operation, relativeJump, slideNum, layerNum);
}


void SlideShowConstructor::layerClickEventOperation(const KeyPosition& keyPos, bool relativeJump, int slideNum, int layerNum)
{
    _layerToApplyEventCallbackTo = _currentLayer;
    _currentEventCallbackToApply = new PickEventHandler(keyPos, relativeJump, slideNum, layerNum);
}


osg::Node* SlideShowConstructor::decorateSubgraphForPosition(osg::Node* node, PositionData& positionData)
{
    osg::Node* subgraph = node;

    if (positionData.requiresMaterialAnimation())
    {
        subgraph = attachMaterialAnimation(subgraph,positionData);
    }

    if (positionData.rotation[0]!=0.0)
    {
        osg::MatrixTransform* animation_transform = new osg::MatrixTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setUpdateCallback(
            new osgUtil::TransformCallback(subgraph->getBound().center(),
                                           osg::Vec3(positionData.rotation[1],positionData.rotation[2],positionData.rotation[3]),
                                           osg::DegreesToRadians(positionData.rotation[0])));
        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }

    if (positionData.hud)
    {
        HUDTransform* hudTransform = new HUDTransform(_hudSettings.get());
        hudTransform->addChild(subgraph);

        subgraph = hudTransform;
    }
    return subgraph;
}

void SlideShowConstructor::addBullet(const std::string& bullet, PositionData& positionData, FontData& fontData)
{
    osg::Geode* geode = new osg::Geode;

    osgText::Text* text = new osgText::Text;

    osg::Vec3 localPosition = computePositionInModelCoords(positionData);

    text->setFont(fontData.font);
    text->setColor(fontData.color);
    text->setCharacterSize(fontData.characterSize*_slideHeight);
    text->setCharacterSizeMode(fontData.characterSizeMode);
    text->setFontResolution(110,120);
    text->setMaximumWidth(fontData.maximumWidth*_slideWidth);
    text->setLayout(fontData.layout);
    text->setAlignment(fontData.alignment);
    text->setAxisAlignment(fontData.axisAlignment);
    text->setPosition(localPosition);

    if (positionData.autoRotate)
    {
        text->setAxisAlignment(osgText::Text::SCREEN);
    }

    if (positionData.autoScale)
    {
        text->setCharacterSizeMode(osgText::Text::SCREEN_COORDS);
    }

    text->setText(bullet);

    osg::BoundingBox bb = text->getBound();

    // note, this increment is only "correct" when text is on the plane of the slide..
    // will need to make this more general later.
    localPosition.z() = bb.zMin()-fontData.characterSize*_slideHeight*1.5;

    geode->addDrawable(text);

    addToCurrentLayer( decorateSubgraphForPosition(geode, positionData) );

    bool needToApplyPosition = (_textPositionData.position == positionData.position);
    if (needToApplyPosition)
    {
        updatePositionFromInModelCoords(localPosition, _textPositionData);
    }
}

void SlideShowConstructor::addParagraph(const std::string& paragraph, PositionData& positionData, FontData& fontData)
{
    osg::Geode* geode = new osg::Geode;

    osg::Vec3 localPosition = computePositionInModelCoords(positionData);

    osgText::Text* text = new osgText::Text;

    text->setFont(fontData.font);
    text->setColor(fontData.color);
    text->setCharacterSize(fontData.characterSize*_slideHeight);
    text->setCharacterSizeMode(fontData.characterSizeMode);
    text->setFontResolution(110,120);
    text->setMaximumWidth(fontData.maximumWidth*_slideWidth);
    text->setLayout(fontData.layout);
    text->setAlignment(fontData.alignment);
    text->setAxisAlignment(fontData.axisAlignment);
    text->setPosition(localPosition);

    if (positionData.autoRotate)
    {
        text->setAxisAlignment(osgText::Text::SCREEN);
    }

    if (positionData.autoScale)
    {
        text->setCharacterSizeMode(osgText::Text::SCREEN_COORDS);
    }
    text->setText(paragraph);

    osg::BoundingBox bb = text->getBound();

    // note, this increment is only "correct" when text is on the plane of the slide..
    // will need to make this more general later.
    localPosition.z() = bb.zMin()-fontData.characterSize*_slideHeight*1.5;

    geode->addDrawable(text);

    addToCurrentLayer( decorateSubgraphForPosition(geode, positionData) );

    bool needToApplyPosition = (_textPositionData.position == positionData.position);
    if (needToApplyPosition)
    {
        updatePositionFromInModelCoords(localPosition, _textPositionData);
    }
}

class FindImageStreamsVisitor : public osg::NodeVisitor
{
public:
    FindImageStreamsVisitor():
        osg::NodeVisitor(osg::NodeVisitor::TRAVERSE_ALL_CHILDREN) {}

    virtual void apply(osg::Node& node)
    {
        if (node.getStateSet())
        {
                process(node.getStateSet());
        }
        traverse(node);
    }

    virtual void apply(osg::Geode& node)
    {
        if (node.getStateSet())
        {
                process(node.getStateSet());
        }

        for(unsigned int i=0;i<node.getNumDrawables();++i)
        {
            osg::Drawable* drawable = node.getDrawable(i);
            if (drawable && drawable->getStateSet())
            {
                process(drawable->getStateSet());
            }
        }
    }

    void process(osg::StateSet* ss)
    {
        for(unsigned int i=0;i<ss->getTextureAttributeList().size();++i)
        {
            osg::Texture* texture = dynamic_cast<osg::Texture*>(ss->getTextureAttribute(i,osg::StateAttribute::TEXTURE));
            osg::Image* image = texture ? texture->getImage(0) : 0;
            osg::ImageStream* imageStream = image ? dynamic_cast<osg::ImageStream*>(image) : 0;
            if (imageStream)
            {
                texture->setDataVariance(osg::Object::DYNAMIC);
                texture->setUnRefImageDataAfterApply(false);
                texture->setResizeNonPowerOfTwoHint(false);
                texture->setFilter(osg::Texture::MIN_FILTER,osg::Texture::LINEAR);
                texture->setFilter(osg::Texture::MAG_FILTER,osg::Texture::LINEAR);
#if USE_CLIENT_STORAGE_HINT
                texture->setClientStorageHint(true);
#endif          
            }
        }
    }

};

void SlideShowConstructor::findImageStreamsAndAddCallbacks(osg::Node* node)
{
    FindImageStreamsVisitor fisv;
    node->accept(fisv);
}


osg::Geometry* SlideShowConstructor::createTexturedQuadGeometry(const osg::Vec3& pos, const osg::Vec4& rotation, float width, float height, osg::Image* image, bool& usedTextureRectangle)
{
    osg::Geometry* pictureQuad = 0;
    osg::Texture* texture = 0;
    osg::StateSet* stateset = 0;

    osg::Vec3 positionVec = pos;
    osg::Vec3 widthVec(width,0.0f,0.0f);
    osg::Vec3 heightVec(0.0f,0.0f,height);

    osg::Matrixd rotationMatrix = osg::Matrixd::rotate(osg::DegreesToRadians(rotation[0]),rotation[1],rotation[2],rotation[3]);
    widthVec = widthVec*rotationMatrix;
    heightVec = heightVec*rotationMatrix;

    osg::ImageStream* imageStream = dynamic_cast<osg::ImageStream*>(image);

    bool flipYAxis = image->getOrigin()==osg::Image::TOP_LEFT;

#if 1
    bool useTextureRectangle = false;
#else
    #ifdef __sgi
        bool useTextureRectangle = false;
    #else
        bool useTextureRectangle = true;
    #endif
#endif
    
    // pass back info on wether texture 2D is used.
    usedTextureRectangle = useTextureRectangle;

    if (useTextureRectangle)
    {
        pictureQuad = osg::createTexturedQuadGeometry(positionVec,
                                           widthVec,
                                           heightVec,
                                           0.0f, flipYAxis ? image->t() : 0.0f,
                                           image->s(), flipYAxis ? 0.0f : image->t());

        stateset = pictureQuad->getOrCreateStateSet();

        texture = new osg::TextureRectangle(image);
        stateset->setTextureAttributeAndModes(0,
                    texture,
                    osg::StateAttribute::ON);



    }
    else
    {
        pictureQuad = osg::createTexturedQuadGeometry(positionVec,
                                           widthVec,
                                           heightVec,
                                           0.0f, flipYAxis ? 1.0f : 0.0f,
                                           1.0f, flipYAxis ? 0.0f : 1.0f);

        stateset = pictureQuad->getOrCreateStateSet();

        texture = new osg::Texture2D(image);

        texture->setResizeNonPowerOfTwoHint(false);
        texture->setFilter(osg::Texture::MIN_FILTER,osg::Texture::LINEAR);
        texture->setFilter(osg::Texture::MAG_FILTER,osg::Texture::LINEAR);
#if USE_CLIENT_STORAGE_HINT        
        texture->setClientStorageHint(true);
#endif
        stateset->setTextureAttributeAndModes(0,
                    texture,
                    osg::StateAttribute::ON);

    }

    if (!pictureQuad) return 0;

    if (imageStream)
    {
        imageStream->pause();

        OSG_INFO<<"Reading video "<<imageStream->getFileName()<<std::endl;
#if USE_CLIENT_STORAGE_HINT
        // make sure that OSX uses the client storage extension to accelerate peformance where possible.
        texture->setClientStorageHint(true);
#endif  
    }


    return pictureQuad;
}

struct FileNameComparator
{
    bool operator() (const std::string& lhs, const std::string& rhs) const
    {
        std::string::size_type size_lhs = lhs.size();
        std::string::size_type size_rhs = rhs.size();
        std::string::size_type pos_lhs = 0;
        std::string::size_type pos_rhs = 0;
        while(pos_lhs<size_lhs && pos_rhs<size_rhs)
        {
            char c_lhs = lhs[pos_rhs];
            char c_rhs = rhs[pos_rhs];
            bool numeric_lhs = lhs[pos_lhs]>='0' && lhs[pos_lhs]<='9';
            bool numeric_rhs = rhs[pos_rhs]>='0' && rhs[pos_rhs]<='9';
            if (numeric_lhs && numeric_rhs)
            {
                std::string::size_type start_lhs = pos_lhs;
                ++pos_lhs;
                while(pos_lhs<size_lhs && (lhs[pos_lhs]>='0' && lhs[pos_lhs]<='9')) ++pos_lhs;

                std::string::size_type start_rhs = pos_rhs;
                ++pos_rhs;
                while(pos_rhs<size_rhs && (rhs[pos_rhs]>='0' && rhs[pos_rhs]<='9')) ++pos_rhs;

                if (pos_lhs<pos_rhs) return true;
                else if (pos_rhs<pos_lhs) return false;

                while(start_lhs<pos_lhs && start_rhs<pos_rhs)
                {
                    if (lhs[start_lhs]<rhs[start_rhs]) return true;
                    if (lhs[start_lhs]>rhs[start_rhs]) return false;
                    ++start_lhs;
                    ++start_rhs;
                }                
            }
            else
            {
                if (c_lhs<c_rhs) return true;
                else if (c_rhs<c_lhs) return false;

                ++pos_lhs;
                ++pos_rhs;
            }
        }

        return pos_lhs<pos_rhs;
    }
};


osg::Image* SlideShowConstructor::readImage(const std::string& filename, const ImageData& imageData)
{
    osg::ref_ptr<osgDB::Options> options = _options;
    if (!imageData.options.empty())
    {
        options = _options->cloneOptions();
        options->setOptionString(imageData.options);
    }

    osg::ref_ptr<osg::Image> image;
    osgDB::DirectoryContents filenames;

    std::string foundFile = filename;

    // check for wild cards
    if (filename.find('*')!=std::string::npos)
    {
        OSG_INFO<<"Expanding wildcard "<<std::endl;
        filenames = osgDB::expandWildcardsInFilename(filename);
    }
    else
    {
        std::string foundFile = filename;
        osgDB::FileType fileType = osgDB::fileType(foundFile);
        if (fileType == osgDB::FILE_NOT_FOUND)
        {
            foundFile = findFileAndRecordPath(foundFile);
            fileType = osgDB::fileType(foundFile);
        }

        if (fileType == osgDB::DIRECTORY)
        {
            OSG_INFO<<"Reading directory "<<foundFile<<std::endl;

            filenames = osgDB::getDirectoryContents(foundFile);

            // need to insert the directory path in front of the filenames so it's relative to the appropriate directory.
            for(osgDB::DirectoryContents::iterator itr = filenames.begin();
                itr != filenames.end();
                ++itr)
            {
                *itr = foundFile + osgDB::getNativePathSeparator() + *itr;
            }

            // prune any directory entries from the list.
            for(osgDB::DirectoryContents::iterator itr = filenames.begin();
                itr != filenames.end();
                )
            {
                if (osgDB::fileType(*itr)!=osgDB::REGULAR_FILE)
                {
                    itr = filenames.erase(itr);
                }
                else
                {
                    ++itr;
                }
            }
        }
        else
        {
            filenames.push_back(foundFile);
        }
    }

    if (filenames.empty()) return 0;

    if (filenames.size()==1)
    {
        image = osgDB::readImageFile(filenames[0], options.get());
        if (image.valid()) recordOptionsFilePath(options.get() );
    }
    else
    {
        // make sure images are in alphabetical order.
        std::sort(filenames.begin(), filenames.end(), FileNameComparator());

        osg::ref_ptr<osg::ImageSequence> imageSequence = new osg::ImageSequence;

        imageSequence->setMode(imageData.imageSequencePagingMode);

        bool firstLoad = true;

        for(osgDB::DirectoryContents::iterator itr = filenames.begin();
            itr != filenames.end();
            ++itr)
        {
            if (imageSequence->getMode()==osg::ImageSequence::PRE_LOAD_ALL_IMAGES)
            {
                OSG_INFO<<"Attempting to read "<<*itr<<std::endl;
                osg::ref_ptr<osg::Image> loadedImage = osgDB::readImageFile(*itr, options.get());
                if (loadedImage.valid())
                {
                    OSG_INFO<<"Loaded image "<<*itr<<std::endl;
                    imageSequence->addImage(loadedImage.get());
                }
            }
            else
            {
                OSG_INFO<<"Adding filename for load image on demand "<<*itr<<std::endl;
                imageSequence->addImageFile(*itr);
                if (firstLoad)
                {
                    osg::ref_ptr<osg::Image> loadedImage = osgDB::readImageFile(*itr, options.get());
                    if (loadedImage.valid())
                    {                    
                        imageSequence->addImage(loadedImage.get());
                        firstLoad = false;
                    }
                }
            }
        }

        if (imageData.duration>0.0)
        {
            imageSequence->setLength(imageData.duration);
        }
        else
        {
            unsigned int maxNum = osg::maximum(imageSequence->getFileNames().size(),
                                               imageSequence->getImages().size());

            imageSequence->setLength(double(maxNum)*(1.0/imageData.fps));
        }

        imageSequence->play();

        image = imageSequence;
    }

    return image.release();
}

void SlideShowConstructor::addImage(const std::string& filename, const PositionData& positionData, const ImageData& imageData)
{

    osg::ref_ptr<osgVolume::Volume> volume;
    osg::ref_ptr<osgVolume::VolumeTile> tile;
    osg::ref_ptr<osgVolume::ImageLayer> layer;

    osg::ref_ptr<osg::Image> image = readImage(filename, imageData);
    if (!image) return;

    bool isImageTranslucent = false;

    osg::ImageStream* imageStream = dynamic_cast<osg::ImageStream*>(image.get());
    if (imageStream)
    {
        imageStream->setLoopingMode(imageData.loopingMode);

        isImageTranslucent = imageStream->getPixelFormat()==GL_RGBA ||
                             imageStream->getPixelFormat()==GL_BGRA;

    }
    else
    {
        isImageTranslucent = image->isImageTranslucent();
    }

    float s = image->s();
    float t = image->t();

    float sx = imageData.region_in_pixel_coords ? 1.0f : s;
    float sy = imageData.region_in_pixel_coords ? 1.0f : t;

    float x1 = imageData.region[0]*sx;
    float y1 = imageData.region[1]*sy;
    float x2 = imageData.region[2]*sx;
    float y2 = imageData.region[3]*sy;

    float aspectRatio = (y2-y1)/(x2-x1);

    float image_width = _slideWidth*positionData.scale.x();
    float image_height = image_width*aspectRatio*positionData.scale.y()/positionData.scale.x();
    float offset = 0.0f;

    osg::Vec3 pos = computePositionInModelCoords(positionData);
    osg::Vec3 image_local_pos = osg::Vec3(-image_width*0.5f+offset,-offset,-image_height*0.5f-offset);
    osg::Vec3 image_pos = positionData.autoRotate ? image_local_pos : (pos+image_local_pos);


    bool usedTextureRectangle = false;
    osg::Geometry* pictureQuad = createTexturedQuadGeometry(image_pos, positionData.rotate, image_width, image_height, image.get(), usedTextureRectangle);
    osg::StateSet* pictureStateSet = pictureQuad->getOrCreateStateSet();

    attachTexMat(pictureStateSet, imageData, s, t, usedTextureRectangle);

    osg::Node* subgraph = 0;

    if (positionData.autoRotate)
    {
        osg::Billboard* picture = new osg::Billboard;
        picture->setMode(osg::Billboard::POINT_ROT_EYE);
        picture->setNormal(osg::Vec3(0.0f,-1.0f,0.0f));
        picture->setAxis(osg::Vec3(0.0f,0.0f,1.0f));
        picture->addDrawable(pictureQuad,pos);
        subgraph = picture;
    }
    else
    {
        osg::Geode* picture = new osg::Geode;
        picture->addDrawable(pictureQuad);
        subgraph = picture;
    }

    // attach any meterial animation.
    if (positionData.requiresMaterialAnimation())
        subgraph = attachMaterialAnimation(subgraph,positionData);


    if (isImageTranslucent)
    {
        SetToTransparentBin sttb;
        subgraph->accept(sttb);
        pictureStateSet->setMode(GL_BLEND, osg::StateAttribute::ON);
    }

    // attached any rotation
    if (positionData.rotation[0]!=0.0)
    {
        osg::MatrixTransform* animation_transform = new osg::MatrixTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setUpdateCallback(
            new osgUtil::TransformCallback(subgraph->getBound().center(),
                                           osg::Vec3(positionData.rotation[1],positionData.rotation[2],positionData.rotation[3]),
                                           osg::DegreesToRadians(positionData.rotation[0])));

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }


    // attached any animation
    osg::AnimationPathCallback* animation = getAnimationPathCallback(positionData);
    if (animation)
    {
        OSG_INFO<<"Have animation path for image"<<std::endl;

        osg::BoundingSphere::vec_type pivot = positionData.absolute_path ?
                osg::BoundingSphere::vec_type(0.0f,0.0f,0.0f) :
                subgraph->getBound().center();

        osg::PositionAttitudeTransform* animation_transform = new osg::PositionAttitudeTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setPivotPoint(pivot);
        animation->setPivotPoint(pivot);

        animation_transform->setUpdateCallback(animation);

        animation_transform->setReferenceFrame(positionData.absolute_path ?
                                                    osg::Transform::ABSOLUTE_RF:
                                                    osg::Transform::RELATIVE_RF);

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }

    if (positionData.hud)
    {
        HUDTransform* hudTransform = new HUDTransform(_hudSettings.get());
        hudTransform->addChild(subgraph);

        subgraph = hudTransform;
    }

    addToCurrentLayer(subgraph);
}

void SlideShowConstructor::addStereoImagePair(const std::string& filenameLeft, const ImageData& imageDataLeft, const std::string& filenameRight, const ImageData& imageDataRight,const PositionData& positionData)
{
    osg::ref_ptr<osg::Image> imageLeft = readImage(filenameLeft, imageDataLeft);
    osg::ref_ptr<osg::Image> imageRight = (filenameRight==filenameLeft) ? imageLeft.get() : readImage(filenameRight, imageDataRight);
    
    if (!imageLeft && !imageRight) return;

    bool isImageTranslucent = false;

    osg::ImageStream* imageStreamLeft = dynamic_cast<osg::ImageStream*>(imageLeft.get());
    if (imageStreamLeft)
    {
        imageStreamLeft->setLoopingMode(imageDataLeft.loopingMode);
        isImageTranslucent = imageStreamLeft->getPixelFormat()==GL_RGBA ||
                             imageStreamLeft->getPixelFormat()==GL_BGRA;
    }
    else
    {
        isImageTranslucent = imageLeft->isImageTranslucent();
    }

    osg::ImageStream* imageStreamRight = dynamic_cast<osg::ImageStream*>(imageRight.get());
    if (imageStreamRight)
    {
        imageStreamRight->setLoopingMode(imageDataRight.loopingMode);
        if (!isImageTranslucent)
        {
            isImageTranslucent = imageStreamRight->getPixelFormat()==GL_RGBA ||
                                imageStreamRight->getPixelFormat()==GL_BGRA;
        }
    }
    else if (!isImageTranslucent)
    {
        isImageTranslucent = imageRight->isImageTranslucent();
    }


    float s = imageLeft->s();
    float t = imageLeft->t();


    float sx = imageDataLeft.region_in_pixel_coords ? 1.0f : s;
    float sy = imageDataLeft.region_in_pixel_coords ? 1.0f : t;

    float x1 = imageDataLeft.region[0]*sx;
    float y1 = imageDataLeft.region[1]*sy;
    float x2 = imageDataLeft.region[2]*sx;
    float y2 = imageDataLeft.region[3]*sy;

    float aspectRatio = (y2-y1)/(x2-x1);

    float image_width = _slideWidth*positionData.scale.x();
    float image_height = image_width*aspectRatio*positionData.scale.y()/positionData.scale.x();

    float offset = 0.0f;

    bool usedTextureRectangle = false;

    osg::Vec3 pos = computePositionInModelCoords(positionData);
    osg::Vec3 image_local_pos = osg::Vec3(-image_width*0.5f+offset,-offset,-image_height*0.5f-offset);
    osg::Vec3 image_pos = positionData.autoRotate ? image_local_pos : (pos+image_local_pos);


    osg::Node* pictureLeft = 0;
    {
        osg::Geometry* pictureLeftQuad = createTexturedQuadGeometry(image_pos, positionData.rotate, image_width,image_height,imageLeft.get(),usedTextureRectangle);
        osg::StateSet* pictureLeftStateSet = pictureLeftQuad->getOrCreateStateSet();

        if (isImageTranslucent)
        {
            pictureLeftStateSet->setMode(GL_BLEND, osg::StateAttribute::ON);
        }

        attachTexMat(pictureLeftStateSet, imageDataLeft, s, t, usedTextureRectangle);

        if (positionData.autoRotate)
        {
            osg::Billboard* billboard = new osg::Billboard;
            billboard->setMode(osg::Billboard::POINT_ROT_EYE);
            billboard->setNormal(osg::Vec3(0.0f,-1.0f,0.0f));
            billboard->setAxis(osg::Vec3(0.0f,0.0f,1.0f));
            billboard->addDrawable(pictureLeftQuad,pos);
            pictureLeft = billboard;
        }
        else
        {
            osg::Geode* geode = new osg::Geode;
            geode->addDrawable(pictureLeftQuad);
            pictureLeft = geode;
        }

        pictureLeft->setNodeMask(_leftEyeMask);
    }

    osg::Node* pictureRight = 0;
    {
        osg::Geometry* pictureRightQuad = createTexturedQuadGeometry(image_pos, positionData.rotate, image_width,image_height,imageRight.get(),usedTextureRectangle);
        osg::StateSet* pictureRightStateSet = pictureRightQuad->getOrCreateStateSet();

        if (isImageTranslucent)
        {
            pictureRightStateSet->setMode(GL_BLEND, osg::StateAttribute::ON);
        }

        attachTexMat(pictureRightStateSet, imageDataRight, s, t, usedTextureRectangle);

        if (positionData.autoRotate)
        {
            osg::Billboard* billboard = new osg::Billboard;
            billboard->setMode(osg::Billboard::POINT_ROT_EYE);
            billboard->setNormal(osg::Vec3(0.0f,-1.0f,0.0f));
            billboard->setAxis(osg::Vec3(0.0f,0.0f,1.0f));
            billboard->addDrawable(pictureRightQuad,pos);
            pictureRight = billboard;
        }
        else
        {
            osg::Geode* geode = new osg::Geode;
            geode->addDrawable(pictureRightQuad);
            pictureRight = geode;
        }

        pictureRight->setNodeMask(_rightEyeMask);
    }

    osg::Group* subgraph = new osg::Group;
    subgraph->addChild(pictureLeft);
    subgraph->addChild(pictureRight);

    // attach any meterial animation.
    if (positionData.requiresMaterialAnimation())
        subgraph = attachMaterialAnimation(subgraph,positionData)->asGroup();

    if (isImageTranslucent)
    {
        SetToTransparentBin sttb;
        subgraph->accept(sttb);
    }

    // attached any rotation
    if (positionData.rotation[0]!=0.0)
    {
        osg::MatrixTransform* animation_transform = new osg::MatrixTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setUpdateCallback(
            new osgUtil::TransformCallback(subgraph->getBound().center(),
                                           osg::Vec3(positionData.rotation[1],positionData.rotation[2],positionData.rotation[3]),
                                           osg::DegreesToRadians(positionData.rotation[0])));

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }


    // attached any animation
    osg::AnimationPathCallback* animation = getAnimationPathCallback(positionData);
    if (animation)
    {
        OSG_INFO<<"Have animation path for image"<<std::endl;

        osg::BoundingSphere::vec_type pivot = positionData.absolute_path ?
                osg::BoundingSphere::vec_type(0.0f,0.0f,0.0f) :
                subgraph->getBound().center();

        osg::PositionAttitudeTransform* animation_transform = new osg::PositionAttitudeTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setPivotPoint(pivot);
        animation->setPivotPoint(pivot);

        animation_transform->setUpdateCallback(animation);
        animation_transform->setReferenceFrame(positionData.absolute_path ?
                                                    osg::Transform::ABSOLUTE_RF:
                                                    osg::Transform::RELATIVE_RF);

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }

    if (positionData.hud)
    {
        HUDTransform* hudTransform = new HUDTransform(_hudSettings.get());
        hudTransform->addChild(subgraph);

        subgraph = hudTransform;
    }

    addToCurrentLayer(subgraph);
}

void SlideShowConstructor::addGraph(const std::string& contents, const PositionData& positionData, const ImageData& imageData)
{
    static int s_count=0;

    if (contents.empty()) return;

    std::string tmpDirectory("/tmp/");

    std::string filename = contents;
    std::string ext = osgDB::getFileExtension(contents);
    if (ext.empty())
    {
        std::stringstream dotFileNameStream;
        dotFileNameStream << tmpDirectory<<"graph_"<<s_count<<std::string(".dot");
        filename = dotFileNameStream.str();

        // write out the string to the temporary file.
        std::ofstream fout(filename.c_str());
        fout<<contents.c_str();
    }

    std::stringstream svgFileNameStream;
    svgFileNameStream << tmpDirectory<<osgDB::getStrippedName(filename)<<s_count<<std::string(".svg");
    std::string tmpSvgFileName(svgFileNameStream.str());
    std::string dotFileName = filename;

    if (osgDB::getFileExtension(filename)=="dot")
    {
        dotFileName = filename;
    }
    else
    {
        osg::ref_ptr<osg::Node> model = osgDB::readNodeFile(filename, _options.get());
        if (!model) return;

        dotFileName = tmpDirectory+osgDB::getStrippedName(filename)+std::string(".dot");

        osg::ref_ptr<osgDB::Options> opts = _options.valid() ? _options->cloneOptions() : (new osgDB::Options);
        if (!imageData.options.empty())
        {
            opts->setOptionString(imageData.options);
        }
        opts->setObjectCacheHint(osgDB::Options::CACHE_NONE);

        osgDB::writeNodeFile(*model, dotFileName, opts.get());
    }

    std::stringstream command;
    command<<"dot -Tsvg "<<dotFileName<<" -o "<<tmpSvgFileName;
    int result = system(command.str().c_str());
    if (result==0)
    {
        osg::ref_ptr<osgDB::Options> previousOptions = _options;

        // switch off cache so we make sure that we re-read the generated svg each time.
        _options = _options.valid() ? _options->cloneOptions() : (new osgDB::Options);
        _options->setObjectCacheHint(osgDB::Options::CACHE_NONE);

        addImage(tmpSvgFileName, positionData, imageData);

        _options = previousOptions;

        ++s_count;
    }
    else OSG_NOTICE<<"Error: SlideShowConstructor::addGraph() system("<<command.str()<<") failed with return "<<result<<std::endl;
}


void SlideShowConstructor::addVNC(const std::string& hostname, const PositionData& positionData, const ImageData& imageData, const std::string& password)
{
    if (!password.empty())
    {
        OSG_NOTICE<<"Setting password"<<std::endl;
        if (!osgDB::Registry::instance()->getAuthenticationMap()) osgDB::Registry::instance()->setAuthenticationMap(new osgDB::AuthenticationMap);
        osgDB::Registry::instance()->getAuthenticationMap()->addAuthenticationDetails(hostname, new osgDB::AuthenticationDetails("", password));
    }

    addInteractiveImage(hostname+".vnc", positionData, imageData);
}

void SlideShowConstructor::addBrowser(const std::string& url, const PositionData& positionData, const ImageData& imageData)
{
    addInteractiveImage(url+".gecko", positionData, imageData);
}

void SlideShowConstructor::addPDF(const std::string& filename, const PositionData& positionData, const ImageData& imageData)
{
    addInteractiveImage(filename, positionData, imageData);
}

class SetPageCallback: public LayerCallback
{
public:
    SetPageCallback(osgWidget::PdfImage* pdfImage, int pageNum):
        _pdfImage(pdfImage),
        _pageNum(pageNum)
    {
    }

    virtual void operator() (osg::Node*) const
    {
        OSG_INFO<<"PDF Page to be updated "<<_pageNum<<std::endl;

        if (_pdfImage.valid() && _pdfImage->getPageNum()!=_pageNum)
        {
            _pdfImage->page(_pageNum);
        }
    }

    osg::observer_ptr<osgWidget::PdfImage> _pdfImage;
    int _pageNum;
};


osg::Image* SlideShowConstructor::addInteractiveImage(const std::string& filename, const PositionData& positionData, const ImageData& imageData)
{
    osg::ref_ptr<osgDB::Options> options = _options;
    if (!imageData.options.empty())
    {
        options = _options->cloneOptions();
        options->setOptionString(imageData.options);
    }

    osg::Image* image = osgDB::readImageFile(filename, options.get());

    OSG_INFO<<"addInteractiveImage("<<filename<<") "<<image<<std::endl;


    if (!image) return 0;

    float s = image->s();
    float t = image->t();

    float sx = imageData.region_in_pixel_coords ? 1.0f : s;
    float sy = imageData.region_in_pixel_coords ? 1.0f : t;

    float x1 = imageData.region[0]*sx;
    float y1 = imageData.region[1]*sy;
    float x2 = imageData.region[2]*sx;
    float y2 = imageData.region[3]*sy;

    float aspectRatio = (y2-y1)/(x2-x1);

    float image_width = _slideWidth*positionData.scale.x();
    float image_height = image_width*aspectRatio*positionData.scale.y()/positionData.scale.x();
    float offset = 0.0f;

    osg::Vec3 pos = computePositionInModelCoords(positionData);
    osg::Vec3 image_local_pos = osg::Vec3(-image_width*0.5f+offset,-offset,-image_height*0.5f-offset);
    osg::Vec3 image_pos = positionData.autoRotate ? image_local_pos : (pos+image_local_pos);

    bool usedTextureRectangle = false;
    osg::Geometry* pictureQuad = createTexturedQuadGeometry(image_pos, positionData.rotate, image_width, image_height, image, usedTextureRectangle);

    osg::ref_ptr<osgViewer::InteractiveImageHandler> handler = new osgViewer::InteractiveImageHandler(image);
    pictureQuad->setEventCallback(handler.get());
    pictureQuad->setCullCallback(handler.get());

    osg::StateSet* pictureStateSet = pictureQuad->getOrCreateStateSet();

    attachTexMat(pictureStateSet, imageData, s, t, usedTextureRectangle);

    pictureStateSet->setMode(GL_LIGHTING, osg::StateAttribute::OFF);

    osg::Node* subgraph = 0;

    if (positionData.autoRotate)
    {
        osg::Billboard* picture = new osg::Billboard;
        picture->setMode(osg::Billboard::POINT_ROT_EYE);
        picture->setNormal(osg::Vec3(0.0f,-1.0f,0.0f));
        picture->setAxis(osg::Vec3(0.0f,0.0f,1.0f));
        picture->addDrawable(pictureQuad,pos);
        subgraph = picture;
    }
    else
    {
        osg::Geode* picture = new osg::Geode;
        picture->addDrawable(pictureQuad);
        subgraph = picture;
    }

    // attach any meterial animation.
    if (positionData.requiresMaterialAnimation())
        subgraph = attachMaterialAnimation(subgraph,positionData);


    // attached any rotation
    if (positionData.rotation[0]!=0.0)
    {
        osg::MatrixTransform* animation_transform = new osg::MatrixTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setUpdateCallback(
            new osgUtil::TransformCallback(subgraph->getBound().center(),
                                           osg::Vec3(positionData.rotation[1],positionData.rotation[2],positionData.rotation[3]),
                                           osg::DegreesToRadians(positionData.rotation[0])));

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }


    // attached any animation
    osg::AnimationPathCallback* animation = getAnimationPathCallback(positionData);
    if (animation)
    {
        OSG_INFO<<"Have animation path for image"<<std::endl;

        osg::BoundingSphere::vec_type pivot = positionData.absolute_path ?
                osg::BoundingSphere::vec_type(0.0f,0.0f,0.0f) :
                subgraph->getBound().center();

        osg::PositionAttitudeTransform* animation_transform = new osg::PositionAttitudeTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setPivotPoint(pivot);
        animation->setPivotPoint(pivot);

        animation_transform->setUpdateCallback(animation);

        animation_transform->setReferenceFrame(positionData.absolute_path ?
                                                    osg::Transform::ABSOLUTE_RF:
                                                    osg::Transform::RELATIVE_RF);

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }

    if (positionData.hud)
    {
        HUDTransform* hudTransform = new HUDTransform(_hudSettings.get());
        hudTransform->addChild(subgraph);

        subgraph = hudTransform;
    }

    addToCurrentLayer(subgraph);

    osgWidget::PdfImage* pdfImage = dynamic_cast<osgWidget::PdfImage*>(image);
    if (pdfImage && imageData.page>=0)
    {
        getOrCreateLayerAttributes(_currentLayer.get())->addEnterCallback(new SetPageCallback(pdfImage, imageData.page));

        OSG_INFO<<"Setting pdf page num "<<imageData.page<<std::endl;
        pdfImage->setBackgroundColor(imageData.backgroundColor);
        pdfImage->page(imageData.page);

        if (imageData.backgroundColor.a()<1.0f)
        {
            SetToTransparentBin sttb;
            subgraph->accept(sttb);
        }


    }


    return image;
}

std::string SlideShowConstructor::findFileAndRecordPath(const std::string& filename)
{
    std::string foundFile = osgDB::findDataFile(filename, _options.get());
    if (foundFile.empty()) return foundFile;

    OSG_INFO<<"foundFile "<<foundFile<<std::endl;

    std::string path = osgDB::getFilePath(foundFile);
    if (!path.empty() && _filePathData.valid())
    {
        osgDB::FilePathList::iterator itr = std::find(_filePathData->filePathList.begin(),_filePathData->filePathList.end(),path);
        if (itr==_filePathData->filePathList.end())
        {
            OSG_INFO<<"New path to record "<<path<<std::endl;
            _filePathData->filePathList.push_front(path);
        }
    }

    return foundFile;

}

void SlideShowConstructor::addModel(const std::string& filename, const PositionData& positionData, const ModelData& modelData)
{
    OSG_INFO<<"SlideShowConstructor::addModel("<<filename<<")"<<std::endl;

    osg::ref_ptr<osgDB::Options> options = _options;
    if (!modelData.options.empty())
    {
        options = _options->cloneOptions();
        options->setOptionString(modelData.options);
    }

    osg::Node* subgraph = 0;

    if (filename=="sphere")
    {
        osg::Geode* geode = new osg::Geode;
        geode->addDrawable(new osg::ShapeDrawable(new osg::Sphere));

        subgraph = geode;
    }
    else if (filename=="box")
    {
        osg::Geode* geode = new osg::Geode;
        geode->addDrawable(new osg::ShapeDrawable(new osg::Box));

        subgraph = geode;
    }
    else
    {
        subgraph = osgDB::readNodeFile(filename, options.get());
        if (subgraph) recordOptionsFilePath(options.get());
    }

    if (subgraph)
    {
        addModel(subgraph, positionData, modelData);
    }

    OSG_INFO<<"end of SlideShowConstructor::addModel("<<filename<<")"<<std::endl<<std::endl;

}

void SlideShowConstructor::addModel(osg::Node* subgraph, const PositionData& positionData, const ModelData& modelData)
{
    osg::Object::DataVariance defaultMatrixDataVariance = osg::Object::DYNAMIC; // STATIC

    if (!modelData.effect.empty())
    {
        if (modelData.effect=="SpecularHighlights" || modelData.effect=="glossy")
        {
            osgFX::SpecularHighlights* specularHighlights = new osgFX::SpecularHighlights;
            specularHighlights->setTextureUnit(1);
            specularHighlights->addChild(subgraph);
            subgraph = specularHighlights;
        }
    }


    if (positionData.frame==SLIDE)
    {
        osg::Vec3 pos = convertSlideToModel(positionData.position);

        const osg::BoundingSphere& bs = subgraph->getBound();
        float slide_scale = _slideHeight*(1.0f-positionData.position.z())*0.7f/bs.radius();

        osg::MatrixTransform* transform = new osg::MatrixTransform;
        transform->setDataVariance(defaultMatrixDataVariance);
        transform->setMatrix(osg::Matrix::translate(-bs.center())*
                             osg::Matrix::scale(positionData.scale.x()*slide_scale, positionData.scale.y()*slide_scale ,positionData.scale.z()*slide_scale)*
                             osg::Matrix::rotate(osg::DegreesToRadians(positionData.rotate[0]),positionData.rotate[1],positionData.rotate[2],positionData.rotate[3])*
                             osg::Matrix::translate(pos));


        transform->setStateSet(createTransformStateSet());
        transform->addChild(subgraph);

        subgraph = transform;

    }
    else
    {
        osg::Matrix matrix(osg::Matrix::scale(1.0f/positionData.scale.x(),1.0f/positionData.scale.y(),1.0f/positionData.scale.z())*
                           osg::Matrix::rotate(osg::DegreesToRadians(positionData.rotate[0]),positionData.rotate[1],positionData.rotate[2],positionData.rotate[3])*
                           osg::Matrix::translate(positionData.position));

        osg::MatrixTransform* transform = new osg::MatrixTransform;
        transform->setDataVariance(defaultMatrixDataVariance);
        transform->setMatrix(osg::Matrix::inverse(matrix));

        OSG_INFO<<"Position Matrix "<<transform->getMatrix()<<std::endl;

        transform->addChild(subgraph);

        subgraph = transform;
    }

    float referenceSizeRatio = 0.707;
    float referenceSize = subgraph->getBound().radius() * referenceSizeRatio;


    // attach any meterial animation.
    if (positionData.requiresMaterialAnimation())
        subgraph = attachMaterialAnimation(subgraph,positionData);

    // attached any rotation
    if (positionData.rotation[0]!=0.0)
    {
        osg::MatrixTransform* animation_transform = new osg::MatrixTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setUpdateCallback(
            new osgUtil::TransformCallback(subgraph->getBound().center(),
                                           osg::Vec3(positionData.rotation[1],positionData.rotation[2],positionData.rotation[3]),
                                           osg::DegreesToRadians(positionData.rotation[0])));

        animation_transform->addChild(subgraph);

        OSG_INFO<<"Rotation Matrix "<<animation_transform->getMatrix()<<std::endl;

        subgraph = animation_transform;
    }


    // attached any animation
    osg::AnimationPathCallback* animation = getAnimationPathCallback(positionData);
    if (animation)
    {
        OSG_INFO<<"Have animation path for model"<<std::endl;

        osg::BoundingSphere::vec_type pivot = positionData.absolute_path ?
            osg::BoundingSphere::vec_type(0.0f,0.0f,0.0f) :
            subgraph->getBound().center();

        osg::AnimationPath* path = animation->getAnimationPath();
        if (positionData.animation_name=="wheel" && (path->getTimeControlPointMap()).size()>=2)
        {
            OSG_INFO<<"****  Need to handle special wheel animation"<<std::endl;

            osg::AnimationPath::TimeControlPointMap& controlPoints = path->getTimeControlPointMap();

            osg::AnimationPath::TimeControlPointMap::iterator curr_itr = controlPoints.begin();
            osg::AnimationPath::TimeControlPointMap::iterator prev_itr=curr_itr;
            ++curr_itr;

            osg::AnimationPath::ControlPoint* prev_cp = &(prev_itr->second);
            osg::AnimationPath::ControlPoint* curr_cp = &(curr_itr->second);

            float totalLength = 0;
            float rotation_y_axis = 0;
            osg::Vec3 delta_position = curr_cp->getPosition() - prev_cp->getPosition();
            float rotation_z_axis = atan2f(delta_position.y(),delta_position.x());

            osg::Quat quat_y_axis,quat_z_axis,quat_combined;

            quat_y_axis.makeRotate(rotation_y_axis,0.0f,1.0f,0.0f);
            quat_z_axis.makeRotate(rotation_z_axis,0.0f,0.0f,1.0f);
            quat_combined = quat_y_axis*quat_z_axis;

            // set first rotation.
            prev_cp->setRotation(quat_combined);

            for(;
                curr_itr!=controlPoints.end();
                ++curr_itr)
            {
                prev_cp = &(prev_itr->second);
                curr_cp = &(curr_itr->second);

                delta_position = curr_cp->getPosition() - prev_cp->getPosition();

                totalLength += delta_position.length();

                // rolling - rotation about the y axis.
                rotation_y_axis = totalLength/referenceSize;

                // direction - rotation about the z axis.
                rotation_z_axis = atan2f(delta_position.y(),delta_position.x());

                OSG_INFO<<" rotation_y_axis="<<rotation_y_axis<<" rotation_z_axis="<<rotation_z_axis<<std::endl;

                quat_y_axis.makeRotate(rotation_y_axis,0.0f,1.0f,0.0f);
                quat_z_axis.makeRotate(rotation_z_axis,0.0f,0.0f,1.0f);
                quat_combined = quat_y_axis*quat_z_axis;

                curr_cp->setRotation(quat_combined);

                prev_itr = curr_itr;

            }

        }


        osg::PositionAttitudeTransform* animation_transform = new osg::PositionAttitudeTransform;
        animation_transform->setDataVariance(osg::Object::DYNAMIC);
        animation_transform->setPivotPoint(pivot);
        animation->setPivotPoint(pivot);
        animation_transform->setUpdateCallback(animation);

        animation_transform->setReferenceFrame(positionData.absolute_path ?
                                                    osg::Transform::ABSOLUTE_RF:
                                                    osg::Transform::RELATIVE_RF);

        animation_transform->addChild(subgraph);

        subgraph = animation_transform;
    }

    findImageStreamsAndAddCallbacks(subgraph);

    addToCurrentLayer(subgraph);
}

class DraggerVolumeTileCallback : public osgManipulator::DraggerCallback
{
public:

    DraggerVolumeTileCallback(osgVolume::VolumeTile* volume, osgVolume::Locator* locator):
        _volume(volume),
        _locator(locator) {}


    virtual bool receive(const osgManipulator::MotionCommand& command);


    osg::observer_ptr<osgVolume::VolumeTile>    _volume;
    osg::ref_ptr<osgVolume::Locator>            _locator;

    osg::Matrix _startMotionMatrix;

    osg::Matrix _localToWorld;
    osg::Matrix _worldToLocal;

};

bool DraggerVolumeTileCallback::receive(const osgManipulator::MotionCommand& command)
{
    if (!_locator) return false;

    switch (command.getStage())
    {
        case osgManipulator::MotionCommand::START:
        {
            // Save the current matrix
            _startMotionMatrix = _locator->getTransform();

            // Get the LocalToWorld and WorldToLocal matrix for this node.
            osg::NodePath nodePathToRoot;
            osgManipulator::computeNodePathToRoot(*_volume,nodePathToRoot);
            _localToWorld = _startMotionMatrix * osg::computeLocalToWorld(nodePathToRoot);
            _worldToLocal = osg::Matrix::inverse(_localToWorld);

            return true;
        }
        case osgManipulator::MotionCommand::MOVE:
        {
            // Transform the command's motion matrix into local motion matrix.
            osg::Matrix localMotionMatrix = _localToWorld * command.getWorldToLocal()
                                            * command.getMotionMatrix()
                                            * command.getLocalToWorld() * _worldToLocal;

            // Transform by the localMotionMatrix
            _locator->setTransform(localMotionMatrix * _startMotionMatrix);

            // OSG_NOTICE<<"New locator matrix "<<_locator->getTransform()<<std::endl;

            return true;
        }
        case osgManipulator::MotionCommand::FINISH:
        {
            return true;
        }
        case osgManipulator::MotionCommand::NONE:
        default:
            return false;
    }
}

void SlideShowConstructor::addVolume(const std::string& filename, const PositionData& in_positionData, const VolumeData& volumeData)
{
    // osg::Object::DataVariance defaultMatrixDataVariance = osg::Object::DYNAMIC; // STATIC

    PositionData positionData(in_positionData);

    osg::ref_ptr<osgDB::Options> options = _options;
    if (!volumeData.options.empty())
    {
        options = _options->cloneOptions();
        options->setOptionString(volumeData.options);
    }

    std::string foundFile = filename;
    osg::ref_ptr<osg::Image> image;
    osg::ref_ptr<osgVolume::Volume> volume;
    osg::ref_ptr<osgVolume::VolumeTile> tile;
    osg::ref_ptr<osgVolume::ImageLayer> layer;

    // check for wild cards
    if (filename.find('*')!=std::string::npos)
    {
        osgDB::DirectoryContents filenames = osgDB::expandWildcardsInFilename(filename);
        if (filenames.empty()) return;

        // make sure images are in alphabetical order.
        std::sort(filenames.begin(), filenames.end());

        typedef std::vector< osg::ref_ptr<osg::Image> > Images;
        Images images;
        for(osgDB::DirectoryContents::iterator itr = filenames.begin();
            itr != filenames.end();
            ++itr)
        {
            osg::ref_ptr<osg::Image> loadedImage = osgDB::readImageFile(*itr, options.get());
            if (loadedImage.valid())
            {
                images.push_back(loadedImage.get());
            }
        }

        image = osg::createImage3DWithAlpha(images);
    }
    else
    {
        osgDB::FileType fileType = osgDB::fileType(foundFile);
        if (fileType == osgDB::FILE_NOT_FOUND)
        {
            foundFile = findFileAndRecordPath(foundFile);
            fileType = osgDB::fileType(foundFile);
        }

        if (fileType == osgDB::DIRECTORY)
        {
            image = osgDB::readImageFile(foundFile+".dicom", options.get());
        }
        else if (fileType == osgDB::REGULAR_FILE)
        {
            std::string ext = osgDB::getFileExtension(foundFile);
            if (ext=="osg" || ext=="ive" || ext=="osgx" || ext=="osgb" || ext=="osgt")
            {
                osg::ref_ptr<osg::Object> obj = osgDB::readObjectFile(foundFile);
                image = dynamic_cast<osg::Image*>(obj.get());
                volume = dynamic_cast<osgVolume::Volume*>(obj.get());
            }
            else
            {
                image = osgDB::readImageFile( foundFile, options.get() );
            }
        }
        else
        {
            // not found image, so fallback to plugins/callbacks to find the model.
            image = osgDB::readImageFile( filename, options.get() );
            if (image) recordOptionsFilePath(options.get() );
        }
    }

    if (!image && !volume) return;

    if (positionData.scale.x()<0.0)
    {
        image->flipHorizontal();
        positionData.scale.x() = fabs(positionData.scale.x());

        OSG_INFO<<"addVolume(..) image->flipHorizontal();"<<std::endl;
    }

    if (positionData.scale.y()<0.0)
    {
        image->flipVertical();
        positionData.scale.y() = fabs(positionData.scale.y());

        OSG_INFO<<"addVolume(..) image->flipVertical();"<<std::endl;
    }

    if (positionData.scale.z()<0.0)
    {
        image->flipDepth();
        positionData.scale.z() = fabs(positionData.scale.z());

        OSG_INFO<<"addVolume(..) image->flipDepth();"<<std::endl;
    }

    if (volume.valid())
    {
        if (!tile)
        {
            if (volume->getNumChildren()>0)
            {
                tile = dynamic_cast<osgVolume::VolumeTile*>(volume->getChild(0));
            }
        }
    }
    else
    {
        volume = new osgVolume::Volume;
    }

    if (tile.valid())
    {
        layer = dynamic_cast<osgVolume::ImageLayer*>(tile->getLayer());
        image = layer.valid() ? layer->getImage() : 0;
    }
    else
    {
        if (!image) return;

        tile = new osgVolume::VolumeTile;
        volume->addChild(tile.get());
    }

    if (!layer)
    {
        if (!image) return;

        osg::ref_ptr<osgVolume::ImageDetails> details = dynamic_cast<osgVolume::ImageDetails*>(image->getUserData());
        osg::ref_ptr<osg::RefMatrix> matrix = details ? details->getMatrix() : dynamic_cast<osg::RefMatrix*>(image->getUserData());

        osg::ref_ptr<osgVolume::ImageLayer> layer = new osgVolume::ImageLayer(image.get());
        if (details)
        {
            layer->setTexelOffset(details->getTexelOffset());
            layer->setTexelScale(details->getTexelScale());
        }
        layer->rescaleToZeroToOneRange();

        if (matrix.valid())
        {
            layer->setLocator(new osgVolume::Locator(*matrix));
            osg::Matrix tm = osg::Matrix::scale(volumeData.region[3]-volumeData.region[0], volumeData.region[4]-volumeData.region[1], volumeData.region[5]-volumeData.region[2]) *
                            osg::Matrix::translate(volumeData.region[0],volumeData.region[1],volumeData.region[2]);
            tile->setLocator(new osgVolume::Locator(tm * (*matrix)));
        }


        tile->setLayer(layer.get());

        osgVolume::SwitchProperty* sp = new osgVolume::SwitchProperty;
        sp->setActiveProperty(0);

        osgVolume::AlphaFuncProperty* ap = new osgVolume::AlphaFuncProperty(volumeData.cutoffValue);
        osgVolume::TransparencyProperty* tp = new osgVolume::TransparencyProperty(volumeData.alphaValue);
        osgVolume::SampleDensityProperty* sd = new osgVolume::SampleDensityProperty(volumeData.sampleDensityValue);
        osgVolume::SampleDensityWhenMovingProperty* sdm = (volumeData.sampleDensityWhenMovingValue > 0.0f) ? (new osgVolume::SampleDensityWhenMovingProperty(volumeData.sampleDensityWhenMovingValue)) : 0;
        osgVolume::TransferFunctionProperty* tfp = volumeData.transferFunction.valid() ? new osgVolume::TransferFunctionProperty(volumeData.transferFunction.get()) : 0;

        {
            // Standard
            osgVolume::CompositeProperty* cp = new osgVolume::CompositeProperty;
            cp->addProperty(ap);
            cp->addProperty(sd);
            cp->addProperty(tp);
            if (sdm) cp->addProperty(sdm);
            if (tfp) cp->addProperty(tfp);

            sp->addProperty(cp);
        }

        {
            // Light
            osgVolume::CompositeProperty* cp = new osgVolume::CompositeProperty;
            cp->addProperty(ap);
            cp->addProperty(sd);
            cp->addProperty(tp);
            cp->addProperty(new osgVolume::LightingProperty);
            if (sdm) cp->addProperty(sdm);
            if (tfp) cp->addProperty(tfp);

            sp->addProperty(cp);
        }

        {
            // Isosurface
            osgVolume::CompositeProperty* cp = new osgVolume::CompositeProperty;
            cp->addProperty(sd);
            cp->addProperty(tp);
            cp->addProperty(new osgVolume::IsoSurfaceProperty(volumeData.cutoffValue));
            if (sdm) cp->addProperty(sdm);
            if (tfp) cp->addProperty(tfp);

            sp->addProperty(cp);
        }

        {
            // MaximumIntensityProjection
            osgVolume::CompositeProperty* cp = new osgVolume::CompositeProperty;
            cp->addProperty(ap);
            cp->addProperty(sd);
            cp->addProperty(tp);
            cp->addProperty(new osgVolume::MaximumIntensityProjectionProperty);
            if (sdm) cp->addProperty(sdm);
            if (tfp) cp->addProperty(tfp);

            sp->addProperty(cp);
        }

        switch(volumeData.shadingModel)
        {
            case(VolumeData::Standard):                     sp->setActiveProperty(0); break;
            case(VolumeData::Light):                        sp->setActiveProperty(1); break;
            case(VolumeData::Isosurface):                   sp->setActiveProperty(2); break;
            case(VolumeData::MaximumIntensityProjection):   sp->setActiveProperty(3); break;
        }

        layer->addProperty(sp);
        tile->setVolumeTechnique(new osgVolume::RayTracedTechnique);
        tile->setEventCallback(new osgVolume::PropertyAdjustmentCallback());
    }

    osg::ref_ptr<osg::Node> model = volume.get();

    if (volumeData.useTabbedDragger || volumeData.useTrackballDragger)
    {
        osg::ref_ptr<osg::Group> group = new osg::Group;

        osg::ref_ptr<osgManipulator::Dragger> dragger;
        if (volumeData.useTabbedDragger)
        {
            if (volumeData.useTrackballDragger)
                dragger = new osgManipulator::TabBoxTrackballDragger;
            else
                dragger = new osgManipulator::TabBoxDragger;
        }
        else
            dragger = new osgManipulator::TrackballDragger();

        dragger->setupDefaultGeometry();
        dragger->setHandleEvents(true);
        dragger->setActivationModKeyMask(osgGA::GUIEventAdapter::MODKEY_SHIFT);
        dragger->addDraggerCallback(new DraggerVolumeTileCallback(tile.get(), tile->getLocator()));
        dragger->setMatrix(osg::Matrix::translate(0.5,0.5,0.5)*tile->getLocator()->getTransform());


        group->addChild(dragger.get());

        //dragger->addChild(volume.get());

        group->addChild(volume.get());

        model = group.get();
    }



    ModelData modelData;
    addModel(model.get(), positionData, modelData);
}

bool SlideShowConstructor::attachTexMat(osg::StateSet* stateset, const ImageData& imageData, float s, float t, bool textureRectangle)
{
    float xScale = textureRectangle ? s : 1.0f;
    float yScale = textureRectangle ? t : 1.0f;

    float sx = (textureRectangle ? s : 1.0f) / (imageData.region_in_pixel_coords ? s : 1.0f);
    float sy = (textureRectangle ? t : 1.0f) / (imageData.region_in_pixel_coords ? t : 1.0f);

    float x1 = imageData.region[0]*sx;
    float y1 = imageData.region[1]*sy;
    float x2 = imageData.region[2]*sx;
    float y2 = imageData.region[3]*sy;

    if (x1!=0.0f || y1!=0.0f || x2!=xScale || y2 != yScale ||
        imageData.texcoord_rotate != 0.0f)
    {
        osg::TexMat* texmat = new osg::TexMat;
        texmat->setMatrix(osg::Matrix::translate(-0.5f*xScale,-0.5f*yScale,0.0f)*
                          osg::Matrix::rotate(osg::DegreesToRadians(imageData.texcoord_rotate),0.0f,0.0f,1.0f)*
                          osg::Matrix::translate(0.5f*xScale,0.5f*yScale,0.0f)*
                          osg::Matrix::scale((x2-x1)/xScale,(y2-y1)/yScale,1.0f)*
                          osg::Matrix::translate(x1,
                                                 y1,
                                                 0.0f));

        stateset->setTextureAttribute(0,texmat);
        return true;
    }
    return false;
}

osg::Node* SlideShowConstructor::attachMaterialAnimation(osg::Node* model, const PositionData& positionData)
{
    AnimationMaterial* animationMaterial = 0;

    if (!positionData.animation_material_filename.empty())
    {
#if 0
        std::string absolute_animation_file_path = osgDB::findDataFile(positionData.animation_material_filename, _options.get());
        if (!absolute_animation_file_path.empty())
        {
            std::ifstream animation_filestream(absolute_animation_file_path.c_str());
            if (!animation_filestream.eof())
            {
                animationMaterial = new AnimationMaterial;
                animationMaterial->read(animation_filestream);
            }
        }
#else
        osg::ref_ptr<osg::Object> object = osgDB::readObjectFile(positionData.animation_material_filename, _options.get());
        animationMaterial = dynamic_cast<AnimationMaterial*>(object.get());
#endif

    }
    else if (!positionData.fade.empty())
    {
        std::istringstream iss(positionData.fade);

        animationMaterial = new AnimationMaterial;
        while (!iss.fail() && !iss.eof())
        {
            float time=1.0f, alpha=1.0f;
            iss >> time >> alpha;
            if (!iss.fail())
            {
                osg::Material* material = new osg::Material;
                material->setAmbient(osg::Material::FRONT_AND_BACK,osg::Vec4(1.0f,1.0f,1.0f,alpha));
                material->setDiffuse(osg::Material::FRONT_AND_BACK,osg::Vec4(1.0f,1.0f,1.0f,alpha));
                animationMaterial->insert(time,material);
            }
        }
    }

    if (animationMaterial)
    {
        animationMaterial->setLoopMode(positionData.animation_material_loop_mode);

        AnimationMaterialCallback* animationMaterialCallback = new AnimationMaterialCallback(animationMaterial);
        animationMaterialCallback->setTimeOffset(positionData.animation_material_time_offset);
        animationMaterialCallback->setTimeMultiplier(positionData.animation_material_time_multiplier);

        osg::Group* decorator = new osg::Group;
        decorator->addChild(model);

        decorator->setUpdateCallback(animationMaterialCallback);

        if (animationMaterial->requiresBlending())
        {
            SetToTransparentBin sttb;
            decorator->accept(sttb);
        }

        return decorator;
    }

    return model;
}

osg::AnimationPathCallback* SlideShowConstructor::getAnimationPathCallback(const PositionData& positionData)
{
    if (!positionData.path.empty())
    {
        // need to create an Options object with cache off to prevent sharing of animation paths
        osg::ref_ptr<osgDB::Options> options = _options.valid() ? _options->cloneOptions() : new osgDB::Options;
        options->setObjectCacheHint(osgDB::Options::CACHE_NONE);

        osg::ref_ptr<osg::Object> object = osgDB::readObjectFile(positionData.path, options.get());
        osg::AnimationPath* animation = dynamic_cast<osg::AnimationPath*>(object.get());
        if (animation)
        {
            if (positionData.frame==SlideShowConstructor::SLIDE)
            {
                osg::AnimationPath::TimeControlPointMap& controlPoints = animation->getTimeControlPointMap();
                for(osg::AnimationPath::TimeControlPointMap::iterator itr=controlPoints.begin();
                    itr!=controlPoints.end();
                    ++itr)
                {
                    osg::AnimationPath::ControlPoint& cp = itr->second;
                    cp.setPosition(convertSlideToModel(cp.getPosition()+positionData.position));
                }
            }

            animation->setLoopMode(positionData.path_loop_mode);

            osg::AnimationPathCallback* apc = new osg::AnimationPathCallback(animation);
            apc->setTimeOffset(positionData.path_time_offset);
            apc->setTimeMultiplier(positionData.path_time_multiplier);
            apc->setUseInverseMatrix(positionData.inverse_path);

            OSG_INFO<<"UseInverseMatrix "<<positionData.inverse_path<<std::endl;

            return apc;

        }

    }
    return 0;
}

osg::Vec3 SlideShowConstructor::computePositionInModelCoords(const PositionData& positionData) const
{
    if (positionData.frame==SLIDE)
    {
        OSG_INFO<<"********* Scaling from slide coords to model coords"<<std::endl;
        return convertSlideToModel(positionData.position);
    }
    else
    {
        OSG_INFO<<"keeping original model coords"<<std::endl;
        return positionData.position;
    }
}

osg::Vec3 SlideShowConstructor::convertSlideToModel(const osg::Vec3& position) const
{
    return osg::Vec3(_slideOrigin+osg::Vec3(_slideWidth*position.x(),0.0f,_slideHeight*position.y()))*(1.0f-position.z());
}

osg::Vec3 SlideShowConstructor::convertModelToSlide(const osg::Vec3& position) const
{
    return osg::Vec3((position.x()*(_slideOrigin.y()/position.y())-_slideOrigin.x())/_slideWidth,
                     (position.z()*(_slideOrigin.y()/position.y())-_slideOrigin.z())/_slideHeight,
                     1.0f-position.y()/_slideOrigin.y());
}

void SlideShowConstructor::updatePositionFromInModelCoords(const osg::Vec3& vertex, PositionData& positionData) const
{
    if (positionData.frame==SLIDE)
    {
        positionData.position = convertModelToSlide(vertex);
    }
    else
    {
        positionData.position = vertex;
    }
}

void SlideShowConstructor::recordOptionsFilePath(const osgDB::Options* options)
{
    if (options)
    {
        std::string filename_used = _options->getPluginStringData("filename");
        std::string path = osgDB::getFilePath(filename_used);
        if (!path.empty() && _filePathData.valid())
        {
            osgDB::FilePathList::iterator itr = std::find(_filePathData->filePathList.begin(),_filePathData->filePathList.end(),path);
            if (itr==_filePathData->filePathList.end())
            {
                OSG_INFO<<"SlideShowConstructor::recordOptionsFilePath(..) - new path to record path="<<path<<" filename_used="<<filename_used<<std::endl;
                _filePathData->filePathList.push_front(path);
            }
        }
    }
}

