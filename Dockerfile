FROM alpine:latest

RUN apk update && apk add openjdk8
RUN wget "https://github.com/liferay/liferay-portal/releases/download/7.1.2-ga3/liferay-ce-portal-tomcat-7.1.2-ga3-20190107144105508.tar.gz"
RUN cd /opt && tar xvfz /liferay-ce-portal-tomcat-7.1.2-ga3-20190107144105508.tar.gz && mv liferay-portal-7.1.2-ga3 liferay && rm -rf /liferay-ce-portal-tomcat-7.1.2-ga3-20190107144105508.tar.gz

COPY /src/scripts/entrypoint.sh /opt/liferay/entrypoint.sh

RUN chgrp -R 0 /opt/liferay
RUN chmod -R g+rwX /opt/liferay
RUN find /opt/liferay -type d -exec chmod g+x {} +

WORKDIR /opt/liferay

USER 1001

EXPOSE 8080

ENTRYPOINT ["/bin/sh", "/opt/liferay/entrypoint.sh"]
