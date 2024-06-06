FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=urgentNews

COPY news.sql /docker-entrypoint-initdb.d/

EXPOSE 3306