#!/bin/sh

cd /opt/liferay/tomcat-9.0.17/bin

# changing the amount of RAM to be used for Java to 75% of available mem
memory=$( echo "($( free -m | grep '^Mem:' | tr -s ' ' | cut -d ' ' -f 2 ) / 1024 * 0.75 * 1024)/1; scale=0" | bc )
echo "setting tomcat to ${memory} mb"

cat <<EOF > /opt/liferay/tomcat-9.0.17/bin/setenv.sh
CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -Xms${memory}m -Xmx${memory}m -XX:MaxNewSize=1536m -XX:MaxMetaspaceSize=384m -XX:MetaspaceSize=384m -XX:NewSize=1536m -XX:SurvivorRatio=7 -XX:MaxPermSize=2048m"
JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk"
EOF

cat <<EOF > /opt/liferay/osgi/configs/com.liferay.portal.search.elasticsearch6.configuration.ElasticsearchConfiguration.cfg
operationMode="REMOTE"
transportAdresses="liferay-es.processo-standard-ril.svc.cluster.local:9300"
logExceptionsOnly="false"
clusterName="LiferayElasticsearchCluster"
EOF


echo "starting tomcat"
sh startup.sh

while [ true ]
do
  sleep 60
done
