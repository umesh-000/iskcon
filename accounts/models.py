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
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
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
    status = models.IntegerField(choices=STATUS_CHOICES, default=0, verbose_name="Status")  
    create_at = models.DateTimeField(default=timezone.now)
    update_at = models.DateTimeField(default=timezone.now)

    class Meta:
        db_table = 'customers'

    def __str__(self):
        return f"{self.user.first_name} {self.user.last_name} - {self.user.email}"

# Customer address book
class AddressBook(models.Model):
    
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='address_book')
    name = models.CharField(max_length=255, blank=True, null=True) 
    mobile_no = models.CharField(max_length=15, blank=True, null=True)
    address_type = models.CharField(max_length=10, blank=True, null=True)
    address_line_1 = models.CharField(max_length=255)
    address_line_2 = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    postal_code = models.CharField(max_length=20, blank=True, null=True)
    country = models.CharField(max_length=100)
    is_default = models.BooleanField(default=False)
    class Meta:
        db_table = 'customer_address_book'
        unique_together = ('customer', 'address_type', 'is_default')
    def save(self, *args, **kwargs):
        with transaction.atomic():
            if self.is_default:
                AddressBook.objects.filter(customer=self.customer, address_type=self.address_type, is_default=True).update(is_default=False)
            super().save(*args, **kwargs)
    def __str__(self):
        return f"{self.address_type.capitalize()} address for {self.customer.user.email}"