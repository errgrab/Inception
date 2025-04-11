FROM alpine:3.20
RUN apk update && apk add nginx openssl
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/ssl.crt /etc/ssl/certs/
COPY ./tools/ssl.key /etc/ssl/private/
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
