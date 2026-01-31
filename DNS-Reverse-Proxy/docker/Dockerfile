FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY proxy.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/cache/nginx \
    && chmod -R 777 /var/cache/nginx

EXPOSE 80
