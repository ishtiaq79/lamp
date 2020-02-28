#!/bin/bash

###################################################################
#         Author: Ishtiaq Ahmed
#         Link: ishtiaq.ciit@hotmail.com
#    	  Description: Installs an LAMP STACK. For Debian based systems.
#         Note: This script is written to use in Docker File  
###################################################################

# Color Reset
Color_Off='\033[0m'       # Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# GENERATE PASSOWRDS
#	sudo apt-get -qy install openssl # openssl used for generating a truly random password
	PASS_MYSQL_ROOT=`openssl rand -base64 12` # this you need to save 
# Update system repos
	echo -e "\n ${Cyan} Updating package repositories.. ${Color_Off}"
	apt-get -qq update 

# Apache
        echo -e "\n ${Cyan} Installing Apache.. ${Color_Off}"
	apt-get -qy install apache2 #apache2-doc 
	# check Apache configuration: apachectl configtest

# PHP and Modules
	echo -e "\n ${Cyan} Installing PHP and common Modules.. ${Color_Off}"
	 apt-get -qy install php php-common libapache2-mod-php php-curl php-dev php-gd php-gettext php-imagick php-intl php-mbstring php-mysql php-pear php-pspell php-recode php-xml php-zip
# MySQL/MariaDB
	
	echo -e "\n ${Cyan} Installing MySQL.. ${Color_Off}"
        apt-get -qy install mysql-server mysql-client
	#service mysql start &
	#sleep 10
	#echo 'mariadb-server mariadb-server/root_password  password ${PASS_MYSQL_ROOT}' | debconf-set-selections
	#echo 'mariadb-server mariadb-server/root_password_again password ${PASS_MYSQL_PASS}' | debconf-set-selections
	#sleep 3	
#debconf-set-selections <<< "mysql-server mysql-server/root_password password ${PASS_MYSQL_ROOT}"          		# new password for the MySQL root user
	#debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${PASS_MYSQL_ROOT}" 		# repeat password for the MySQL root user
# secure MySQL install
#	echo -e "\n ${Cyan} Securing MySQL.. ${Color_Off}"
#	mysql --user=root --password=${PASS_MYSQL_ROOT} << EOFMYSQLSECURE
#DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#DELETE FROM mysql.user WHERE User='';
#DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
#FLUSH PRIVILEGES;
#EOFMYSQLSECURE

# Enable mod_rewrite, 
	echo -e "\n ${Cyan} Enabling Modules.. ${Color_Off}"
	sudo a2enmod rewrite

# Permissions
	echo -e "\n ${Cyan} Setting Ownership for /var/www.. ${Color_Off}"
	sudo chown -R www-data:www-data /var/www

echo -e "\n${Green} SUCCESS! MySQL password is: ${PASS_MYSQL_ROOT} ${Color_Off}"
