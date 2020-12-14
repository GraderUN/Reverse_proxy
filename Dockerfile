FROM nginx
RUN apt-get update -qq && apt-get -y install apache2-utils
ENV API_GATEWAY_URL '18.234.2.64:30101'
ENV NODE_ROOT /var/www/api-gateway
WORKDIR $NODE_ROOT
RUN mkdir log
COPY app.conf /tmp/app.nginx
COPY development/server.crt /etc/ssl/certs/
COPY development/server.key /etc/ssl/certs/
RUN envsubst '\$NODE_ROOT \$API_GATEWAY_URL' < /tmp/app.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
