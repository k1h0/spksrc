#!/bin/sh

# we need a single file to start the service and create the pid-file
# the combination of 
# - SVC_BACKGROUND=y
# - SVC_WRITE_PID=y
# does not work in DSM 5 when SERVICE_COMMAND is a commend with parameters
# On DSM 5 /bin/sh is ash and not bash and '/bin/sh -c "command parameter" &' will create a new process for "command parameter"
# finally we have two processes in the background, but are not able to retrieve the PID of "command parameter"
# 

if [ -f "${CFG_FILE}" ]
then
    . "${CFG_FILE}"
else
    echo "Config file ${CFG_FILE} does not exist"
fi

#if [ -f /var/cache/piaware/location.env ]
#then
#    . /var/cache/piaware/location.env
#fi

if [ "$ENABLED" != "yes" ]
then
    echo "dump1090-fa not enabled in ${CFG_FILE}" >&2
    exit 1
fi

# process options

# if there's no CONFIG_STYLE, infer a version
if [ -z "$CONFIG_STYLE" ]
then
   if [ -n "$RECEIVER_OPTIONS" -o -n "$DECODER_OPTIONS" -o -n "$NET_OPTIONS" -o -n "$JSON_OPTIONS" ]
   then
       CONFIG_STYLE=5
   else
       CONFIG_STYLE=6
   fi
fi

is_slow_cpu() {
    case "$SLOW_CPU" in
        yes) return 0 ;;
        auto)
            case $(uname -m) in
                armv6*) return 0 ;;
                *) return 1 ;;
            esac
            ;;
        *) return 1 ;;
    esac
}

if [ "$CONFIG_STYLE" = "5" ]
then
    # old style config file
    echo "/etc/default/dump1090-fa is using the old config style, please consider updating it" >&2
    OPTS="$RECEIVER_OPTIONS $DECODER_OPTIONS $NET_OPTIONS $JSON_OPTIONS"
elif [ -n "$OVERRIDE_OPTIONS" ]
then
    # ignore all other settings, use only provided options
    OPTS="$OVERRIDE_OPTIONS"
else
    # build a list of options based on config settings    
    OPTS=""

    if [ "${RECEIVER:-none}" = "none" ]
    then
        OPTS="$OPTS --device-type none"
    else
        if [ -n "$RECEIVER" ]; then OPTS="$OPTS --device-type $RECEIVER"; fi
        if [ -n "$RECEIVER_SERIAL" ]; then OPTS="$OPTS --device-index $RECEIVER_SERIAL"; fi
        if [ -n "$RECEIVER_GAIN" ]; then OPTS="$OPTS --gain $RECEIVER_GAIN"; fi
        if [ -n "$WISDOM" -a -f "$WISDOM" ]; then OPTS="$OPTS --wisdom $WISDOM"; fi

        if [ "$ADAPTIVE_DYNAMIC_RANGE" = "yes" ]; then OPTS="$OPTS --adaptive-range"; fi
        if [ -n "$ADAPTIVE_DYNAMIC_RANGE_TARGET" ]; then OPTS="$OPTS --adaptive-range-target $ADAPTIVE_DYNAMIC_RANGE_TARGET"; fi
        if [ "$ADAPTIVE_BURST" = "yes" ]; then OPTS="$OPTS --adaptive-burst"; fi
        if [ -n "$ADAPTIVE_MIN_GAIN" ]; then OPTS="$OPTS --adaptive-min-gain $ADAPTIVE_MIN_GAIN"; fi
        if [ -n "$ADAPTIVE_MAX_GAIN" ]; then OPTS="$OPTS --adaptive-max-gain $ADAPTIVE_MAX_GAIN"; fi

        if is_slow_cpu
        then
            OPTS="$OPTS --adaptive-duty-cycle 10 --no-fix-df"
        fi
    fi

    if [ "$ERROR_CORRECTION" = "yes" ]; then OPTS="$OPTS --fix"; fi

    if [ -n "$RECEIVER_LAT" -a -n "$RECEIVER_LON" ]; then
        OPTS="$OPTS --lat $RECEIVER_LAT --lon $RECEIVER_LON"
    elif  [ -n "$PIAWARE_LAT" -a -n "$PIAWARE_LON" ]; then
        OPTS="$OPTS --lat $PIAWARE_LAT --lon $PIAWARE_LON"
    fi

    if [ -n "$MAX_RANGE" ]; then OPTS="$OPTS --max-range $MAX_RANGE"; fi

    if [ -n "$NET_RAW_INPUT_PORTS" ]; then OPTS="$OPTS --net-ri-port $NET_RAW_INPUT_PORTS"; fi
    if [ -n "$NET_RAW_OUTPUT_PORTS" ]; then OPTS="$OPTS --net-ro-port $NET_RAW_OUTPUT_PORTS"; fi
    if [ -n "$NET_SBS_OUTPUT_PORTS" ]; then OPTS="$OPTS --net-sbs-port $NET_SBS_OUTPUT_PORTS"; fi
    if [ -n "$NET_BEAST_INPUT_PORTS" ]; then OPTS="$OPTS --net-bi-port $NET_BEAST_INPUT_PORTS"; fi
    if [ -n "$NET_BEAST_OUTPUT_PORTS" ]; then OPTS="$OPTS --net-bo-port $NET_BEAST_OUTPUT_PORTS"; fi

    if [ -n "$JSON_LOCATION_ACCURACY" ]; then OPTS="$OPTS --json-location-accuracy $JSON_LOCATION_ACCURACY"; fi

    if [ -n "$EXTRA_OPTIONS" ]; then OPTS="$OPTS $EXTRA_OPTIONS"; fi
fi

#exec /usr/bin/dump1090-fa --quiet $OPTS "$@"
# exec failed, do not restart
#exit 64

while :
do
    # start dump1090 executable and get the new process id
    exec ${DUMP1090} --quiet ${OPTS} "$@" &
    process_id=$!

    # wait for dump1090 executable to exit
    wait $process_id
    exit_status=$?

    # wait for 30 seconds before entering the next loop
    sleep 30
done
echo "${DUMP1090} exit status: $exit_status"
exit $exit_status
