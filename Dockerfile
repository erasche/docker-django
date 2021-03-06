FROM python:2.7-alpine

# Update the default application repository sources list
RUN apk update && \
	apk add postgresql-dev gcc python-dev musl-dev bash postgresql-client git nginx && \
	pip install psycopg2 gunicorn raven

WORKDIR /app
RUN addgroup -S django && \
	adduser -S -G django django && \
	mkdir /docker

ADD create_admin.py postgres_ready.py docker-entrypoint.sh /docker/

ENV DJANGO_WSGI_MODULE=base.wsgi \
	DJANGO_SETTINGS_MODULE=base.production \
	ALLOWED_HOSTS="*" \
	CORS_ORIGINS="localhost:10000"
RUN mkdir -p /docker/docker-entrypoint.d/

ADD nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
ENTRYPOINT ["/docker/docker-entrypoint.sh"]
