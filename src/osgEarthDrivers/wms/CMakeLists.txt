
SET(TARGET_SRC
    GeoNode.cpp
    SceneGraphChanges.cpp
    ReaderWriterWMS.cpp
    TileService.cpp)

SET(TARGET_H
    GeoNode
    SceneGraphChanges
    TileService
    WMSOptions
)

SET(TARGET_COMMON_LIBRARIES osgEarthUtil)

SETUP_PLUGIN(osgearth_wms)

# to install public driver includes:
SET(LIB_NAME wms)
SET(LIB_PUBLIC_HEADERS ${TARGET_H} )
INCLUDE(ModuleInstallOsgEarthDriverIncludes OPTIONAL)

