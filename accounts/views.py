from django.shortcuts import render , redirect , get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password
from django.contrib.auth import authenticate, login as auth_login
from django.contrib.auth import get_user_model
# from aquarium_eccomerce import utils
from django.contrib import messages
from django.utils import timezone
from accounts import models
from myadmin import models as admin_models
import logging


logger = logging.getLogger(__name__)
User = get_user_model()         


def index(request):
    return redirect('admin_login')

def admin_register(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')

        # Check if user already exists
        if models.User.objects.filter(username=username).exists():
            messages.error(request, "Username already exists!")
            return redirect('register')

        # Create User
        user = models.User.objects.create(username=username,email=email,password=make_password(password),user_type="admin")
        models.Admins.objects.create(user=user)
        messages.success(request, "Registration successful!")
        return redirect('admin_login')

    return render(request, 'accounts/admin_register.html')


def customer_register(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        phone_number = request.POST.get('phone_number')
        if models.User.objects.filter(username=username).exists():
            messages.error(request, "Username already exists!")
            return redirect('customer_register')
        
        # user = models.User.objects.create( username=username, email=email, password=make_password(password), user_type="customer")
        user = models.User.objects.create_user( username=username, email=email, password=password, user_type="customer" )
        models.Customer.objects.create( user=user, phone_number=phone_number, status=1, create_at=timezone.now(), update_at=timezone.now() )
        messages.success(request, "Registration successful!")
        return redirect('login')
    return render(request, 'accounts/customer_register.html')

def admin_login(request):  # Renamed to avoid conflict
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        remember = request.POST.get('remember')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            auth_login(request, user)  # Use Django's login function
            if remember == 'on':
                request.session.set_expiry(7200)  # 2 hours
            else:
                request.session.set_expiry(0)  # Session expires on browser close
            if user.user_type == 'admin':
                request.session['admin_id'] = user.id
                messages.success(request, "Login Successful!")
                return redirect('admin_dashboard')
            # elif user.user_type == 'customer':
            #     messages.success(request, "Login Successful!")
            #     return redirect('site_home')
        else:
            messages.error(request, "Invalid credentials!")
            return redirect('admin_login')
    return render(request, 'accounts/login.html')

# def password_recovery(request):
#     if request.method == 'POST':
#         email = request.POST.get('email')
#         if not email:
#             messages.error(request, "Email is required.")
#             return redirect("password_recovery")
#         print("Email received:", email)
#         if utils.send_password_recovery_email(request, email):
#             request.session['recovery_email'] = email
#             messages.success(request, "Password recovery email sent! Please check your inbox.")
#             return redirect("otp_verification")
#         else:
#             messages.error(request, "No user found with that email address.")
#             return redirect("password_recovery")
#     return render(request, "accounts/password_recovery.html")

# def OTP_verification(request):
#     email = request.session.get('recovery_email')
#     if not email:
#         messages.error(request, "Email is missing from the session. Please start over.")
#         return redirect("password_recovery")
#     if request.method == 'POST':
#         otp = request.POST.get('otp', '').strip()
#         if not otp:
#             messages.error(request, "OTP is required.")
#             return redirect("OTP_verification")
#         if utils.verify_otp(request, email, otp):
#             return redirect("change_password")
#         else:
#             messages.error(request, "Invalid OTP!")
#             return redirect("otp_verification")
#     return render(request, "accounts/OTP_verification.html")

# def change_password(request):
#     email = request.session.get('recovery_email')
#     if not email:
#         messages.error(request, "Email is missing from the session. Please start over.")
#         return redirect("password_recovery")
#     if request.method == 'POST':
#         new_password = request.POST.get('new_password')
#         confirm_password = request.POST.get('confirm_password')
#         if not new_password or not confirm_password:
#             messages.error(request, "All fields are required.")
#             return redirect("change_password")
#         if new_password != confirm_password:
#             messages.error(request, "Passwords do not match!")
#             return redirect("change_password")
#         if utils.change_password(request, email, new_password):
#             del request.session['recovery_email']
#             messages.success(request, "Password changed successfully!")
#             return redirect("login")
#         else:
#             messages.error(request, "Failed to change password!")
#             return redirect("change_password")
#     return render(request, "accounts/change_password.html")