#export LANG=ru_RU.UTF-8
#export LC_CTYPE=ru_RU.UTF-8
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
xrdb ~/.Xresources
setxkbmap -layout "us,ru" -option "grp:alt_shift_toggle"
awesome
