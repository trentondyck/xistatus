from django.contrib import admin

# Register your models here.
from .models import Linkshell, Member

admin.site.register(Linkshell)
admin.site.register(Member)
