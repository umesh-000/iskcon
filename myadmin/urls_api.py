from django.urls import path
from myadmin import API_views

urlpatterns = [
    # Auth
    path('customers/register/', API_views.RegisterView.as_view(), name='customer_register'),
    path('customers/login/', API_views.LoginView.as_view(), name='customer_login'),

    path('customers/blogs/', API_views.blogs, name='blogs_api'),
    path('customers/blogs/<int:id>/', API_views.blog_details, name='blog_details_api'),
    path('customers/books/', API_views.books, name='books_api'),
    path('customers/books/<int:id>/', API_views.book_details, name='book_details_api'),
    path('customers/events/', API_views.events, name='events_api'),
    path('customers/events/<int:id>/', API_views.event_details, name='event_details_api'),
    path('customers/privacy_policy/', API_views.privacy_policy_view, name='privacy_policy_API'),
    path('customers/terms_and_conditions/', API_views.terms_and_conditions_view, name='terms_and_conditions_API'),
]