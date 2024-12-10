import requests
import json
from django.conf import settings
from django.contrib.auth import get_user_model

User = get_user_model()

def send_push_notification_to_users(title, message):
    url = "https://onesignal.com/api/v1/notifications"
    headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": f"Basic {settings.ONESIGNAL_API_KEY}",
    }
    non_admin_users = User.objects.filter(is_staff=False, user_type='customer').values_list('id', flat=True)
    if not non_admin_users:
        print("No non-admin users found to send the notification.")
        return None

    # Build notification payload
    data = {
        "app_id": settings.ONESIGNAL_APP_ID,
        "filters": [{"field": "tag", "key": "user_id", "relation": "IN", "value": list(non_admin_users)}],
        "headings": {"en": title},
        "contents": {"en": message},
    }

    try:
        response = requests.post(url, headers=headers, data=json.dumps(data))
        response.raise_for_status()
        print(f"Notification sent successfully: {response.json()}")
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error sending push notification: {e}")
        return None






# from myadmin import models
# from accounts import models as accountModels
# import random
# def generate_unique_sku(prefix='SKU', length=8):
#     """Generate a unique SKU with the given prefix and an 8-digit number."""
#     while True:
#         number = str(random.randint(10000000, 99999999))
#         sku = f"{prefix}{number}"
#         # Check if this SKU already exists
#         if not models.Product.objects.filter(sku=sku).exists():
#             return sku
        


# def generate_order_number(prefix='ORDER', length=8):
#     while True:
#         number = str(random.randint(10000000, 99999999))
#         order_number = f"{prefix}{number}"
#         if not accountModels.OrderHistory.objects.filter(order_number=order_number).exists():
#             return order_number
        