#!/bin/bash
set -e

FTP_USER=ftpuser
FTP_PASSWORD=$(cat /run/secrets/ftp_password)

echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

chown -R ftpuser:ftpuser /var/www/html

exec "$@"
