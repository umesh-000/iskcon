from django.contrib.auth.hashers import make_password
from accounts import models as account_models
from myadmin import models as admin_models
from django.contrib.auth import authenticate
from rest_framework import serializers


class RegisterSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(required=True)
    password = serializers.CharField(write_only=True, required=True, style={'input_type': 'password'})
    customer_name = serializers.CharField(required=True)
    phone_number = serializers.CharField(required=True)
    dob = serializers.DateField(format='%Y-%m-%d', input_formats=['%Y-%m-%d'], required=False)
    gender = serializers.ChoiceField(choices=account_models.GENDER_CHOICES, required=False)

    class Meta:
        model = account_models.Customer
        fields = ['email', 'password', 'customer_name', 'phone_number', 'dob', 'gender']

    def validate_email(self, value):
        if account_models.User.objects.filter(email=value).exists():
            raise serializers.ValidationError("A user with this email already exists.")
        return value

    def validate_phone_number(self, value):
        if account_models.Customer.objects.filter(phone_number=value).exists():
            raise serializers.ValidationError("A user with this phone number already exists.")
        return value

    def create(self, validated_data):
        customer_name = validated_data.pop('customer_name')
        first_name, *last_name = customer_name.split(' ', 1)
        last_name = last_name[0] if last_name else ''
        user = account_models.User.objects.create(username=validated_data['email'],email=validated_data['email'],user_type='customer',first_name=first_name,last_name=last_name,password=make_password(validated_data['password']),)
        customer = account_models.Customer.objects.create(user=user,phone_number=validated_data['phone_number'],dob=validated_data.get('dob'),gender=validated_data.get('gender'),)
        return customer

class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        email = data.get('email')
        password = data.get('password')

        if email and password:
            user = authenticate(username=email, password=password)
            if user:
                if not user.is_active:
                    raise serializers.ValidationError("User account is disabled.")
                return {'user': user}
            else:
                raise serializers.ValidationError("Invalid email or password.")
        raise serializers.ValidationError("Email and password are required.")

class BlogSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.Blog
        fields = ['id', 'added_by', 'title', 'subtitle', 'image', 'description', 'status', 'created_at', 'updated_at']

class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.Book
        fields = ['id', 'title', 'author_name', 'cover_image', 'status', 'book_file', 'created_at', 'updated_at']

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.Event
        fields = ['id', 'title', 'description', 'venue', 'image', 'status', 'created_at', 'updated_at']

class PrivacyPolicySerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.PrivacyPolicy
        fields = ('id', 'title', 'content', 'is_active', 'created_at', 'updated_at')

class TermsAndConditionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.TermsAndConditions
        fields = ('id', 'title', 'content', 'is_active', 'created_at', 'updated_at')

class AboutUsSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.AboutUs
        fields = ('id', 'title', 'content', 'is_active', 'created_at', 'updated_at')
        

class videosSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.Video
        fields = '__all__' 


class audiosSerializer(serializers.ModelSerializer):
    class Meta:
        model = admin_models.Audio
        fields = '__all__' 


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = account_models.User
        fields = ['id', 'email', 'first_name', 'last_name']

class CustomerSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = account_models.Customer
        fields = ['id', 'user', 'profile_image', 'phone_number', 'gender', 'dob', 'status', 'create_at', 'update_at']

class CustomerUpdateSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    class Meta:
        model = account_models.Customer
        fields = [ 'id',  'user',  'profile_image',  'phone_number',  'gender',  'dob', 'status', 'create_at', 'update_at']
    def update(self, instance, validated_data):
        user_data = validated_data.pop('user', None)
        if user_data:
            user = instance.user
            email = user_data.get('email')
            for key, value in user_data.items():
                setattr(user, key, value)
            if email:
                user.username = email
            user.save()
        for key, value in validated_data.items():
            setattr(instance, key, value)
        instance.save()
        return instance


class ResetPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()
    customer_id = serializers.IntegerField()
    def validate(self, data):
        email = data.get('email')
        customer_id = data.get('customer_id')
        if not account_models.Customer.objects.filter(id=customer_id, user__email=email, user__user_type='customer').exists():
            raise serializers.ValidationError("No customer found with this email and customer ID.")
        return data