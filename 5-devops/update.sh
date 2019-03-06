#!/bin/bash

git pull
cd 4-web/01-webapp/
mvn clean package
sudo rm -rf /usr/share/tomcat8/webapps/01-simplewebapp-0.1.0*
sudo cp target/*.war /usr/share/tomcat8/webapps
sudo service tomcat8 restart

