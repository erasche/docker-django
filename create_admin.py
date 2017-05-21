#!/usr/bin/env python

import random, string, sys, os
sys.path.append(os.getcwd())
import django
django.setup()
from django.contrib.auth.models import User
password  = "".join([random.SystemRandom().choice(string.digits + string.ascii_letters) for i in range(32)])

try:
	u = User.objects.create_superuser('admin', 'admin@localhost', password)
	u.save()
except:
	u = User.objects.filter(username='admin')[0]
	u.set_password(password)
	u.save()

print("\n\nSeting admin password to %s\n\n" % password)
