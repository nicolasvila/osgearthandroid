/* -*-c++-*- */
/* osgEarth - Dynamic map generation toolkit for OpenSceneGraph
 * Copyright 2008-2012 Pelican Mapping
 * http://osgearth.org
 *
 * osgEarth is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */
#include <osgEarthSymbology/IconSymbol>
#include <osgEarthSymbology/IconResource>
#include <osgEarthSymbology/Style>
#include <osgEarth/ThreadingUtils>
#include <osgEarth/Registry>
#include <osgEarth/ImageUtils>
#include <osgDB/Options>

using namespace osgEarth;
using namespace osgEarth::Symbology;

IconSymbol::IconSymbol( const Config& conf ) :
InstanceSymbol( conf ),
_alignment    ( ALIGN_CENTER_BOTTOM ),
_heading      ( NumericExpression(0.0) )
{
    mergeConfig( conf );
}

Config 
IconSymbol::getConfig() const
{
    Config conf = InstanceSymbol::getConfig();
    conf.key() = "icon";

    conf.addIfSet( "alignment", "left_top",      _alignment, ALIGN_LEFT_TOP );
    conf.addIfSet( "alignment", "left_center",   _alignment, ALIGN_LEFT_CENTER );
    conf.addIfSet( "alignment", "left_bottom",   _alignment, ALIGN_LEFT_BOTTOM );
    conf.addIfSet( "alignment", "center_top",    _alignment, ALIGN_CENTER_TOP );
    conf.addIfSet( "alignment", "center_center", _alignment, ALIGN_CENTER_CENTER );
    conf.addIfSet( "alignment", "center_bottom", _alignment, ALIGN_CENTER_BOTTOM );
    conf.addIfSet( "alignment", "right_top",     _alignment, ALIGN_RIGHT_TOP );
    conf.addIfSet( "alignment", "right_center",  _alignment, ALIGN_RIGHT_CENTER );
    conf.addIfSet( "alignment", "right_bottom",  _alignment, ALIGN_RIGHT_BOTTOM );

    conf.addObjIfSet( "heading", _heading );

    conf.addNonSerializable( "IconSymbol::image", _image.get() );
    return conf;
}

void 
IconSymbol::mergeConfig( const Config& conf )
{
    conf.getIfSet( "alignment", "left_top",      _alignment, ALIGN_LEFT_TOP );
    conf.getIfSet( "alignment", "left_center",   _alignment, ALIGN_LEFT_CENTER );
    conf.getIfSet( "alignment", "left_bottom",   _alignment, ALIGN_LEFT_BOTTOM );
    conf.getIfSet( "alignment", "center_top",    _alignment, ALIGN_CENTER_TOP );
    conf.getIfSet( "alignment", "center_center", _alignment, ALIGN_CENTER_CENTER );
    conf.getIfSet( "alignment", "center_bottom", _alignment, ALIGN_CENTER_BOTTOM );
    conf.getIfSet( "alignment", "right_top",     _alignment, ALIGN_RIGHT_TOP );
    conf.getIfSet( "alignment", "right_center",  _alignment, ALIGN_RIGHT_CENTER );
    conf.getIfSet( "alignment", "right_bottom",  _alignment, ALIGN_RIGHT_BOTTOM );

    conf.getObjIfSet( "heading", _heading );

    _image = conf.getNonSerializable<osg::Image>( "IconSymbol::image" );
}

namespace
{
    static Threading::Mutex s_getImageMutex;
}

osg::Image*
IconSymbol::getImage( unsigned maxSize ) const
{
    if ( !_image.valid() && _url.isSet() )
    {
        Threading::ScopedMutexLock lock(s_getImageMutex);
        if ( !_image.valid() )
        {
            osg::ref_ptr<osgDB::Options> dbOptions = Registry::instance()->cloneOrCreateOptions();
            dbOptions->setObjectCacheHint( osgDB::Options::CACHE_IMAGES );
            _image = URI(_url->eval(), _url->uriContext()).getImage( dbOptions.get() );
            if ( _image.valid() && (maxSize < (unsigned int)_image->s() || maxSize < (unsigned int)_image->t()) )
            {
                unsigned new_s, new_t;

                if ( _image->s() >= _image->t() ) {
                    new_s = maxSize;
                    float ratio = (float)new_s/(float)_image->s();
                    new_t = (unsigned)((float)_image->t() * ratio);
                }
                else {
                    new_t = maxSize;
                    float ratio = (float)new_t/(float)_image->t();
                    new_s = (unsigned)((float)_image->s() * ratio);
                }
                    
                osg::ref_ptr<osg::Image> result;
                ImageUtils::resizeImage( _image.get(), new_s, new_t, result );
                _image = result.get();
            }
        }
    }
    return _image.get();
}

InstanceResource*
IconSymbol::createResource() const 
{
    return new IconResource();
}


void
IconSymbol::parseSLD(const Config& c, Style& style)
{
    if ( match(c.key(), "icon") ) {
        style.getOrCreate<IconSymbol>()->url() = c.value();
        style.getOrCreate<IconSymbol>()->url()->setURIContext( c.referrer() );
    }
    else if ( match(c.key(),"icon-library") ) {
        style.getOrCreate<IconSymbol>()->libraryName() = StringExpression(c.value());
    }
    else if ( match(c.key(), "icon-placement") ) {
        if      ( match(c.value(), "vertex") )   
            style.getOrCreate<IconSymbol>()->placement() = ModelSymbol::PLACEMENT_VERTEX;
        else if ( match(c.value(), "interval") ) 
            style.getOrCreate<IconSymbol>()->placement() = ModelSymbol::PLACEMENT_INTERVAL;
        else if ( match(c.value(), "random") )   
            style.getOrCreate<IconSymbol>()->placement() = ModelSymbol::PLACEMENT_RANDOM;
        else if ( match(c.value(), "centroid") ) 
            style.getOrCreate<IconSymbol>()->placement() = ModelSymbol::PLACEMENT_CENTROID;
    }
    else if ( match(c.key(), "icon-density") ) {
        style.getOrCreate<IconSymbol>()->density() = as<float>(c.value(), 1.0f);
    }
    else if ( match(c.key(), "icon-random-seed") ) {
        style.getOrCreate<IconSymbol>()->randomSeed() = as<unsigned>(c.value(), 0);
    }
    else if ( match(c.key(), "icon-scale") ) {
        style.getOrCreate<IconSymbol>()->scale() = NumericExpression(c.value());
    }
    else if ( match(c.key(), "icon-align") ) {
        if      ( match(c.value(), "left-top") )      
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_LEFT_TOP;
        else if ( match(c.value(), "left-center") )   
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_LEFT_CENTER;
        else if ( match(c.value(), "left-bottom") )   
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_LEFT_BOTTOM;
        else if ( match(c.value(), "center-top")  )   
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_CENTER_TOP;
        else if ( match(c.value(), "center-center") ) 
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_CENTER_CENTER;
        else if ( match(c.value(), "center-bottom") ) 
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_CENTER_BOTTOM;
        else if ( match(c.value(), "right-top") )     
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_RIGHT_TOP;
        else if ( match(c.value(), "right-center") )  
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_RIGHT_CENTER;
        else if ( match(c.value(), "right-bottom") )  
            style.getOrCreate<IconSymbol>()->alignment() = IconSymbol::ALIGN_RIGHT_BOTTOM;
    }
}