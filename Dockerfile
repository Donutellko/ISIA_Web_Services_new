FROM tomcat:9.0.8-jre8-alpine

ADD docker/*.war /usr/local/tomcat/webapps/
ADD target/*.war /usr/local/tomcat/webapps/
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
ADD docker/manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

ENV CATALINA_OPTS="$CATALINA_OPTS -agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n"

# otherwise picture generation throws NPE
RUN apk --update add fontconfig ttf-dejavu

EXPOSE 8080
EXPOSE 5005

