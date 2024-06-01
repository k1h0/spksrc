PKG_NAME = librtlsdr
DIST_NAME = rtl-sdr
PKG_VERS = 2.0.1
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://gitea.osmocom.org/sdr/rtl-sdr/archive
PKG_DIR = $(DIST_NAME)
# https://gitea.osmocom.org/sdr/rtl-sdr/archive/v2.0.1.tar.gz

DEPENDS = cross/libusb

HOMEPAGE = https://osmocom.org/projects/rtl-sdr
COMMENT  = rtl-sdr is a software defined radio (SDR) receiver software for certain low-cost DVB-T/DAB(+) USB dongles based on the Realtek RTL2832U chip.
LICENSE  = GPLv2

COMPILE_MAKE_OPTIONS  = -DINSTALL_UDEV_RULES=ON
CONFIGURE_ARGS  = --enable-udev

POST_INSTALL_TARGET = librtlsdr_install

include ../../mk/spksrc.cross-cmake.mk

.PHONY: librtlsdr_install
librtlsdr_install:
	install -Dm644 $(WORK_DIR)/$(PKG_DIR)/rtl-sdr.rules $(INSTALL_DIR)/$(INSTALL_PREFIX)/rules.d/60-$(PKG_DIR).rules