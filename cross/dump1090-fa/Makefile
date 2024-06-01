PKG_NAME = dump1090-fa
PKG_VERS = 9.0
PKG_EXT = tar.gz
PKG_DIST_NAME = v$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = https://github.com/flightaware/archive/refs/tags/
PKG_DIR = dump1090-$(PKG_VERS)

BUILD_DEPENDS  = cross/libncurses
BUILD_DEPENDS += cross/librtlsdr
BUILD_DEPENDS += cross/libbladeRF
BUILD_DEPENDS += cross/libhackrf

HOMEPAGE = http://flightaware.com/
COMMENT  = dump1090-fa is a ADS-B, Mode S, and Mode 3A/3C demodulator and decoder that will receive and decode aircraft transponder messages received via a directly connected software defined radio, or from data provided over a network connection.
LICENSE  = GPLv2/GPLv3

# gcc >= 5.1 required
REQUIRED_MIN_DSM = 7.0
UNSUPPORTED_ARCHS = comcerto2k

COMPILE_MAKE_OPTIONS = DUMP1090_VERSION=$(PKG_VERS)
COMPILE_MAKE_OPTIONS += UNAME="Linux"
COMPILE_MAKE_OPTIONS += ARCH="$(ARCH)"
COMPILE_MAKE_OPTIONS += RTLSDR="yes"
COMPILE_MAKE_OPTIONS += BLADERF="yes"
COMPILE_MAKE_OPTIONS += HACKRF="yes"
COMPILE_MAKE_OPTIONS += LIMESDR="no"
COMPILE_MAKE_OPTIONS += SOAPYSDR="no"

ADDITIONAL_LDFLAGS  = "-lbladeRF"

POST_EXTRACT_TARGET = dump1090_post_extract
INSTALL_TARGET = dump1090_install

include ../../mk/spksrc.cross-cc.mk

.PHONY: dump1090_post_extract
dump1090_post_extract:
	cd $(EXTRACT_PATH)/$(PKG_DIR) && touch configure && chmod +x configure

.PHONY: dump1090_install
dump1090_install:
	@$(MSG) "Installing $(PKG_NAME)"
	@$(MSG) "INSTALL_DIR=$(INSTALL_DIR) INSTALL_PREFIX=$(INSTALL_PREFIX) WORK_DIR=$(WORK_DIR)"

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin
	cp  $(EXTRACT_PATH)/$(PKG_DIR)/dump1090  $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/dump1090-fa
	cp  $(EXTRACT_PATH)/$(PKG_DIR)/view1090  $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/view1090

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/dump1090-fa

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/skyaware/html
	cp -r $(EXTRACT_PATH)/$(PKG_DIR)/public_html/*  $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/skyaware/html

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/lib/dump1090-fa/
	cp -r $(EXTRACT_PATH)/$(PKG_DIR)/starch-benchmark  $(INSTALL_DIR)/$(INSTALL_PREFIX)/lib/dump1090-fa/
	cp -r $(EXTRACT_PATH)/$(PKG_DIR)/debian/generate-wisdom $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/dump1090-fa/

	cp -r $(EXTRACT_PATH)/$(PKG_DIR)/debian/start-dump1090-fa $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/dump1090-fa/

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/etc/default
	cp $(EXTRACT_PATH)/$(PKG_DIR)/debian/dump1090-fa.default  $(INSTALL_DIR)/$(INSTALL_PREFIX)/etc/default/dump1090-fa

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/lib/systemd/system
	cp $(EXTRACT_PATH)/$(PKG_DIR)/debian/dump1090-fa.service  $(INSTALL_DIR)/$(INSTALL_PREFIX)/lib/systemd/system/dump1090-fa.service

	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/etc/lighttpd/conf.d
	cp -r $(EXTRACT_PATH)/$(PKG_DIR)/debian/lighttpd/* $(INSTALL_DIR)/$(INSTALL_PREFIX)/etc/lighttpd/conf.d
	mkdir -p $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/dump1090-fa/bladerf
	cp -r $(EXTRACT_PATH)/$(PKG_DIR)/bladerf/* $(INSTALL_DIR)/$(INSTALL_PREFIX)/share/dump1090-fa/bladerf

#	install -Dm644 $(EXTRACT_PATH)/$(PKG_DIR)/../rtl-sdr/rtl-sdr.rules $(INSTALL_DIR)/$(INSTALL_PREFIX)/etc/udev/rules.d/fa-rtl-sdr.rules
#	install -m 755 -d $(STAGING_DIR)/rules.d
#	install -m 644 src/60-$(SPK_NAME).rules $(STAGING_DIR)/rules.d/60-$(SPK_NAME).rules