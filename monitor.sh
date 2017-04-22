#!/bin/bash

INI_TEMP=62
MAX_TEMP=82

MIN_RPM=2100
MAX_RPM=5000
SAV_RPM=5880


# get current temperature
cd /sys/devices/platform/applesmc.768
CUR_TEMP="$( sensors | grep TPCD | grep -o '[0-9]*' | head -n1 )"
echo "${CUR_TEMP}"


CUR_RPM=$MIN_RPM
#CUR_TEMP=67


if [ $CUR_TEMP -gt $INI_TEMP ]

then
    echo "Oi"

    TMP="$(expr $CUR_TEMP * $MAX_RPM)"    
    
    CUR_RPM="$( expr $TMP / $MAX_RPM )"  
  
    echo "${CUR_RPM}"
fi
echo "Tchau"


# todo
# if the current temperature is above 90% of the safe limit defined, activate hardware saving mode
# will set the rpm to 5850 rpm and play some alarm
