FROM node:16.16

WORKDIR /home/node

COPY entrypoint.server.sh /entrypoint.sh

# COPY nginx.conf ./
COPY /server/*  ./

ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80
