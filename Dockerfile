FROM python:2.7-alpine

# Update the default application repository sources list
RUN apk update && \
	apk add postgresql-dev gcc python3-dev musl-dev bash postgresql-client git && \
	pip install psycopg2 gunicorn raven

WORKDIR /app
RUN addgroup -S django && \
	adduser -S -G django django && \
	mkdir /docker

ADD create_admin.py postgres_ready.py docker-entrypoint.sh /docker/

ENV DJANGO_WSGI_MODULE=base.wsgi \
	DJANGO_SETTINGS_MODULE=base.production \
	ALLOWED_HOSTS="*" \
	CORS_ORIGINS="localhost:10000" \
	DB_HOSTNAME="postgres"

EXPOSE 8000
ENTRYPOINT ["/docker/docker-entrypoint.sh"]
