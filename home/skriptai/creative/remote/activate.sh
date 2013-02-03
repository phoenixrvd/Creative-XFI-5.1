#! /bin/bash

#exit

# Informacija apie garso kortą: udevadm info -a -p $(udevadm info -q path -n /dev/snd/hwC1D0)
# udevadm info -a -p $(udevadm info -q path -n /dev/snd/hwC1D0)

export DISPLAY=:0.0
sudo -u phoenixrvd notify-send "Prijungta USB Creative SB X-FI 5.1 garso sistema " 

if sudo -u phoenixrvd pacmd list-cards | grep -q output:analog-surround-51+input:analog-stereo;
	then 
		echo; 
	else 	
		sudo -u phoenixrvd killall irexec & wait
		sudo -u phoenixrvd killall irxevent & wait
		sudo -u phoenixrvd notify-send "Garso serveris paleidžiamas iš naujo" 
		sudo -u phoenixrvd pulseaudio --kill 
		sudo -u phoenixrvd irexec -d
		sudo -u phoenixrvd irxevent -d;
fi
exit