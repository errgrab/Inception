#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout ssl.key -out ssl.crt \
	-subj "/C=PT/ST=Porto/L=Porto/O=42School/CN=ecarvalh.42.fr"
