#export LANG=ru_RU.UTF-8
#export LC_CTYPE=ru_RU.UTF-8
setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle,grp_led:scroll"
xrdb ~/.Xresources
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
awesome
