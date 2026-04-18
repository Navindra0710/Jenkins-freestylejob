
Note: For TOMCAT setup automation script having some issues.

# Install Java
sudo yum install -y java

# Download Tomcat
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.117/bin/apache-tomcat-9.0.117.tar.gz

# Extract
sudo tar -xvf apache-tomcat-9.0.117.tar.gz

# Configure manager access
cd /opt/apache-tomcat-9.0.117/webapps/manager/META-INF || exit
sudo sed -i 's|<Valve className="org.apache.catalina.valves.RemoteAddrValve".*|<!-- Allow all IPs -->|g' context.xml

# Configure users
cd /opt/apache-tomcat-9.0.117/conf || exit
sudo mv tomcat-users.xml tomcat-users_bkp.xml

echo '<?xml version="1.0" encoding="utf-8"?>
<tomcat-users>
    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <role rolename="manager-status"/>
    <user username="tomcat" password="tomcat" roles="manager-gui,manager-script,manager-status"/>
</tomcat-users>' | sudo tee tomcat-users.xml > /dev/null

# Change port
sudo sed -i 's/port="8080"/port="8081"/g' server.xml

# Start Tomcat
sudo /opt/apache-tomcat-9.0.117/bin/startup.sh
