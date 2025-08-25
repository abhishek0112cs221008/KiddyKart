<<<<<<< HEAD
# Use official Tomcat with Java support
FROM tomcat:9.0-jdk21

# Clean default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat's webapps folder
COPY KiddyKart.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
=======
# Use official Tomcat with Java support
FROM tomcat:9.0-jdk21

# Clean default webapps (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat's webapps folder
COPY KiddyKart.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
>>>>>>> 7b9624a1060791e2afa1cd9a789ecd481afb6739
