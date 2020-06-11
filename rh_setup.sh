#!/bin/bash
# setup.sh

echo "http_proxy=http://proxy.uncg.edu:3128/" >> /etc/environment
echo "export http_proxy=http://proxy.uncg.edu:3128/" >> /etc/profile.d/http_proxy.sh
echo "setenv http_proxy http://proxy.uncg.edu:3128/" >> /etc/profile.d/http_proxy.csh
echo "proxy=http://proxy.uncg.edu:3128" >> /etc/yum.conf

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
