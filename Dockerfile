FROM amazoncorretto:11
# Install Maven
RUN yum install -y maven && \
    yum install -y wget && \
    yum install -y tar && \
    yum install -y gzip

# Create app directory
WORKDIR /app
# Copy pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy app source code and build WAR file
COPY src/ ./src/
RUN mvn package -DskipTests

# Install Tomcat
RUN mkdir /opt/tomcat
RUN wget -O /tmp/tomcat.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz
RUN cd /tmp && tar -xvzf tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.91/* /opt/tomcat/
# Copy WAR file
RUN cp target/*.war /opt/tomcat/webapps/
#COPY --from=0 /app/target/*.war /opt/tomcat/webapps/
# Copy Tomcat config files
# COPY conf/tomcat-users.xml /opt/tomcat/conf/
# COPY conf/context.xml /opt/tomcat/webapps/manager/META-INF/
# COPY conf/context.xml /opt/tomcat/webapps/host-manager/META-INF/

# Expose port 8080
EXPOSE 8080
