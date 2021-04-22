#!/bin/bash
cd /home/devportal
git pull https://github.com/manel81/webcontent 
date >> /tmp/date.txt
/usr/sbin/sshd 

