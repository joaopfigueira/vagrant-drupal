#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo "Creating swap file"
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
chmod 600 /var/swap.1
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1
echo '/var/swap.1 none swap sw 0 0' >> /etc/fstab

echo "Installing Curl, Git"
apt-get -qq update && apt-get -qq -y install curl unzip git apt-transport-https ca-certificates

## Apache
apt-get -qq -y install apache2
a2enmod rewrite
cp /vagrant/vagrant-provision/000-default.conf /etc/apache2/sites-available/000-default.conf

## PHP
PHP_VERSION=7.2
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
apt-get -qq update && apt-get -qq -y install php$PHP_VERSION
apt-get -qq -y install php$PHP_VERSION-mysql \
    php$PHP_VERSION-xml \
    php$PHP_VERSION-gd \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-mbstring \
    php$PHP_VERSION-zip

## mysql
echo "Installing MySQL"
DB_NAME=drupal
DB_USER=drupal
DB_PASSWD=drupal
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DB_PASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DB_PASSWD"
apt-get -qq -y install mysql-server
apt-get -qq -y install mysql-client php-mysql

echo "Creating Database"
mysql -uroot -p$DB_PASSWD -e "CREATE DATABASE $DB_NAME"
mysql -uroot -p$DB_PASSWD -e "grant all privileges on $DB_NAME.* to '$DB_USER'@'localhost' identified by '$DB_PASSWD'"

## Phpunit
echo "Installing PHPUnit"
PHPUNIT_VERSION=6
wget -q https://phar.phpunit.de/phpunit-$PHPUNIT_VERSION.phar
chmod +x phpunit-$PHPUNIT_VERSION.phar
mv phpunit-$PHPUNIT_VERSION.phar /usr/local/bin/phpunit

## Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

## Drush
wget -qO drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush

## Copy setup file to homefolder and run it on first login
cp -f /vagrant/vagrant-provision/setup.sh /home/vagrant/setup.sh
cp -f /vagrant/vagrant-provision/profile /etc/profile

echo "Server ready, $ vagrant up"
