from django.contrib.auth.models import User, Group
from rest_framework import serializers
from .models import Linkshell, Member


class MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = Member
        fields = '__all__'

class LinkshellSerializer(serializers.ModelSerializer):
    class Meta:
        model = Linkshell
        fields = '__all__'


#    def to_internal_value(self, data):
#        name = data.get('name')
#        linkshell = data.get('linkshell')
#2        status = data.get('status')
#        zone = data.get('zone')
#        hostname = data.get('hostname')
#
#        return {
#            'name': name,
#            'linkshell': linkshell,
#            'status': status,
#            'zone': zone,
###            'hostname': hostname
#        }
#
#    def to_representation(self, instance):
#        return {
#            'name': instance.name,
##            'linkshell': instance.linkshell,
#            'status': instance.status,
#            'zone': instance.zone,
##            'hostname': instance.hostname
#        }

##    def create(self, validated_data):
#        return Member.objects.create(**validated_data)
#
#class LinkshellSerializer(serializers.BaseSerializer):
#
#    def to_internal_value(self, data):
#        linkshell = data.get('linkshell')
#
#        return {
#            'linkshell': linkshell
#        }

#    def to_representation(self, instance):
#        return {
#            'linkshell': instance.linkshell
#        }

#    def create(self, validated_data):
#        return Linkshell.objects.create(**validated_data)
#
