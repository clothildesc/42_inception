CREATE DATABASE IF NOT EXISTS inception_db ;
CREATE USER IF NOT EXISTS 'inception_user'@'%' IDENTIFIED BY 'inception_password';
GRANT ALL PRIVILEGES ON inception_db.* TO 'inception_user'@'%';
FLUSH PRIVILEGES;

