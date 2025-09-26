#!/bin/sh

set -e
set -x

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

	mkdir -p /var/www/html

	cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
	cp /etc/vsftpd.conf.new /etc/vsftpd.conf

	# Add the FTP_USER, change his password and declare him as the owner of wordpress folder and all subfolders
	adduser "$FTP_USER" --disabled-password
	echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd
	chown -R "$FTP_USER:$FTP_USER" /var/www/html

	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist
fi

exec "$@"