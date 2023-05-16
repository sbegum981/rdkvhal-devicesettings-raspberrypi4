#!/bin/sh

if [[ "$1" == 2 ]]; then # This call is from rpidisplay.service
     QueryPowerState | grep 'STANDBY' &> /dev/null
     if [ $? == 0 ]; then
         export XDG_RUNTIME_DIR=/tmp
         for i in {1..20}    # At boot-up wait until Westeros module is up
             do
                 /usr/bin/westeros-gl-console get display enable | grep 'display enable 1' &> /dev/null
                 if [ $? == 0 ]; then
                     /usr/bin/westeros-gl-console set display enable 0
                     break
                 fi
                 sleep 1
         done
     fi

else     # This call is from RPI HAL Enable/Disable Videoport at Power state is set to ON/STANDBY
     export XDG_RUNTIME_DIR=/tmp
     /usr/bin/westeros-gl-console set display enable $1
fi
