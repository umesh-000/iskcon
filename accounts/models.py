from django.contrib.auth.models import AbstractUser
from django.db import models
from django.conf import settings
from django.utils import timezone
from django.db import transaction


USER_TYPE_CHOICES = [('admin', 'Admin'),('customer', 'Customer'),]
STATUS_CHOICES = [(1, 'Active'),(0, 'Inactive'),]
GENDER_CHOICES = [ ('male', 'Male'), ('female', 'Female'), ('other', 'Other'), ]

# Extending the User model
class User(AbstractUser):
    user_type = models.CharField(max_length=10, choices=USER_TYPE_CHOICES)
    class Meta:
        db_table = 'accounts_user'

# Admin model
class Admins(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE,related_name='admin_profile')
    profile_image = models.ImageField(upload_to='admin/profiles/', blank=True, null=True)
    class Meta:
        db_table = 'admins'

# Customer model
class Customer(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='customer_profile')
    profile_image = models.ImageField(upload_to='customers/profiles/', blank=True, null=True)
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    gender = models.CharField(max_length=10, choices=GENDER_CHOICES,null=True, blank=True)
    dob = models.DateField(null=True, blank=True)
    status = models.IntegerField(choices=STATUS_CHOICES, default=1, verbose_name="Status")  
    create_at = models.DateTimeField(default=timezone.now)
    update_at = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'customers'

    def __str__(self):
        return f"{self.user.first_name} {self.user.last_name} - {self.user.email}"