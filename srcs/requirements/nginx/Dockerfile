FROM alpine:3.20

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=PT/ST=Porto/L=Porto/O=42/CN=$DOMAIN_NAME"

COPY conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
