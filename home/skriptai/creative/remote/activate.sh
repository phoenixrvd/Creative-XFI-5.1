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
		sudo -u my_user killall irexec & wait
		sudo -u my_user killall irxevent & wait
		sudo -u my_user notify-send "Garso serveris paleidžiamas iš naujo" 
		sudo -u my_user pulseaudio --kill 
		sudo -u my_user irexec -d
		sudo -u my_user irxevent -d;
fi
exit
