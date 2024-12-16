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
    
    path('about-us/', views.about_us, name='about_us'),
    path('privacy-policy/', views.privacy_policy, name='privacy_policy'),
    path('terms-and-conditions/', views.terms_and_conditions, name='terms_and_conditions'),

    path('notifications/', views.notifications, name='notifications'),
    path('notification_create/', views.notification_create, name='notification_create'),

    path('videos/', views.video_list, name='video_list'),
    path('videos/create/', views.video_create, name='video_create'),
    path('videos/<int:id>/edit/', views.video_edit, name='video_edit'),
    path('videos/<int:id>/delete/', views.video_delete, name='video_delete'),

    path('audio/', views.audio_list, name='audio_list'),
    path('audio/create/', views.audio_create, name='audio_create'),
    path('audio/<int:id>/edit/', views.audio_edit, name='audio_edit'),
    path('audio/<int:id>/delete/', views.audio_delete, name='audio_delete'),

    # Customer URLs
    path('customers/', views.customer_list, name='customer_list'),  # List all customers
    path('customers/create/', views.customer_create, name='customer_create'),  # Create a customer
    path('customers/<int:id>/', views.customer_edit, name='customer_edit'),  # View a customer
    path('customers/<int:id>/delete/', views.customer_delete, name='customer_delete'),  # Delete a customer

]

