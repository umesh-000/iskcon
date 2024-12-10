from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.permissions import IsAuthenticated,AllowAny
from rest_framework_simplejwt.tokens import RefreshToken
from myadmin import serializers as API_serializers
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from datetime import datetime, timedelta
from .models import Blog,Book,Event,PrivacyPolicy,TermsAndConditions
from django.db import transaction
from rest_framework import status
from django.conf import settings
import logging



logger = logging.getLogger(__name__)

class RegisterView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        serializer = API_serializers.RegisterSerializer(data=request.data)
        if serializer.is_valid():
            try:
                with transaction.atomic():
                    customer = serializer.save()
                    return Response(
                        {
                            'message': 'Registration successful',
                            'email': customer.user.email,
                            'customer_name': f"{customer.user.first_name} {customer.user.last_name}",
                            'phone_number': customer.phone_number,
                        },
                        status=status.HTTP_201_CREATED,
                    )
            except Exception as e:
                return Response(
                    {'message': 'An error occurred during registration. Please try again later.'},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        serializer = API_serializers.LoginSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.validated_data.get('user')
            if user:
                refresh = RefreshToken.for_user(user)
                access_token_expiry = datetime.now() + settings.SIMPLE_JWT['ACCESS_TOKEN_LIFETIME']
                access_token_expiry_minutes = int(settings.SIMPLE_JWT['ACCESS_TOKEN_LIFETIME'].total_seconds() // 60)
                return Response({
                    'email': user.email,
                    'user_type': user.user_type,
                    'access_token': str(refresh.access_token),
                    'access_token_expiry': f"{access_token_expiry_minutes} minutes",
                    'message': 'Login successful'
                }, status=status.HTTP_200_OK)
            else:
                return Response({'error': 'Invalid credentials'}, status=status.HTTP_400_BAD_REQUEST)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def blogs(request):
    blogs = Blog.objects.filter(status=1).order_by('-created_at')
    serializer = API_serializers.BlogSerializer(blogs, many=True)
    return Response({'status': 'success', 'data': serializer.data})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def blog_details(request, id):
    try:
        blog = Blog.objects.get(id=id, status=1) 
        serializer = API_serializers.BlogSerializer(blog) 
        return Response({
            'status': 'success',
            'data': serializer.data
        }, status=status.HTTP_200_OK)
    except Blog.DoesNotExist:
        return Response({
            'status': 'error',
            'message': 'Blog not found.'
        }, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication]) 
def books(request):
    books = Book.objects.filter(status=1).order_by('-created_at')
    serializer = API_serializers.BookSerializer(books, many=True)
    return Response({'status': 'success', 'data': serializer.data})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def book_details(request, id):
    try:
        book = Book.objects.get(id=id, status=1) 
        serializer = API_serializers.BookSerializer(book)
        return Response({
            'status': 'success',
            'data': serializer.data
        }, status=status.HTTP_200_OK)
    except Book.DoesNotExist:
        return Response({
            'status': 'error',
            'message': 'Book not found.'
        }, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication]) 
def events(request):
    events = Event.objects.filter(status=True).order_by('-created_at')  # Published events only
    serializer = API_serializers.EventSerializer(events, many=True)
    return Response({'status': 'success', 'data': serializer.data})


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def event_details(request, id):
    event = Event.objects.filter(id=id, status=True).first()
    if not event:
        return Response({'status': 'error', 'message': 'Event not found or inactive.'},status=status.HTTP_404_NOT_FOUND)
    serializer = API_serializers.EventSerializer(event)
    return Response({'status': 'success', 'data': serializer.data},status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def privacy_policy_view(request):
    try:
        privacy_policy = PrivacyPolicy.objects.filter(is_active=True).order_by('-updated_at').first()
        if not privacy_policy:
            return Response({'status': 'error', 'message': 'Privacy Policy not found or inactive.'},status=status.HTTP_404_NOT_FOUND)
        serializer = API_serializers.PrivacyPolicySerializer(privacy_policy, context={'request': request})
        return Response({'status': 'success', 'data': serializer.data}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
        
@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def terms_and_conditions_view(request):
    try:
        terms_and_conditions = TermsAndConditions.objects.filter(is_active=True).order_by('-updated_at').first()
        if not terms_and_conditions:
            return Response({'status': 'error', 'message': 'Terms and Conditions not found or inactive.'},status=status.HTTP_404_NOT_FOUND)
        serializer = API_serializers.TermsAndConditionsSerializer(terms_and_conditions, context={'request': request})
        return Response({'status': 'success', 'data': serializer.data}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)