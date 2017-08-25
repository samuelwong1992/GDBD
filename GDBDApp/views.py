# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.contrib.auth.models import User
from rest_framework import generics
from GDBDApp.serializers import UserSerializer, DotSerializer
from GDBDApp.models import Dot
from rest_framework.views import APIView
from rest_framework.response import Response
from django.core import serializers
from django.shortcuts import render

# Create your views here.
class DotList(generics.ListCreateAPIView) :
	queryset = Dot.objects.all()
	serializer_class = DotSerializer
	def list(self, request) :
		queryset = Dot.objects.all().filter(owner = request.user)
		serializer = DotSerializer(queryset, many = True, context={'request': request})
		return Response(serializer.data)
	def perform_create(self, serializer) :
		serializer.save(owner = self.request.user)

class DotDetail(generics.RetrieveUpdateAPIView) :
	queryset = Dot.objects.all()
	serializer_class = DotSerializer

class UserList(generics.ListAPIView) :
	queryset = User.objects.all()
	serializer_class = UserSerializer

class UserDetail(generics.RetrieveAPIView) :
	queryset = User.objects.all()
	serializer_class = UserSerializer