#!/bin/bash

###################################################################
#         Author: Ishtiaq Ahmed
#         Link: ishtiaq.ciit@hotmail.com
#    	  Description: Installs an LAMP STACK. For Debian based systems.
#         Note: This script is written to use in Docker File  
###################################################################
# GENERATE PASSOWRDS
#	sudo apt-get -qy install openssl # openssl used for generating a truly random password
	PASS_MYSQL_ROOT=`openssl rand -base64 12` # this you need to save 
# Update system repos
	apt-get -qq update 
# Apache
	apt-get -qy install apache2 #apache2-doc 
	# check Apache configuration: apachectl configtest
# PHP and Modules
	 apt-get -qy install php php-common libapache2-mod-php php-curl php-dev php-gd php-gettext php-imagick php-intl php-mbstring php-mysql php-pear php-pspell php-recode php-xml php-zip
# MySQL/MariaDB
        apt-get -qy install mysql-server mysql-client
	#service mysql start &
	#sleep 10
	#echo 'mariadb-server mariadb-server/root_password  password ${PASS_MYSQL_ROOT}' | debconf-set-selections
	#echo 'mariadb-server mariadb-server/root_password_again password ${PASS_MYSQL_PASS}' | debconf-set-selections
	#sleep 3	
#debconf-set-selections <<< "mysql-server mysql-server/root_password password ${PASS_MYSQL_ROOT}"          		# new password for the MySQL root user
	#debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${PASS_MYSQL_ROOT}" 		# repeat password for the MySQL root user
# secure MySQL install
#	mysql --user=root --password=${PASS_MYSQL_ROOT} << EOFMYSQLSECURE
#DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#DELETE FROM mysql.user WHERE User='';
#DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
#FLUSH PRIVILEGES;
#EOFMYSQLSECURE

# Enable mod_rewrite, 
	sudo a2enmod rewrite
# Permissions
	sudo chown -R www-data:www-data /var/www
