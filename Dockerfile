FROM tomcat:9.0.8-jre8-alpine

# LABEL maintainer=”deepak@softwareyoga.com”

# ADD ISIA_servicios_web.war /usr/local/tomcat/webapps/
ADD docker/*.war /usr/local/tomcat/webapps/
ADD target/*.war /usr/local/tomcat/webapps/
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
ADD docker/manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

ENV CATALINA_OPTS="$CATALINA_OPTS -agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n"
# -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005

RUN apk --update add fontconfig ttf-dejavu

EXPOSE 8080

# CMD [“bin/catalina.sh”, “run”]

