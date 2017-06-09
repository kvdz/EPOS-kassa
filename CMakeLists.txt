 # project name
    project (Kassa)

    # the oldest stable cmake version we support
    cmake_minimum_required (VERSION 2.8)

    # tell cmake where its modules can be found in our project directory
    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
    list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/src)

    # where we install data directory (if we have any)
    set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

    # what to call that directory where we install data too
    set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
    set (PKGDATADIR "${DATADIR}/kassa")
    set (GETTEXT_PACKAGE "Kassa")
    set (EXEC_NAME "Kassa")
    set (RELEASE_NAME "latina")
    set (VERSION "0.1")
    set (VERSION_INFO "store management system")
    
    configure_file (${CMAKE_SOURCE_DIR}/config.h.cmake ${CMAKE_BINARY_DIR}/config.h)
    add_definitions (-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

    # we're about to use pkgconfig to make sure dependencies are installed so let's find pkgconfig first
    find_package(PkgConfig)

    # now let's actually check for the required dependencies
    pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite)

    add_definitions(${DEPS_CFLAGS})
    link_libraries(${DEPS_LIBRARIES})
    link_directories(${DEPS_LIBRARY_DIRS})

    # make sure we have vala
    find_package(Vala REQUIRED)
    # make sure we use vala
    include(ValaVersion)
    # make sure it's the desired version of vala
    ensure_vala_version("0.26" MINIMUM)

    # files we want to compile
    include(ValaPrecompile)
    vala_precompile(VALA_C ${EXEC_NAME}
        src/Application.vala
        src/GUI/MainWindow.vala
        src/GUI/Views/ProductView.vala
        src/GUI/Widgets/Button.vala
        src/GUI/Widgets/PayDialog.vala
    # tell what libraries to use when compiling
    PACKAGES
        gtk+-3.0
        granite
    CUSTOM_VAPIS
        vapi/config.vapi
    OPTIONS
        --vapidir=${CMAKE_CURRENT_SOURCE_DIR}/vapi/
    )

    # tell cmake what to call the executable we just made
    add_executable(${EXEC_NAME} ${VALA_C})

    # install the binaries we just made
    install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

    # install our .desktop file so the Applications menu will see it
    install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/hello.desktop DESTINATION ${DATADIR}/applications/)
