#!/bin/bash
sudo apt-get upgrade -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2

sudo echo "AddDefaultCharset UTF-8" >> /etc/apache2/conf-enabled/charset.conf

sudo echo "${nickname}" > /var/www/html/index.html

sudo systemctl restart apahce2