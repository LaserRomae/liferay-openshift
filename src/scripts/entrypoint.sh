#!/bin/sh

cd /opt/liferay/tomcat-9.0.10/bin

# changing the amount of RAM to be used for Java to 75% of available mem
memory=$( echo "($( free -m | grep '^Mem:' | tr -s ' ' | cut -d ' ' -f 2 ) / 1024 * 0.75 * 1024)/1; scale=0" | bc )
echo "setting tomcat to ${memory} mb"
sed -i "s#2560#${memory}#g" /opt/liferay/tomcat-9.0.10/bin/setenv.sh

echo "starting tomcat"
sh startup.sh

while [ true ]
do
  sleep 60
done
