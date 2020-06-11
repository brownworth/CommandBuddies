#!/bin/bash
# rh_setup.sh

# system proxy settings
# from http://www.donniehardin.com/donnieIO/?p=462
echo "http_proxy=http://proxy.uncg.edu:3128/" >> /etc/environment
echo "export http_proxy=http://proxy.uncg.edu:3128/" >> /etc/profile.d/http_proxy.sh
echo "setenv http_proxy http://proxy.uncg.edu:3128/" >> /etc/profile.d/http_proxy.csh
echo "proxy=http://proxy.uncg.edu:3128" >> /etc/yum.conf

# CAPS NAMES for variables in case of case sensitive queries
echo "HTTP_PROXY=http://proxy.uncg.edu:3128/" >> /etc/environment
echo "export HTTP_PROXY=http://proxy.uncg.edu:3128/" >> /etc/profile.d/http_proxy.sh
echo "setenv HTTP_PROXY http://proxy.uncg.edu:3128/" >> /etc/profile.d/http_proxy.csh

# wget proxy settings
# from: https://www.thegeekdiary.com/how-to-use-wget-to-download-file-via-proxy/
echo "http_proxy = http://proxy.uncg.edu:3128" >> ~/.wgetrc
echo "https_proxy = http://proxy.uncg.edu:3128" >> ~/.wgetrc
echo "ftp_proxy = http://proxy.uncg.edu:3128" >> ~/.wgetrc

echo "http_proxy = http://proxy.uncg.edu:3128" >> /etc/wgetrc
echo "https_proxy = http://proxy.uncg.edu:3128" >> /etc/wgetrc
echo "ftp_proxy = http://proxy.uncg.edu:3128" >> /etc/wgetrc

# git proxy settings
# from: https://gist.github.com/evantoli/f8c23a37eb3558ab8765
git config --global http.proxy http://proxy.uncg.edu:3128

curl --insecure --output /tmp/katello-ca-consumer-latest.noarch.rpm  https://plx-rhnsat.uncg.edu/pub/katello-ca-consumer-latest.noarch.rpm

yum localinstall -y /tmp/katello-ca-consumer-latest.noarch.rpm 

subscription-manager register --org="UNC_Greensboro" --activationkey="UNCG-RHEL7"
subscription-manager repos --enable=rhel-7-server-satellite-tools-6.4-rpms
subscription-manager repos --disable=rhel-7-server-rh-common-rpms

yum install -y katello-agent
rm -rf /var/cache/yum/*
yum clean all 
yum update -y
