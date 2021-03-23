""" Define URL patterns for status."""

from django.urls import path, include
from rest_framework import routers
from . import views

app_name = 'xistatus'
#router = routers.DefaultRouter()
#router.register(r'members', views.MemberView, basename="Member")
#router.register(r'linkshells', views.LinkshellView, basename="Linkshell")

urlpatterns = [
    # Home page
    # path('', views.index, name='index'),
#    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    #path('linkshells/', views.LinkshellView.as_view()),
    #path('members/', views.MemberView.as_view()),
    #path('', include(router.urls)),
    path('', views.apiOverview, name="api-overview"),
    path('linkshells', views.linkshellList, name="linkshells"),
    path('linkshell-create/', views.linkshellCreate, name="linkshell-create"),
    path('linkshell-delete/<str:pk>/', views.linkshellDelete, name="linkshell-delete"),
    path('linkshell-update/<str:pk>/', views.linkshellUpdate, name="linkshell-update"),
    path('linkshell-detail/<str:linkshell_name>/', views.linkshellDetail, name="linkshell-detail"),
    path('members', views.memberList, name="members"),
    path('members/<str:pk>', views.MemberByLinkshell, name="members-by-linkshell"),
    path('member-create-or-update/', views.memberCreateOrUpdate, name="member-create-or-update"),
    path('member-delete/<str:pk>/', views.memberDelete, name="member-delete"),
#    path('member-update/<str:pk>/', views.memberUpdate, name="member-update"),
    path('member-detail/<str:character>/', views.memberDetail, name="member-detail"),
]
