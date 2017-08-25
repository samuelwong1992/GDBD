# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.contrib.auth.models import User
from django.db import models

# Create your models here.

class Dot(models.Model) :
	date_time = models.DateTimeField(auto_now_add = True)
	name = models.CharField(max_length=200)
	is_good = models.BooleanField()
	owner = models.ForeignKey('auth.User', related_name='dots', on_delete=models.SET_NULL, null=True)