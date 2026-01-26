FROM debian:trixie

RUN apt-get update && apt-get install -y \
    vsftpd \
    && apt-get clean

RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd.conf"]
