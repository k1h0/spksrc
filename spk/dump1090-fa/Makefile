SPK_NAME = dump1090-fa
SPK_VERS = 9.0
SPK_REV = 0
SPK_ICON = src/flightaware.png

DEPENDS = cross/dump1090-fa

REQUIRED_MIN_DSM = 7.0
UNSUPPORTED_ARCHS = comcerto2k

MAINTAINER = SynoCommunity
DESCRIPTION = dump1090-fa is a ADS-B, Mode S, and Mode 3A/3C demodulator and decoder that will receive and decode aircraft transponder messages received via a directly connected software defined radio, or from data provided over a network connection.
DESCRIPTION_FRE = dump1090-fa is a ADS-B, Mode S, and Mode 3A/3C demodulator and decoder that will receive and decode aircraft transponder messages received via a directly connected software defined radio, or from data provided over a network connection.
DESCRIPTION_SPN = dump1090-fa is a ADS-B, Mode S, and Mode 3A/3C demodulator and decoder that will receive and decode aircraft transponder messages received via a directly connected software defined radio, or from data provided over a network connection.
STARTABLE = yes
DISPLAY_NAME = dump1090
CHANGELOG = "1. Text.<br/>2. Text."

HOMEPAGE = http://flightaware.com/
LICENSE  = GPLv2/GPLv3

#WIZARDS_DIR = src/wizard/

SERVICE_USER = auto
#SERVICE_WIZARD_SHARENAME = wizard_shared_folder_name
SERVICE_SETUP = src/service-setup.sh
SERVICE_PORT = 8080
SERVICE_PORT_TITLE = Skyaware Web UI

# Admin link for in DSM UI
ADMIN_PORT = $(SERVICE_PORT)

POST_STRIP_TARGET = dump1090_extra_install

SPK_COMMANDS  = bin/dump1090-fa
SPK_COMMANDS += bin/view1090

include ../../mk/spksrc.spk.mk

.PHONY: dump1090_extra_install
dump1090_extra_install:
	@$(MSG) Install service script
	@install -d -m 777 $(STAGING_DIR)/bin/	
	@install -m 755 src/start.sh $(STAGING_DIR)/bin/
