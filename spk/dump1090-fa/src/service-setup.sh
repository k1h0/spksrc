#!/bin/sh

# Helper script that reads ./etc/default/dump1090-fa
# and either starts dump1090-fa with the configured
# arguments, or exits with status 64 to tell systemd
# not to auto-restart the service.

export CFG_FILE="${SYNOPKG_PKGDEST}/etc/default/dump1090-fa"
export DUMP1090="${SYNOPKG_PKGDEST}/bin/dump1090-fa"

SVC_BACKGROUND=y
SVC_WRITE_PID=y

SERVICE_COMMAND="${SYNOPKG_PKGDEST}/bin/start.sh"
SVC_CWD="${SYNOPKG_PKGVAR}"

export PID_FILE=${PID_FILE}
export SERVICE_PORT=${SERVICE_PORT}

# These functions are for demonstration purpose of DSM sequence call
# and installation logging capabilities.
# Only provide useful ones for your own package, logging may be removed.

service_postinst ()
{
    # use echo to write to the installer log file.
    echo "service_postinst ${SYNOPKG_PKG_STATUS}"
    
    echo "Variables:"
    echo "SHARE_PATH=${SHARE_PATH}"
    echo "SHARE_NAME=${SHARE_NAME}"

    ln -sf ${INST_LOG} ${SYNOPKG_PKGVAR}/${SYNOPKG_PKGNAME}-installer.log
}
