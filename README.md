# MacBookPro FanControl Shell

If you use linux in your macbook, you may notice that it gets quite hot, while keeping the fan speed low, to handle this issue i've develop this very simple shell utility that will read the higher temperature of your sensors (TCPD) and controll the fan speed accordingly.

It's a simple shell, with static system paths, so please modify as you need, on monitor.sh you' ll find:

## Variables

    # initial temperature, which this script will start to act
    INI_TEMP=59

    # minimum fan speed your system will operate
    MAX_TEMP=89

    # minimum fan speed your system will operate
    MIN_RPM=2100

    # maximum fan speed your system should operate
    MAX_RPM=5000

    # not in use currently
    SAV_RPM=5880


## Sensors
The script uses the *sensors* command to grep the current higher temperature, so you must have this command available in your system, *sensors* should give you an output similar to this one:


    applesmc-isa-0300
    Adapter: ISA adapter
    Exhaust  :   3536 RPM  (min = 3539 RPM, max = 6200 RPM)
    TA0P:         +42.8°C
    TB0T:         +36.8°C
    TB1T:         +36.8°C
    TB2T:         +35.2°C
    TC0E:         +56.2°C
    TC0F:         +58.0°C
    TC0J:          +1.8°C
    TC0P:         +50.2°C
    TC1C:         +55.0°C
    TC2C:         +55.0°C
    TCGC:         +54.0°C
    TCSA:         +55.0°C
    TCTD:          -0.2°C
    TCXC:         +55.5°C
    TG1D:         +58.0°C
    TM0P:         +40.5°C
    TM0S:         +48.0°C
    TPCD:         +63.0°C
    Th1H:         +44.5°C
    Ts0P:         +32.2°C
    Ts0S:         +39.5°C

    coretemp-isa-0000
    Adapter: ISA adapter
    Package id 0:  +59.0°C  (high = +87.0°C, crit = +105.0°C)
    Core 0:        +57.0°C  (high = +87.0°C, crit = +105.0°C)
    Core 1:        +59.0°C  (high = +87.0°C, crit = +105.0°C)

    BAT0-virtual-0
    Adapter: Virtual device
    temp1:        +37.1°C


With this outupt you'll be able to identify the sensor with the higher temperature, which will probably be th CPU / GPU, in my case this sensor was the *TCPD* which is used in the *grep* command.


## Fan system file
Also, the system file which controls the fan speed may change depending of you hardware, for me it is:

    /sys/devices/platform/applesmc.768/fan1_min

If you *cat* this file, you'll see it has only one number, which is the fan RPM.


## Crontab setup

The final step it's to add a crontab entry, to execute this script every minute, and by doing so, keep the fan speed updated according with your usage, this entry has to be added in your super user account, so that you have rights to change the contens of your fan speed file.

Login with your super user and type `crontab -e`

Insert this line changing the path to your *monitor.sh*

    *  *  *  *  *  sh /home/gritt/Projects/mbp-fancontrol/monitor.sh

You can monitor how your fan speed changes by watching the sensors command: `watch sensors`

And your done! 

## Warning!

Please procceed with caution, you don't wanna set your fan speed to zero and damage your computer, so, test this script in an empty file, read, modify, and undestand the contents before executing it.