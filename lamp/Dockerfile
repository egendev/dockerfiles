FROM debian:jessie

MAINTAINER Frantisek Masa <masa@egen.cz>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Install base tools
RUN apt-get install curl git -y

# Add repository with nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get update

# Install MySQL
RUN apt-get install mysql-server -y

RUN service mysql start && mysql -u root -e "FLUSH PRIVILEGES; SET PASSWORD FOR 'root'@'localhost' = PASSWORD('')"

# Install PHP (5.6)
RUN apt-get install php5 php5-cli php5-mysql php5-sqlite php5-gd php-pear php-apc php5-curl -y

# Install XDebug
# RUN apt-get install php5-xdebug -y # (disabled)

COPY php.ini /etc/php5/apache2/

# Install apache
RUN apt-get install apache2  libapache2-mod-php5 -y

RUN a2enmod php5
RUN a2enmod rewrite

RUN usermod -u 1000 www-data # Now www-data (Apache) is owner of app files

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install node.js
RUN apt-get -y install nodejs

# Install gulp
RUN npm install -g gulp

# Install bower
RUN npm install -g bower

WORKDIR /var/www/html

ADD vhosts.conf /etc/apache2/sites-enabled/000-default.conf

ADD run.sh /run.sh

RUN chmod 755 /*.sh

VOLUME  ["/etc/mysql", "/var/lib/mysql"]

EXPOSE 80 9000
CMD ["/run.sh"]
