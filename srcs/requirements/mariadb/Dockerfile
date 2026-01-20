FROM debian:trixie

RUN apt update && apt install -y mariadb-server gettext-base

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init.sql /docker-entrypoint-initdb.d/

RUN mkdir -p /var/run/mysqld /var/lib/mysql \
		&& chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
USER mysql
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 3306
