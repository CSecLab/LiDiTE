CREATE DATABASE IF NOT EXISTS camunda;

GRANT ALL ON camunda.* to 'camunda'@'%' IDENTIFIED BY 'camunda';

FLUSH PRIVILEGES;
