#!/bin/bash

CONTROL_PATH="$HOME/skriptai/creative/remote/controls"
LOADET_CONTROL=`less $CONTROL_PATH/../loadet_control`
NEXT_CONTROL=$LOADET_CONTROL
SET_NEXT_CONTROL=false
FIRST_CONTROL_SETTED=false
FIRST_CONTROL=""

for i in `ls -B --ignore *_desc $CONTROL_PATH/`
do
	if [ $FIRST_CONTROL_SETTED != true ]
		then
			FIRST_CONTROL="$i"
			FIRST_CONTROL_SETTED=true
	fi
	if [ $SET_NEXT_CONTROL = true -a "$NEXT_CONTROL" = "$LOADET_CONTROL" ]
		then
			NEXT_CONTROL=$i
	fi
	if [ "$LOADET_CONTROL" = "$i" ]
		then
			SET_NEXT_CONTROL=true
	fi
done

if [ "$NEXT_CONTROL" = "$LOADET_CONTROL" ]
	then
		NEXT_CONTROL=$FIRST_CONTROL
fi

TITLE="IR-Control"
DESC="IR-Control mode switched to use $NEXT_CONTROL"
DESCR_FILE=$CONTROL_PATH/$NEXT_CONTROL"_desc"

test -f $DESCR_FILE && source $DESCR_FILE

echo $NEXT_CONTROL
echo $NEXT_CONTROL > $CONTROL_PATH/../loadet_control
notify-send -t 2000 "$TITLE" "$DESC"

killall irexec
echo include $CONTROL_PATH"/../def_lircrc" > $CONTROL_PATH"/../lircrc"
echo include $CONTROL_PATH/$NEXT_CONTROL >> $CONTROL_PATH"/../lircrc"
irexec -d

