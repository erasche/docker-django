FROM nginx:1.12-alpine

ENV DEBIAN_FRONTEND noninteractive

RUN apk update && \
	apk add curl tar && \
	curl -L https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz > /dockerize-linux-amd64-v0.2.0.tar.gz && \
	tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz && \
	rm dockerize-linux-amd64-v0.2.0.tar.gz

# Add a default proxy conf
ADD ./proxy.conf /etc/nginx/conf.d/server.tmpl

ENV BACKEND_PORT=8000 \
	PATH_PREFFIX_STATIC=/app/static \
	PATH_PREFIX=/app

VOLUME ["/staticfiles"]

CMD ["dockerize", "-template", "/etc/nginx/conf.d/server.tmpl:/etc/nginx/conf.d/default.conf", "nginx", "-g", "daemon off;"]
