#!/bin/bash

INI_TEMP=59
MAX_TEMP=89

MIN_RPM=2100
MAX_RPM=5000
SAV_RPM=5880


# read current temperature
cd /sys/devices/platform/applesmc.768
CUR_TEMP="$( sensors | grep TPCD | grep -o '[0-9]*' | head -n1 )"


echo "Current temperature ${CUR_TEMP} deegres"


CUR_RPM=$MIN_RPM


if [ $CUR_TEMP -gt $INI_TEMP ] 
then

    echo "Temperature is above recommended"

    TMP=$((CUR_TEMP * MAX_RPM))
    
    CUR_RPM=$((TMP / MAX_TEMP))

    # run at minimum speed at least
    if [ $MIN_RPM -gt $CUR_RPM ]
    then
        $CUR_RPM=$MIN_RPM
    fi
fi

echo "Adjusting fan speed to ${CUR_RPM} RPMs"

echo $CUR_RPM > /sys/devices/platform/applesmc.768/fan1_min

echo "Done!"
