# Debian LAMP stack with Apache, MariaDB, PHP,
FROM debian:9
LABEL maintainer="ishtiaq.ciit@hotmail.com"
#Setting Users in Docker
RUN echo "newpassword\nnewpassword" |passwd root 
RUN useradd -ms /bin/bash -G sudo user1
RUN echo "password\npassword" | passwd user1
ENV DEBIAN_FRONTEND noninteractive    
#Installing Necessary Packages for LAMP
 
RUN apt-get install --fix-missing
RUN apt-get update && apt-get upgrade -y && apt-get -y  install software-properties-common curl wget vim sudo apt-utils iputils-ping net-tools whois supervisor

#Installation of  Apache2, PHP & Mysql through a bash Script
ADD ./setup.sh /setup.sh
RUN chmod +x /setup.sh
RUN /setup.sh
RUN echo '<?php phpinfo(); ?>' > /var/www/html/index.php

ADD supervisord.conf /etc/supervisord.conf
EXPOSE 80 3306
VOLUME /var/www/html /var/log/apache2
CMD ["/usr/bin/supervisord"]
