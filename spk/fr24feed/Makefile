SPK_NAME = fr24feed
SPK_VERS = 1.0.46
SPK_REV = 0
SPK_ICON = src/flightradar24.png

DEPENDS = cross/fr24feed
# SPK_DEPENDS = dump1090-fa

REQUIRED_MIN_DSM = 7.0
UNSUPPORTED_ARCHS = comcerto2k

MAINTAINER = SynoCommunity
DESCRIPTION = fr24feed.
DESCRIPTION_FRE = fr24feed.
DESCRIPTION_SPN = fr24feed.
STARTABLE = yes
DISPLAY_NAME = Flightradar24 Feeder
CHANGELOG = "1. Text.<br/>2. Text."

HOMEPAGE = https://www.flightradar24.com/
LICENSE  = https://www.flightradar24.com/terms-and-conditions

WIZARDS_DIR = src/wizard/

SERVICE_USER = auto
SERVICE_SETUP = src/service-setup.sh
SERVICE_PORT = 8754
SERVICE_PORT_TITLE = Flightradar24 Feeder Web UI

# Admin link for in DSM UI
ADMIN_PORT = $(SERVICE_PORT)

POST_STRIP_TARGET = fr24feed_extra_install

SPK_COMMANDS  = bin/fr24feed
SPK_LINKS = /usr/local/bin/fr24feed:bin/fr24feed

include ../../mk/spksrc.spk.mk

.PHONY: fr24feed_extra_install
fr24feed_extra_install:
	install -m 755 -d $(STAGING_DIR)/var/etc
	install -m 644 src/fr24feed.ini $(STAGING_DIR)/var/etc/fr24feed.ini

