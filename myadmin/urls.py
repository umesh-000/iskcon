from django.contrib import admin
from django.urls import path
from myadmin import views
from django.urls import path, include


urlpatterns = [
    path('', views.admin_dashboard, name='admin_dashboard'),    
    # path('<int:id>/profile_details', views.admin_profile_details, name='admin_profile_details'),
    # path('<int:id>/change_password', views.admin_change_password, name='admin_change_password'),

    path('blogs/', views.blog_list, name='blog_list'),
    path('blogs/create/', views.blog_create, name='blog_create'),
    path('blogs/<int:id>/edit/', views.blog_edit, name='blog_edit'),
    path('blogs/<int:id>/delete/', views.blog_delete, name='blog_delete'),

    path('book/', views.book_list, name='book_list'),
    path('book/create/', views.book_create, name='book_create'),
    path('book/<int:id>/edit/', views.book_edit, name='book_edit'),
    path('book/<int:id>/delete/', views.book_delete, name='book_delete'),

    path('events/', views.event_list, name='event_list'),
    path('events/create/', views.event_create, name='event_create'),
    path('events/<int:id>/edit/', views.event_edit, name='event_edit'),
    path('events/<int:id>/delete/', views.event_delete, name='event_delete'),   
    
    path('privacy-policy/', views.privacy_policy, name='privacy_policy'),
    path('terms-and-conditions/', views.terms_and_conditions, name='terms_and_conditions'),
    path('notifications/', views.notifications, name='notifications'),
    path('notification_create/', views.notification_create, name='notification_create'),
]