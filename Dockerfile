# Use official Tomcat 9 image from Docker Hub
FROM tomcat:9.0

# Remove all existing apps in Tomcat's webapps folder
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the ROOT of the webapps directory
COPY leaveapp.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Render uses this by default)
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
