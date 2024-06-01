PKG_NAME = libbladeRF
DIST_NAME = bladeRF
PKG_VERS = 2.5.0
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)_v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/Nuand/bladeRF/archive/refs/tags
PKG_DIR = $(DIST_NAME)-$(PKG_NAME)_v$(PKG_VERS)/host
# https://github.com/Nuand/bladeRF/archive/refs/tags/libbladeRF_v2.5.0.tar.gz

ANALOG_DEVICES_REV = 0bba46e6f6f75785a65d425ece37d0a04daf6157
ANALOG_DEVICES_DIST = https://github.com/analogdevicesinc/no-OS/archive/$(ANALOG_DEVICES_REV).zip

DEPENDS = cross/libusb

HOMEPAGE = https://www.nuand.com/libbladeRF-doc/v2.5.0/
COMMENT  = This library supports the Nuand bladeRF and bladeRF Micro USB 3.0 Software Defined Radio (SDR).
LICENSE  = LGPLv2.1

CMAKE_ARGS  = "-DUDEV_RULES_PATH=${INSTALL_PREFIX}/rules.d"
CMAKE_ARGS += "-DBLADERF_GROUP=synopkgs"

POST_EXTRACT_TARGET = libbladeRF_post_extract

include ../../mk/spksrc.cross-cmake.mk

.PHONY: libbladeRF_post_extract
libbladeRF_post_extract:
	wget -nv -P "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/" ${ANALOG_DEVICES_DIST}
	unzip -q "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/${ANALOG_DEVICES_REV}.zip" -d "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/"
	cp -vaR "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/no-OS-${ANALOG_DEVICES_REV}/." "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/"
	rm -rf "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/no-OS-${ANALOG_DEVICES_REV}"
	rm -f "${EXTRACT_PATH}/${PKG_DIR}/../thirdparty/analogdevicesinc/no-OS/${ANALOG_DEVICES_REV}.zip"