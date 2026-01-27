FROM debian:trixie

RUN apt-get update && apt-get install -y \
    mariadb-client \
    cron \
    && apt-get clean

COPY tools/backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

CMD ["cron", "-f"]
