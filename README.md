# Django Docker File

Simple dockerfile for use in django projects.

Features:

- gunicorn
- lots of defaults provided for you
- startup script that waits on postgres being available
- script to automatically, randomly set the "admin" user password, and make it
  visible to the console logs
- Ability to control number of workers and log level

## How to use this

Copy and paste the following into your project and tweak to your needs.

```Dockerfile
# https://github.com/TAMU-CPT/docker-recipes/blob/master/django/Dockerfile.inherit
FROM quay.io/tamu_cpt/django

# Add our project to the /app/ folder
ADD . /app/
# Install dependencies
RUN pip install -r /app/requirements.txt
# Set current working directory to /app
WORKDIR /app/

# Fix permissions on folder while still root, and collect static files for use
# if need be.
RUN chown -R django /app && \
	python manage.py collectstatic --noinput

# Drop permissions
USER django
```
