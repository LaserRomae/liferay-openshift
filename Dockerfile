FROM centos:7

RUN yum -y install java-1.8.0-openjdk bc net-tools && yum -y clean all
RUN curl -kLv -O "https://github.com/liferay/liferay-portal/releases/download/7.1.3-ga4/liferay-ce-portal-tomcat-7.1.3-ga4-20190508171117552.tar.gz"
RUN cd /opt && tar xvfz /liferay-ce-portal-tomcat-7.1.3-ga4-20190508171117552.tar.gz && mv liferay-portal-7.1.3-ga4 liferay && rm -rf /liferay-ce-portal-tomcat-7.1.3-ga4-20190508171117552.tar.gz

COPY /src/scripts/entrypoint.sh /opt/liferay/entrypoint.sh

RUN chgrp -R 0 /opt/liferay
RUN chmod -R g+rwX /opt/liferay
RUN find /opt/liferay -type d -exec chmod g+x {} +

WORKDIR /opt/liferay

USER 1001

EXPOSE 8080

ENTRYPOINT ["/bin/sh", "/opt/liferay/entrypoint.sh"]
