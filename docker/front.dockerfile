FROM node:16.16 as build

WORKDIR /home/node

COPY config/entrypoint.front.sh /entrypoint.sh

COPY nginx.conf ./
RUN ls /home/node
RUN pwd
ADD ../frontend/*  ./

RUN ls /home/node

#
# Package stage
#
# production environment
FROM ghcr.io/shclub/nginx:stable-alpine

ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY --from=build /home/node/* /usr/share/nginx/html
COPY --from=build /home/node/nginx.conf /etc/nginx/conf.d/default.conf

ENV BACKEND_API_URL backend
RUN sed -i "s|backend_host|$BACKEND_API_URL|g" -i /etc/nginx/conf.d/default.conf
RUN cat /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
