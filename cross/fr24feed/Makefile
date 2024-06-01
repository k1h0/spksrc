PKG_NAME = fr24feed
PKG_VERS = 1.0.46
PKG_EXT = tgz
PKG_DIST_NAME = $(PKG_NAME)_$(PKG_VERS)$(PKG_VERS_ADD)_$(PKG_DIST_ARCH).$(PKG_EXT)
PKG_DIST_SITE = https://repo-feed.flightradar24.com/$(PKG_DIST_SYSTEM)_binaries
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)
EXTRACT_PATH = $(WORK_DIR)/$(PKG_DIR)

include ../../mk/spksrc.archs.mk

# http://repo.feed.flightradar24.com/fr24feed_versions.json


# use digests with multiple files and individual dist names
# both lists must have the same order

ifeq ($(findstring $(ARCH), $(x64_ARCHS)),$(ARCH))
PKG_DIST_ARCH = amd64
PKG_DIST_SYSTEM = linux
PKG_VERS_ADD = -2
endif
ifeq ($(findstring $(ARCH), $(ARMv7_ARCHS)),$(ARCH))
PKG_DIST_ARCH = armhf
PKG_DIST_SYSTEM = rpi
PKG_VERS_ADD = -1
endif
ifeq ($(findstring $(ARCH), $(ARMv8_ARCHS)),$(ARCH))
PKG_DIST_ARCH = arm64
PKG_DIST_SYSTEM = rpi
PKG_VERS_ADD = -1
endif

ifeq ($(PKG_DIST_ARCH),)
$(error Unsupported ARCH $(ARCH))
endif

HOMEPAGE = https://www.flightradar24.com/share-your-data
COMMENT  = Flightradar24 operates the world's largest network of ADS-B/Mode S receivers. This network, together with government air traffic control and other data sources, is how Flightradar24 is able to track aircraft around the globe.
LICENSE  = https://www.flightradar24.com/terms-and-conditions

INSTALL_TARGET = fr24feed_runtime_custom_install

include ../../mk/spksrc.install-resources.mk

.PHONY: fr24feed_runtime_custom_install
fr24feed_runtime_custom_install:
	@install -m 777 -d $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin
	@install -m 766 $(EXTRACT_PATH)/$(PKG_NAME)_$(PKG_DIST_ARCH)/$(PKG_NAME) $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/
	@echo "$(PKG_DIST_SITE)/$(PKG_DIST_NAME)" > $(INSTALL_DIR)/$(INSTALL_PREFIX)/bin/URL