#!/bin/sh


print_osd () {
	echo "text_widgets_updatetext(\"volume\", \"$1\")"|awesome-client
}

osd_vol () {
	if [ q`uname` == q"Linux" ]; then
		cur=`amixer sget Master | grep -Eo '[0-9]+%' | tr -d '%'`
	else
		cur=`mixer vol|awk '{print $7}'|sed 's/:.*//'`;
	fi
	print_osd "$cur";
}

change () {
	if [ $1 -gt 0 ]; then
		s="+"
		v=$1
	elif [ $1 -lt 0 ]; then
		s="-"
		v=`expr 0 - $1`
	else
		s=""
		v=$1
	fi

	if [ q`uname` == q"Linux" ]; then
		amixer set Master $v"%"$s
	else
		mixer vol $s$v;
	fi
}

cur=0
osd_vol;

case "$1" in
mute)
	if [ "$cur" = "0" ]; then
		change `cat ~/.thinkpad/volume.txt`;
		osd_vol;
	else
		echo $cur > ~/.thinkpad/volume.txt
		change 0
		print_osd "MT";
	fi;;
osd)
	osd_vol;;
volup)
	change 5
	osd_vol;;
voldown)
	change -5
	osd_vol;;
*)
	echo "Unknown param";;
esac
