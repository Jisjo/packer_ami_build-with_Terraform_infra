#!/bin/bash

sudo yum install git httpd -y
sleep 5
sudo git clone https://github.com/Jisjo/sample_test_website.git
sudo cp -r sample*/* /var/www/html/
sudo chown apache. /var/www/html/ -R
sudo systemctl start httpd
sudo systemctl enable httpd
