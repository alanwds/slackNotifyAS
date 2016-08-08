#!/bin/sh

NAME=slacknotify
DESC="slacknotify"
FULLDESC="Service to notify slack about machine status (starting or stoping)"

#Define levels to chkconfig
# chkconfig: 2345 99 05
# description: service to notify slack

#DEFINE VARIABLES
#slack web hook
slackHook="OUR_SLACK_WEB_HOOK";

#lockfile
lockFile="/var/lock/subsys/slacknotify";

#Get hostname
hostName=$(hostname)

#Get IP
ip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')

set -e
#Faz o conforme a acao a ser executada
case "$1" in
start)
echo -n "Starting ${DESC}: "

#Does not start if lockfile already exists
if [ -f "$lockFile" ]
then
        echo "Service already start";
else

#Coleta a data
date=$(date +"%F %T");

#Faz o curl, postando a mensagem no webhook
/usr/bin/curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$date - :arrow_up::arrow_up: - Scaling UP - $hostName ($ip)\", \"icon_emoji\": \":arrow_up:\"}" $slackHook

touch $lockFile
echo "$NAME."
fi
;;
stop)
echo -n "Stopping $DESC: "
date=$(date +"%F %T");

#Faz o curl, postando a mensagem no webhook
/usr/bin/curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$date - :arrow_down::arrow_down: - Scaling DOWN - $hostName ($ip)\", \"icon_emoji\": \":arrow_down:\"}" $slackHook
echo "$NAME."
rm -f $lockFile
;;
*)
N=/etc/init.d/$NAME
echo "Usage: $N {start|stop}" >&2
exit 1
