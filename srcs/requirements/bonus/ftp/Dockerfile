FROM debian:trixie

RUN apt-get update && apt-get install -y \
    vsftpd \
    && apt-get clean

RUN useradd -m ftpuser
RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp-setup.sh /usr/local/bin/ftp-setup.sh
RUN chmod +x /usr/local/bin/ftp-setup.sh

ENTRYPOINT ["ftp-setup.sh"]

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd.conf"]
