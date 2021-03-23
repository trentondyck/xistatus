""" Define URL patterns for status."""

from django.urls import path, include
from . import views

# app_name = 'xistatus'

urlpatterns = [
    # Home page
    path('', views.list, name="list"),
]
