"""GDBD URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from GDBDApp import views
from rest_framework.urlpatterns import format_suffix_patterns
from django.conf.urls import include

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^rest-auth/', include('rest_auth.urls')),
    url(r'^rest-auth/registration/', include('rest_auth.registration.urls')),
	url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
	url(r'^dot/$', views.DotList.as_view()),
	url(r'^dot/(?P<pk>[0-9]+)/$', views.DotDetail.as_view(), name = 'dot-detail'),
	url(r'^users/$', views.UserList.as_view(), name = 'user-list'),
	url(r'^users/(?P<pk>[0-9]+)/$', views.UserDetail.as_view(), name = 'user-detail'),
]
