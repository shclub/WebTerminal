FROM node:16.16

WORKDIR /home/node

COPY /server/*  ./
COPY entrypoint.server.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 80
