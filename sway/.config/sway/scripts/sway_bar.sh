# Change this according to your device
################
# Variables
################


# Date and time
date_and_week=$(date "+%Y-%m-%d ")
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')


# Audio and multimedia
# audio_volume=$(amixer sget Master | awk '/%/ {gsub(/[\[\]]/,""); print $4}' ) 
audio_volume=$(pamixer --get-volume-human)
audio_is_muted=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-mute)


# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
# interface_easyname grabs the "old" interface name before systemd renamed it
interface_easyname=$(dmesg | grep $network | grep renamed | awk 'NF>1{print $NF}')
ping=$(ping -c 1 www.google.com | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)


# Others
loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Pontevedra?0&T&Q&format=1')



# Icon swap
if [ $battery_status = "discharging" ];
then
    battery_pluggedin=''
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]
then
   network_active="⛔"
else
   network_active="⇆"
fi

if [ $audio_volume = "0%" ]
then
    audio_active='🔇'
else
    audio_active='🔊'
fi

echo " $network_active $interface_easyname | cpu $loadavg_5min | $audio_active $audio_volume | $battery_pluggedin $battery_charge | $date_and_week 🕘 $current_time"

