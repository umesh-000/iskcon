from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.permissions import IsAuthenticated,AllowAny
from rest_framework_simplejwt.tokens import RefreshToken
from myadmin import serializers as API_serializers
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from datetime import datetime, timedelta
from .models import AboutUs, Audio, Blog,Book,Event,PrivacyPolicy,TermsAndConditions, Video
from django.db import transaction
from accounts import models as account_models
from rest_framework import status
from django.conf import settings
import logging
import secrets
from django.contrib.auth.hashers import make_password



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
    

@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def about_us_view(request):
    try:
        about_us = AboutUs.objects.filter(is_active=True).order_by('-updated_at').first()
        if not about_us:
            return Response({'status': 'error', 'message': 'About Us content not found or inactive.'},status=status.HTTP_404_NOT_FOUND)
        serializer = API_serializers.AboutUsSerializer(about_us, context={'request': request})
        return Response({'status': 'success', 'data': serializer.data}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def videos(request):
    try:
        videos = Video.objects.filter(status=1).order_by('-created_at')
        serializer = API_serializers.videosSerializer(videos, many=True)
        return Response({'status': 'success', 'data': serializer.data}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def video_details(request, id):
    try:
        video = Video.objects.get(id=id, status=1)  # Get video with active status
        serializer = API_serializers.videosSerializer(video)  # Serialize the video object
        return Response({
            'status': 'success',
            'data': serializer.data
        }, status=status.HTTP_200_OK)
    except Video.DoesNotExist:
        return Response({
            'status': 'error',
            'message': 'Video not found.'
        }, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def audios(request):
    try:
        # Fetch all active audios
        audios = Audio.objects.filter(status=1).order_by('-created_at')
        # Serialize the audio data
        serializer = API_serializers.audiosSerializer(audios, many=True)
        return Response({'status': 'success', 'data': serializer.data}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


# Get details of a single audio
@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def audios_details(request, id):
    try:
        # Fetch audio with given ID and status 1 (active)
        audio = Audio.objects.get(id=id, status=1)
        # Serialize the audio object
        serializer = API_serializers.audiosSerializer(audio)
        return Response({
            'status': 'success',
            'data': serializer.data
        }, status=status.HTTP_200_OK)
    except Audio.DoesNotExist:
        return Response({
            'status': 'error',
            'message': 'Audio not found.'
        }, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({'status': 'error', 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

@api_view(['GET'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def customerGetProfile(request, customer_id):
    try:
        print(customer_id)
        customer = account_models.Customer.objects.get(id=customer_id, user__user_type='customer')
        serializer = API_serializers.CustomerSerializer(customer)
        return Response({ 'status': 'success', 'data': serializer.data }, status=status.HTTP_200_OK)
    except account_models.Customer.DoesNotExist:
        return Response({ 'status': 'error', 'message': 'Customer not found' }, status=status.HTTP_404_NOT_FOUND)


@api_view(['PUT'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def customerUpdate(request, customer_id):
    try:
        customer = account_models.Customer.objects.get(id=customer_id, user__user_type='customer')
        serializer = API_serializers.CustomerUpdateSerializer(customer, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({ 'status': 'success', 'data': serializer.data }, status=status.HTTP_200_OK)
        return Response({ 'status': 'error', 'errors': serializer.errors }, status=status.HTTP_400_BAD_REQUEST)
    except account_models.Customer.DoesNotExist:
        return Response({ 'status': 'error', 'message': 'Customer not found' }, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
@permission_classes([AllowAny])
def resetPassword(request):
    serializer = API_serializers.ResetPasswordSerializer(data=request.data)
    if serializer.is_valid():
        email = serializer.validated_data['email']
        customer_id = serializer.validated_data['customer_id']
        try:
            customer = account_models.Customer.objects.select_related('user').get(id=customer_id, user__email=email)
            user = customer.user
            new_password = secrets.token_urlsafe(8)
            user.password = make_password(new_password)
            user.save()
            # Send password reset email
            subject = "Password Reset Request"
            message = (
                f"Dear {user.first_name} {user.last_name},\n\n"
                f"Your password has been successfully reset. Your new password is:\n\n"
                f"{new_password}\n\n"
                "Please log in and change your password immediately for security purposes.\n\n"
                "Thank you."
            )
            from_email = "no-reply@example.com"
            recipient_list = [email]
            # Uncomment this line after configuring email settings in Django
            # send_mail(subject, message, from_email, recipient_list)
            return Response(
                {
                    "status": "success",
                    "message": "A new password has been sent to the provided email.",
                    "new_password": new_password,  # Optional: Include this only for debugging (remove in production)
                }, status=status.HTTP_200_OK,
            )
        except account_models.Customer.DoesNotExist:
            return Response( {"status": "error", "message": "No customer found with the provided email and ID."}, status=status.HTTP_404_NOT_FOUND, )
    return Response({"status": "error", "errors": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)



@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
@authentication_classes([JWTAuthentication])
def customersDelete(request):
    try:
        customer_id = request.data.get('customer_id')
        if not customer_id:
            return Response({ 'status': 'error', 'message': 'Customer ID is required.' }, status=status.HTTP_400_BAD_REQUEST)
        with transaction.atomic():
            customer = account_models.Customer.objects.get(id=customer_id)
            user = customer.user
            customer.delete()
            user.delete()
        return Response({ 'status': 'success','message': f'Customer and associated user with ID {customer_id} deleted successfully.' }, status=status.HTTP_200_OK)
    except account_models.Customer.DoesNotExist:
        return Response({ 'status': 'error', 'message': 'Customer not found.' }, status=status.HTTP_404_NOT_FOUND)
    except Exception as e:
        return Response({ 'status': 'error', 'message': str(e) }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)