from django.contrib.auth.views import LogoutView
from django.conf.urls.static import static
from django.urls import path, include
from django.conf import settings
from accounts import views
urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.admin_login, name='admin_login'),
    path('register/', views.admin_register, name='admin_register'),
    path('logout/', LogoutView.as_view(next_page='admin_login'), name='logout'),
]