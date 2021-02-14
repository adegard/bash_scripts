#!/bin/bash
# https://gist.github.com/nmoran/208b78a45f95f9a219fb4fb35b091cd2
# install acpi and zenity with PPM
# warn below value in discharging:
warn_on=20
#warn above value in charging:
warn_sup=95
# time interval to check:
INTERVAL=600      # in seconds
debug=0

while true; do
  sleep $INTERVAL
	discharging=`acpi | grep Discharging | wc -l` # will be 1 if discharging and 0 if chargin
	#echo $discharging

	if [ $discharging -eq 1 ]; then # if discharging, check percentage
		percentage_remaining=`acpi | grep -o [0-9]*% | sed s/%//g`
		echo "Remaining ${percentage_remaining}"
		if [ $percentage_remaining -lt $warn_on ]; then
			DISPLAY=:0  zenity --notification --text "Warning, battery is discharging and at ${percentage_remaining}%!"
		elif [ $debug -eq 1 ]; then
			DISPLAY=:0  zenity --notification --text "Battery is discharging, but at ${percentage_remaining}% so it's grand!"
		fi
	elif [ $discharging -eq 0 ]; then
		percentage_remaining=`acpi | grep -o [0-9]*% | sed s/%//g`
		echo "Remaining ${percentage_remaining}"
		if [ $percentage_remaining -gt $warn_sup ]; then
			DISPLAY=:0  zenity --notification --text "Unplug battery, at ${percentage_remaining}%!"
		fi
	fi
done