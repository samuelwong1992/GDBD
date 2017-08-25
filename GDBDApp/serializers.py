from django.contrib.auth.models import User, Group
from rest_framework import serializers
from GDBDApp.models import Dot

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email')

class DotSerializer(serializers.HyperlinkedModelSerializer) :
	class Meta:
		model = Dot
		fields = ('url', 'name', 'date_time', 'is_good', 'owner')