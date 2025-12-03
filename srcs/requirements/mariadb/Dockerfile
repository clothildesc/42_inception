FROM debian:buster

RUN apt update && apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

CMD ["mysqld"]

