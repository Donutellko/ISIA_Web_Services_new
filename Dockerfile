FROM tomcat:9.0.8-jre8-alpine

# Add here any .war file you want to deploy (for example, .war file from the CV)
ADD docker/*.war /usr/local/tomcat/webapps/
# You need to build the project using Maven
ADD target/*.war /usr/local/tomcat/webapps/
# To access Tomcat Manager console, see the credentials in this file
ADD docker/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
# Enabling access to Tomcat Manager console from outside of the container:
ADD docker/manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
ADD docker/manager-context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

# You can use Java Remote Debug on port 5005:
ENV CATALINA_OPTS="$CATALINA_OPTS -agentlib:jdwp=transport=dt_socket,address=5005,server=y,suspend=n"

# Install fonts, because otherwise picture generation throws NPE
RUN apk --update add fontconfig ttf-dejavu

EXPOSE 8080
EXPOSE 5005

