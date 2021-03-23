from django.shortcuts import render
from django.http import JsonResponse
#from django.contrib.auth.models import User, Group
from rest_framework.decorators import api_view, schema
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import permissions
from .serializers import MemberSerializer, LinkshellSerializer
from .models import Linkshell, Member

# Create your views here.

def index(request):
    """ The home page for xistatus. """
    return render(request, 'xistatus/index.html')

@api_view(['GET'])
def apiOverview(request):
    api_urls = {
        'Linkshells List':'/linkshells/',
        'Linkshells Detail View':'/linkshells/<str:pk>/',
        'Linkshells Create':'/linkshells/create/',
        'Linkshells Update':'/linkshells/update/<str:pk>/',
        'Linkshells Delete':'/linkshells/delete/<str:pk>/',
        'Members List':'/members/',
        'Members List By Linkshell ID':'/members/<str:pk>/',
        'Members Detail View By Member ID':'/members/<str:pk>/',
        'Members Create By Linkshell ID':'/members/create/<str:pk>',
        'Members Update By Member ID / Linkshell ID':'/linkshells/update/<str:pk>/<str:pk>',
        'Members Delete By Member ID / Linkshell ID':'/linkshells/delete/<str:pk>/<str:pk>',
    }
    return Response(api_urls)

# ==========================================================================================================

@api_view(['GET'])
def linkshellList(request):
    linkshells = Linkshell.objects.all()
    serializer = LinkshellSerializer(linkshells, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def linkshellCreate(request):
    serializer = LinkshellSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()

#    return Response(serializer.data)
    return Response(serializer.data['id'])

@api_view(['GET'])
def linkshellDetail(request, linkshell_name):

    try:
        linkshell = Linkshell.objects.get(text=linkshell_name)
        serializer = LinkshellSerializer(linkshell, many=False)
    except:
        return Response(0)

    return Response(serializer.data['id'])

@api_view(['POST'])
def linkshellUpdate(request, pk):
    linkshell = Linkshell.objects.get(id=pk)
    serializer = LinkshellSerializer(instance=linkshell, data=request.data)
    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(['DELETE'])
def linkshellDelete(request, pk):
    linkshell = Linkshell.objects.get(id=pk)
    linkshell.delete()
    return Response("Linkshell Deleted")

# ==========================================================================================================

@api_view(['GET'])
def memberList(request):
    members = Member.objects.all()
    serializer = MemberSerializer(members, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def MemberByLinkshell(request, pk):
    members = Member.objects.filter(linkshell=pk)
    serializer = MemberSerializer(members, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def memberCreateOrUpdate(request):
    serializer = MemberSerializer(data=request.data)
    try:
        name=request.data['character']
        member = Member.objects.get(character=name)
        request.data['id'] = member.id
        request.data['linkshell'] = member.linkshell.id
        serializer = MemberSerializer(instance=member, data=request.data)
    except:
        serializer = MemberSerializer(data=request.data)

    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(['GET'])
def memberDetail(request, character):
    try:
        member = Member.objects.get(character=character)
        serializer = MemberSerializer(member, many=False)
    except:
        return Response(0)

    return Response(serializer.data)

#@api_view(['POST'])
#def memberUpdate(request, pk):
#    member = Member.objects.get(id=pk)
#    serializer = MemberSerializer(instance=member, data=request.data)
#
#    if serializer.is_valid():
#        serializer.save()
#
#    return Response(serializer.data)

@api_view(['DELETE'])
def memberDelete(request, pk):
    member = Member.objects.get(id=pk)
    member.delete()
    return Response("Member Deleted")

