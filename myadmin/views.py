from django.shortcuts import redirect, render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import cache_control
from django.contrib.auth.hashers import make_password
from django.contrib.auth import get_user_model
from django.core.paginator import Paginator
from django.http import JsonResponse
from django.contrib import messages
from django.db import transaction
from myadmin import models
from accounts import models as account_models
import logging

# Set up logging
logger = logging.getLogger(__name__)

User = get_user_model()

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def admin_dashboard(request):
    # if not request.admin_user:
    #     return redirect('login')
    
    # # Dashboard data aggregations
    # total_customers = account_models.Customer.objects.count()
    # total_orders = account_models.OrderHistory.objects.count()
    # total_revenue = account_models.OrderHistory.objects.aggregate(total_revenue=Sum('total_amount'))['total_revenue'] or 0
    # seven_days_ago = timezone.now() - timedelta(days=7)
    # last_7_days_orders_count = account_models.OrderHistory.objects.filter(order_date__gte=seven_days_ago).count()
    context = {
        # 'admin_user': request.admin_user,
        # 'total_customers': total_customers,
        # 'total_orders': total_orders,
        # 'total_revenue': total_revenue,
        # 'last_7_days_orders_count': last_7_days_orders_count,

    }

    return render(request, 'admin/dashboard.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_list(request):
    blogs = models.Blog.objects.all().order_by('-created_at')
    paginator = Paginator(blogs, 10)  # 10 blogs per page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'blogs': page_obj,
    }
    return render(request, 'admin/blog_list.html', context)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        subtitle = request.POST.get('subtitle')
        description = request.POST.get('description')
        status = request.POST.get('status')
        image = request.FILES.get('image')

        try:
            blog = models.Blog.objects.create(
                added_by=request.user,
                title=title,
                subtitle=subtitle,
                description=description,
                status=status,
                image=image,
            )
            messages.success(request, "Blog created successfully!")
            return redirect('blog_list')
        except Exception as e:
            messages.error(request, f"Error creating blog: {str(e)}")
    return render(request, 'admin/blog_create.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_edit(request, id):
    blog = get_object_or_404(models.Blog, id=id)
    if request.method == 'POST':
        blog.title = request.POST.get('title')
        blog.subtitle = request.POST.get('subtitle')
        blog.description = request.POST.get('description')  # CKEditor content
        blog.status = request.POST.get('status')
        if request.FILES.get('image'):
            blog.image = request.FILES['image']
        try:
            blog.save()
            messages.success(request, "Blog updated successfully!")
            return redirect('blog_list')
        except Exception as e:
            messages.error(request, f"Error updating blog: {str(e)}")
    context = {
        'blog': blog,
    }
    return render(request, 'admin/blog_edit.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_delete(request, id):
    if request.method == 'POST':
        try:
            blog = get_object_or_404(models.Blog, id=id)
            blog.delete()
            messages.success(request, "Blog Deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Blog deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def book_list(request):
    book = models.Book.objects.all().order_by('-created_at')
    paginator = Paginator(book, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'books': page_obj,
    }
    return render(request, 'admin/book_list.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def book_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        author_name = request.POST.get('author_name')
        status = request.POST.get('status')
        cover_image = request.FILES.get('cover_image')
        book_file = request.FILES.get('book_file')
        try:
            book = models.Book.objects.create(title=title,author_name=author_name,status=status,cover_image=cover_image,book_file=book_file,)
            messages.success(request, "Book created successfully!")
            return redirect('book_list') 
        except Exception as e:
            messages.error(request, f"Error creating book: {str(e)}")
    return render(request, 'admin/book_create.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def book_edit(request, id):
    book = get_object_or_404(models.Book, id=id)
    if request.method == 'POST':
        book.title = request.POST.get('title')
        book.author_name = request.POST.get('author_name')
        book.status = request.POST.get('status')
        if request.FILES.get('cover_image'):
            book.cover_image = request.FILES['cover_image']
        if request.FILES.get('book_file'):    
            book.book_file = request.FILES['book_file']                                                                                                                                                                                                                 
    
        try:
            book.save()
            messages.success(request, "Book updated successfully!")
            return redirect('book_list')
        except Exception as e:
            messages.error(request, f"Error updating book: {str(e)}")
    context = {
        'book': book,
    }
    return render(request, 'admin/book_edit.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def book_delete(request, id):
    if request.method == 'POST':
        try:
            book = get_object_or_404(models.Book, id=id)
            book.delete()
            messages.success(request, "Book Deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Book deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})



@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def event_list(request):
    events = models.Event.objects.all().order_by('-created_at')
    paginator = Paginator(events, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'events': page_obj,
    }
    return render(request, 'admin/event_list.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def event_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        description = request.POST.get('description')
        venue = request.POST.get('venue')
        status = request.POST.get('status')
        event_image = request.FILES.get('event_image')

        try:
            models.Event.objects.create(
                title=title,
                image=event_image,
                description=description,
                venue=venue,
                status=status,
            )
            messages.success(request, "Event created successfully!")
            return redirect('event_list')
        except Exception as e:
            messages.error(request, f"Error creating event: {str(e)}")

    return render(request, 'admin/event_create.html')


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def event_edit(request, id):
    event = get_object_or_404(models.Event, id=id)
    if request.method == 'POST':
        event.title = request.POST.get('title')
        event.description = request.POST.get('description')
        event.venue = request.POST.get('venue')
        event.status = request.POST.get('status')
        if request.FILES.get('image'):
            event.image = request.FILES.get('image')
        try:
            event.save()
            messages.success(request, "Event updated successfully!")
            return redirect('event_list')
        except Exception as e:
            messages.error(request, f"Error updating event: {str(e)}")
    context = {'event': event,}
    return render(request, 'admin/event_edit.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def event_delete(request, id):
    if request.method == 'POST':
        try:
            event = get_object_or_404(models.Event, id=id)
            event.delete()
            messages.success(request, "Event Delete successfully!")
            return JsonResponse({'success': True, 'message': 'Event deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})



@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def about_us(request):
    about_us = models.AboutUs.objects.first()  # Fetch the first About Us record

    if request.method == 'POST':
        title = request.POST.get('title')
        content = request.POST.get('content')
        is_active = request.POST.get('is_active', 'off') == 'on'
        
        try:
            if about_us:
                # Update existing About Us record
                about_us.title = title
                about_us.content = content
                about_us.is_active = is_active
                about_us.save()
                messages.success(request, 'About Us updated successfully.')
            else:
                # Create a new About Us record if none exists
                models.AboutUs.objects.create(title=title, content=content, is_active=is_active)
                messages.success(request, 'About Us created successfully.')
            return redirect('about_us')
        except Exception as e:
            messages.error(request, f'Error saving About Us: {str(e)}')
            return redirect('about_us')

    context = {
        'about_us': about_us,
    }
    return render(request, 'admin/about_us.html', context)



@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def privacy_policy(request):
    privacy_policy = models.PrivacyPolicy.objects.first()
    if request.method == 'POST':
        title = request.POST.get('title')
        content = request.POST.get('content')
        is_active = request.POST.get('is_active', 'off') == 'on'
        try:
            if privacy_policy:
                privacy_policy.title = title
                privacy_policy.content = content
                privacy_policy.is_active = is_active
                privacy_policy.save()
                messages.success(request, 'Privacy Policy updated successfully.')
            else:
                models.PrivacyPolicy.objects.create(title=title,content=content,is_active=is_active)
                messages.success(request, 'Privacy Policy created successfully.')
            return redirect('privacy_policy')
        except Exception as e:
            messages.error(request, f'Error saving Privacy Policy: {str(e)}')
            return redirect('privacy_policy')
    context = {
        'privacy_policy': privacy_policy,
    }
    return render(request, 'admin/privacy_policy.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def terms_and_conditions(request):
    terms_and_conditions = models.TermsAndConditions.objects.first()
    if request.method == 'POST':
        title = request.POST.get('title')
        content = request.POST.get('content')
        is_active = request.POST.get('is_active', 'off') == 'on'
        try:
            if terms_and_conditions:
                terms_and_conditions.title = title
                terms_and_conditions.content = content
                terms_and_conditions.is_active = is_active
                terms_and_conditions.save()
                messages.success(request, 'Terms and Conditions updated successfully.')
            else:
                models.TermsAndConditions.objects.create(title=title,content=content,is_active=is_active)
                messages.success(request, 'Terms and Conditions created successfully.')
            return redirect('terms_and_conditions')
        except Exception as e:
            messages.error(request, f'Error saving Terms and Conditions: {str(e)}')
            return redirect('terms_and_conditions')

    context = {
        'terms_and_conditions': terms_and_conditions,
    }
    return render(request, 'admin/terms_and_conditions.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def notifications(request):
    notifications_list = models.Notification.objects.filter(is_active=True).order_by('-created_at')
    return render(request, 'admin/notifications_list.html', {'notifications': notifications_list})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def notification_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        message = request.POST.get('message')
        is_active = request.POST.get('is_active')
        try:
            models.Notification.objects.create(title=title,message=message,status=is_active,)
            messages.success(request, "Notification created successfully!")
            return redirect('notifications')
        except Exception as e:
            messages.error(request, f"Error creating notification: {str(e)}")
    return render(request, 'admin/notification_create.html')




# video

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def video_list(request):
    videos = models.Video.objects.all().order_by('-created_at')
    paginator = Paginator(videos, 10)  # 10 videos per page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'videos': page_obj,
    }
    return render(request, 'admin/video_list.html', context)

# Create a new video
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def video_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        author = request.POST.get('author')
        description = request.POST.get('description')
        video_file = request.FILES.get('videoFile')
        thumbnail = request.FILES.get('thumbnail')
        video_url = request.POST.get('video_url')
        status = request.POST.get('status')

        try:
            video = models.Video.objects.create(
                uploaded_by=request.user,
                title=title,
                author=author,
                description=description,
                video_file=video_file,
                thumbnail=thumbnail,
                video_url=video_url,
                status=status,
            )
            messages.success(request, "Video created successfully!")
            return redirect('video_list')
        except Exception as e:
            messages.error(request, f"Error creating video: {str(e)}")
    return render(request, 'admin/video_create.html')

# Edit an existing video
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def video_edit(request, id):
    video = get_object_or_404(models.Video, id=id)
    if request.method == 'POST':
        video.title = request.POST.get('title')
        video.author = request.POST.get('author')
        video.description = request.POST.get('description')
        video.video_url = request.POST.get('video_url')
        video.status = request.POST.get('status')


        if request.FILES.get('thumbnail'):
            video.thumbnail = request.FILES['thumbnail']
        if request.FILES.get('videoFile'):
            video.video_file = request.FILES['videoFile']
        
        try:
            video.save()
            messages.success(request, "Video updated successfully!")
            return redirect('video_list')
        except Exception as e:
            messages.error(request, f"Error updating video: {str(e)}")
    
    context = {
        'video': video,
    }
    return render(request, 'admin/video_edit.html', context)

# Delete a video
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def video_delete(request, id):
    if request.method == 'POST':
        try:
            video = get_object_or_404(models.Video, id=id)
            video.delete()
            messages.success(request, "Video deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Video deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})




@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def audio_list(request):
    audios = models.Audio.objects.all().order_by('-created_at')
    paginator = Paginator(audios, 10)  # 10 audio tracks per page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'audios': page_obj,
    }
    return render(request, 'admin/audio_list.html', context)

# Create a new audio track
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def audio_create(request):
    if request.method == 'POST':
        track_name = request.POST.get('title')
        artist_name = request.POST.get('artist')
        status = request.POST.get('status')
        thumbnail = request.FILES.get('thumbnail')
        track_file = request.FILES.get('track_file')

        try:
            audio = models.Audio.objects.create(
                uploaded_by=request.user,
                title=track_name,
                artist=artist_name,
                track_file=track_file,
                thumbnail=thumbnail,
                # duration=5,
                status=status,
            )
            messages.success(request, "Audio track created successfully!")
            return redirect('audio_list')
        except Exception as e:
            messages.error(request, f"Error creating audio track: {str(e)}")
    return render(request, 'admin/audio_create.html')

# Edit an existing audio track
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def audio_edit(request, id):
    audio = get_object_or_404(models.Audio, id=id)
    if request.method == 'POST':
        audio.title = request.POST.get('title')
        audio.artist = request.POST.get('artist')
        audio.duration = request.POST.get('duration')
        audio.status = request.POST.get('status')

        if request.FILES.get('thumbnail'):
            audio.thumbnail = request.FILES['thumbnail']
        if request.FILES.get('track_file'):
            audio.track_file = request.FILES['track_file']
        
        try:
            audio.save()
            messages.success(request, "Audio track updated successfully!")
            return redirect('audio_list')
        except Exception as e:
            messages.error(request, f"Error updating audio track: {str(e)}")
    
    context = {
        'audio': audio,
    }
    return render(request, 'admin/audio_edit.html', context)

# Delete an audio track
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def audio_delete(request, id):
    if request.method == 'POST':
        try:
            audio = get_object_or_404(models.Audio, id=id)
            audio.delete()
            messages.success(request, "Audio track deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Audio track deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})



@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def customer_list(request):
    customers = account_models.Customer.objects.filter(user__user_type='customer').order_by('-create_at')
    paginator = Paginator(customers, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'customers': page_obj,
    }
    return render(request, 'admin/customer_list.html', context)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def customer_create(request):
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        name_parts = name.split()
        first_name = name_parts[0] if len(name_parts) > 0 else ''
        last_name = ' '.join(name_parts[1:]) if len(name_parts) > 1 else ''
        phone_number = request.POST.get('phone_number')
        email = request.POST.get('email')
        password = request.POST.get('password')
        gender = request.POST.get('gender')
        dob = request.POST.get('dob')
        status = request.POST.get('status')
        profile_image = request.FILES.get('profile_image')
        try:
            with transaction.atomic():
                user = User.objects.create_user(username=email,email=email,password=make_password(password),first_name=first_name,last_name=last_name,user_type='customer')
                account_models.Customer.objects.create(user=user,phone_number=phone_number,gender=gender,dob=dob,status=status,profile_image=profile_image)
            messages.success(request, "Customer created successfully!")
            return redirect('customer_list')
        except Exception as e:
            messages.error(request, f"Error creating customer: {str(e)}")
    return render(request, 'admin/customer_create.html')                            


# Edit Customer
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def customer_edit(request, id):
    customer = get_object_or_404(account_models.Customer, id=id)
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        name_parts = name.split()
        first_name = name_parts[0] if len(name_parts) > 0 else ''
        last_name = ' '.join(name_parts[1:]) if len(name_parts) > 1 else ''
        customer.user.first_name = first_name
        customer.user.last_name = last_name
        customer.phone_number = request.POST.get('phone_number')
        customer.gender = request.POST.get('gender')
        customer.dob = request.POST.get('dob')
        customer.status = request.POST.get('status')
        customer.user.email = request.POST.get('email')

        password = request.POST.get('password')

        if password:
            customer.user.password = make_password(password)
        if request.FILES.get('profile_image'):
            customer.profile_image = request.FILES['profile_image']

        try:
            customer.save()
            customer.user.save()
            messages.success(request, "Customer updated successfully!")
            return redirect('customer_list')
        except Exception as e:
            messages.error(request, f"Error updating customer: {str(e)}")

    context = {
        'customer': customer,
    }
    return render(request, 'admin/customer_edit.html', context)


# Delete Customer
@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def customer_delete(request, id):
    if request.method == 'POST':
        try:
            customer = get_object_or_404(account_models.Customer, id=id)
            customer.delete()
            customer.user.delete()
            messages.success(request, "Customer deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Customer deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})


