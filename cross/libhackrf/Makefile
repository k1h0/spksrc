PKG_NAME = libhackrf
DIST_NAME = hackrf
PKG_VERS = 2024.02.1
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/greatscottgadgets/hackrf/archive/refs/tags
PKG_DIR = $(DIST_NAME)-$(PKG_VERS)/host
# https://github.com/greatscottgadgets/hackrf/archive/refs/tags/v2024.02.1.tar.gz

DEPENDS  = cross/libusb
DEPENDS += cross/fftw_f

HOMEPAGE = https://greatscottgadgets.com/hackrf/
COMMENT  = libhackrf is a low level library that enables software on your computer to operate with HackRF.
LICENSE  = GPLv2

CMAKE_ARGS  = "-DUDEV_RULES_PATH=${INSTALL_PREFIX}/rules.d"
CMAKE_ARGS += "-DUDEV_RULES_GROUP=synopkgs"

include ../../mk/spksrc.cross-cmake.mk
