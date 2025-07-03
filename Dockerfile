# 🧱 Use official Eclipse Temurin OpenJDK 21 base
FROM eclipse-temurin:21-jdk

# 📦 Install wget and unzip
RUN apt-get update && apt-get install -y wget unzip

# 📁 Create a directory for Tomcat
RUN mkdir /opt/tomcat

# 🌐 Download Apache Tomcat 10 (you can switch to 9.0.80 if needed)
RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.20/bin/apache-tomcat-10.1.20.zip -O /tmp/tomcat.zip \
    && unzip /tmp/tomcat.zip -d /opt/tomcat \
    && mv /opt/tomcat/apache-tomcat-10.1.20 /opt/tomcat/latest \
    && rm /tmp/tomcat.zip

# 🧹 Clean default apps
RUN rm -rf /opt/tomcat/latest/webapps/*

# 🚀 Copy your WAR file into ROOT.war
COPY target/KiddyKart.war /opt/tomcat/latest/webapps/ROOT.war

# 🔥 Expose port 8080
EXPOSE 8080

# ✅ Start Tomcat
CMD ["/opt/tomcat/latest/bin/catalina.sh", "run"]
