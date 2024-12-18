from django.shortcuts import redirect, render, get_object_or_404
from django.core.files.uploadedfile import TemporaryUploadedFile
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import cache_control
from django.contrib.auth.hashers import make_password
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.hashers import check_password
from django.contrib.auth import get_user_model
from accounts import models as account_models
from django.core.paginator import Paginator
from django.http import JsonResponse
from django.contrib import messages
from django.db import transaction
from mutagen.mp3 import MP3
from mutagen.wave import WAVE
from myadmin import models
import datetime
import logging
import os



# Set up logging
logger = logging.getLogger(__name__)

User = get_user_model()

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def admin_dashboard(request):
    if not request.user.is_authenticated:
        return redirect('admin_login')
    
    # Dashboard data aggregations
    all_users = account_models.User.objects.count()
    total_customers = account_models.Customer.objects.count()
    total_blog_categories = models.BlogCategory.objects.count()
    total_blogs = models.Blog.objects.count()
    total_books = models.Book.objects.count()
    total_videos = models.Video.objects.count()
    total_events = models.Event.objects.count()
    total_audios = models.Audio.objects.count()
    total_galleries = models.Gallery.objects.count()
    context = {
        'admin_user': request.user,
        'all_users' : all_users,
        'total_customers': total_customers,
        'total_blog_categories': total_blog_categories,
        'total_blogs':total_blogs,
        'total_books':total_books,
        'total_videos':total_videos,
        'total_events':total_events,
        'total_audios':total_audios,
        'total_galleries' : total_galleries,
    }
    return render(request, 'admin/dashboard.html', context)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def admin_profile_details(request, id):
    admin_profile = get_object_or_404(account_models.Admins, user_id=id)
    if not request.user.is_authenticated:
        return redirect('admin_login')
    
    if request.method == "POST":
        profile_image = request.FILES.get('profile_image')
        if profile_image:
            admin_profile.profile_image = profile_image
            admin_profile.save()
            messages.success(request, "Profile Image Updated!")

    context = {
        'admin_user': request.user,
        'admin_profile': admin_profile,
    }
    return render(request, 'admin/admin_profile.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
def admin_change_password(request, id):
    if not request.user.is_authenticated:
        return redirect('admin_login')
    admin_profile = get_object_or_404(account_models.Admins, id=id)
    if request.method == 'POST':
        current_password = request.POST.get('current_password')
        new_password = request.POST.get('new_password')
        confirm_new_password = request.POST.get('confirm_new_password')
        user = admin_profile.user
        if not check_password(current_password, user.password):
            messages.error(request, 'Current password is incorrect.')
            return redirect('admin_profile_details', id=id)
        if new_password != confirm_new_password:
            messages.error(request, 'New password and confirmation do not match.')
            return redirect('admin_profile_details', id=id)
        user.set_password(new_password)
        user.save()
        update_session_auth_hash(request, user)
        messages.success(request, 'Password updated successfully.')
        return redirect('admin_profile_details', id=id)
    context = {
        'admin_user': request.user,
        'admin_profile': admin_profile,
    }
    return render(request, 'admin/admin_profile.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_categories_list(request):
    categories = models.BlogCategory.objects.all().order_by('-created_at')
    paginator = Paginator(categories, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'admin_user': request.user,
        'categories': page_obj,
    }
    return render(request, 'admin/blog_categories_list.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_categories_create(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        description = request.POST.get('description')
        is_active = request.POST.get('is_active') == 'on'
        try:
            models.BlogCategory.objects.create( name=name, description=description, is_active=is_active, )
            messages.success(request, "Blog category created successfully!")
            return redirect('blog_categories_list')
        except Exception as e:
            messages.error(request, f"Error creating category: {str(e)}")
    context = {
        'admin_user': request.user,
    }
    return render(request, 'admin/blog_categories_create.html',context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_categories_edit(request, id):
    category = get_object_or_404(models.BlogCategory, id=id)
    if request.method == 'POST':
        category.name = request.POST.get('name')
        category.description = request.POST.get('description')
        category.is_active = request.POST.get('is_active') == 'on'
        
        try:
            category.save()
            messages.success(request, "Blog category updated successfully!")
            return redirect('blog_categories_list')
        except Exception as e:
            messages.error(request, f"Error updating category: {str(e)}")
    
    context = {
        'admin_user': request.user,
        'category': category,
    }
    return render(request, 'admin/blog_categories_edit.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_categories_delete(request, id):
    if request.method == 'POST':
        try:
            category = get_object_or_404(models.BlogCategory, id=id)
            category.delete()
            messages.success(request, "Blog category deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Category deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_list(request):
    blogs = models.Blog.objects.all().order_by('-created_at')
    paginator = Paginator(blogs, 10)  # 10 blogs per page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    context = {
        'admin_user': request.user,
        'blogs': page_obj,
    }
    return render(request, 'admin/blog_list.html', context)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_create(request):
    blog_categories = models.BlogCategory.objects.filter(is_active=True)
    if request.method == 'POST':
        title = request.POST.get('title')
        category_id = request.POST.get('category_id')
        subtitle = request.POST.get('subtitle')
        description = request.POST.get('description')
        status = request.POST.get('status')
        image = request.FILES.get('image')
        category = get_object_or_404(models.BlogCategory, id=category_id)
        try:
            blog = models.Blog.objects.create(
                added_by=request.user,
                title=title,
                category = category,
                subtitle=subtitle,
                description=description,
                status=status,
                image=image,
            )
            messages.success(request, "Blog created successfully!")
            return redirect('blog_list')
        except Exception as e:
            messages.error(request, f"Error creating blog: {str(e)}")
    context = {   
        'admin_user': request.user,
        "blog_categories":blog_categories,
    }
    return render(request, 'admin/blog_create.html',context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def blog_edit(request, id):
    blog_categories = models.BlogCategory.objects.filter(is_active=True)
    blog = get_object_or_404(models.Blog, id=id)
    if request.method == 'POST':
        blog.title = request.POST.get('title')
        blog.subtitle = request.POST.get('subtitle')
        blog.description = request.POST.get('description')
        blog.status = request.POST.get('status')
        category_id = request.POST.get('category_id')
        print(category_id)
        if category_id:
            category = get_object_or_404(models.BlogCategory, id=category_id)
            blog.category = category
        if request.FILES.get('image'):
            blog.image = request.FILES['image']
        try:
            blog.save()
            messages.success(request, "Blog updated successfully!")
            return redirect('blog_list')
        except Exception as e:
            messages.error(request, f"Error updating blog: {str(e)}")
    context = {
        'admin_user': request.user,
        'blog': blog,
        "blog_categories":blog_categories,
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
        'admin_user': request.user,
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
    context = {
        'admin_user': request.user,
    }
    return render(request, 'admin/book_create.html', context)


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
        'admin_user': request.user,
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
        'admin_user': request.user,
        'events': page_obj,
    }
    return render(request, 'admin/event_list.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def event_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        address = request.POST.get('address')
        description = request.POST.get('description')
        venue = request.POST.get('venue')
        event_datetime = request.POST.get('event_datetime')
        status = request.POST.get('status')
        event_image = request.FILES.get('event_image')

        try:
            models.Event.objects.create(
                title=title,
                image=event_image,
                description=description,
                address = address,
                event_datetime=event_datetime,
                venue=venue,
                status=status,
            )
            messages.success(request, "Event created successfully!")
            return redirect('event_list')
        except Exception as e:
            messages.error(request, f"Error creating event: {str(e)}")
    context = {'admin_user': request.user,}
    return render(request, 'admin/event_create.html',context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def event_edit(request, id):
    event = get_object_or_404(models.Event, id=id)
    if request.method == 'POST':
        event.title = request.POST.get('title')
        event.description = request.POST.get('description')
        event.address = request.POST.get('address')
        event.venue = request.POST.get('venue')
        event.event_datetime = request.POST.get('event_datetime')
        event.status = request.POST.get('status')
        if request.FILES.get('image'):
            event.image = request.FILES.get('image')
        try:
            event.save()
            messages.success(request, "Event updated successfully!")
            return redirect('event_list')
        except Exception as e:
            messages.error(request, f"Error updating event: {str(e)}")
    context = {'event': event,'admin_user': request.user,}
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
    about_us = models.AboutUs.objects.first()

    if request.method == 'POST':
        title = request.POST.get('title')
        content = request.POST.get('content')
        is_active = request.POST.get('is_active', 'off') == 'on'
        thumbnail = request.FILES.get('thumbnail')
        try:
            if about_us:
                about_us.title = title
                about_us.content = content
                about_us.is_active = is_active
                if thumbnail:
                    about_us.image = thumbnail
                else:
                    pass
                about_us.save()
                messages.success(request, 'About Us updated successfully.')
            else:
                if thumbnail:
                    models.AboutUs.objects.create(title=title,content=content,is_active=is_active,image=thumbnail)
                else:
                    models.AboutUs.objects.create(title=title,content=content,is_active=is_active,image=None)
                messages.success(request, 'About Us created successfully.')
            return redirect('about_us')
        except Exception as e:
            messages.error(request, f'Error saving About Us: {str(e)}')
            return redirect('about_us')
    context = {
        'admin_user': request.user,
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
        'admin_user': request.user,
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
        'admin_user': request.user,
        'terms_and_conditions': terms_and_conditions,
    }
    return render(request, 'admin/terms_and_conditions.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def notifications(request):
    notifications_list = models.Notification.objects.filter(is_active=True).order_by('-created_at')
    return render(request, 'admin/notifications_list.html', {'notifications': notifications_list,'admin_user': request.user,})

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def notification_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        target_audience = request.POST.get('target_audience')
        message = request.POST.get('message')
        is_active = request.POST.get('is_active', 'off') == 'on'
        image = request.FILES.get('notification_image')
        try:
            models.Notification.objects.create(title=title, target_audience=target_audience, message=message, image=image, is_active=is_active,)
            messages.success(request, "Notification created successfully!")
            return redirect('notifications')
        except Exception as e:
            messages.error(request, f"Error creating notification: {str(e)}")
    context = {
        'admin_user': request.user,
    }
    return render(request, 'admin/notification_create.html',context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def notification_delete(request, id):
    if request.method == 'POST':
        try:
            notification = get_object_or_404(models.Notification, id=id)
            notification.delete()
            messages.success(request, "Notification Delete successfully!")
            return JsonResponse({'success': True, 'message': 'Notification deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})

# video

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def video_list(request):
    videos = models.Video.objects.all().order_by('-created_at')
    paginator = Paginator(videos, 10)  # 10 videos per page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'admin_user': request.user,
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
    context = {
        'admin_user': request.user,
    }
    return render(request, 'admin/video_create.html',context)

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
        'admin_user': request.user,
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
        'admin_user': request.user,
        'audios': page_obj,
    }
    return render(request, 'admin/audio_list.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def audio_create(request):
    if request.method == 'POST':
        track_name = request.POST.get('title')
        artist_name = request.POST.get('artist')
        status = request.POST.get('status')
        thumbnail = request.FILES.get('thumbnail')
        track_file = request.FILES.get('track_file')
        duration_seconds = 0
        try:
            if track_file:
                temp_file_path = track_file.temporary_file_path() if isinstance(track_file, TemporaryUploadedFile) else None
                if track_file.name.lower().endswith('.mp3'):
                    audio_data = MP3(track_file if not temp_file_path else temp_file_path)
                    duration_seconds = round(audio_data.info.length)
                elif track_file.name.lower().endswith('.wav'):
                    audio_data = WAVE(track_file if not temp_file_path else temp_file_path)
                    duration_seconds = round(audio_data.info.length)
                else:
                    messages.error(request, "Unsupported audio format. Only MP3 and WAV are supported.")
                    return redirect('audio_create')
            duration_minutes = round(duration_seconds / 60, 2)
            audio = models.Audio.objects.create(
                uploaded_by=request.user, title=track_name, artist=artist_name, track_file=track_file, 
                thumbnail=thumbnail, duration=duration_seconds,  status=status, )
            messages.success(request, "Audio track created successfully!")
            return redirect('audio_list')
        except Exception as e:
            messages.error(request, f"Error creating audio track: {str(e)}")
    context = {
        'admin_user': request.user,
    }
    return render(request, 'admin/audio_create.html')




@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def audio_edit(request, id):
    audio = get_object_or_404(models.Audio, id=id)
    if request.method == 'POST':
        audio.title = request.POST.get('title')
        audio.artist = request.POST.get('artist')
        audio.status = request.POST.get('status')
        if request.FILES.get('thumbnail'):
            audio.thumbnail = request.FILES['thumbnail']
        if request.FILES.get('track_file'):
            track_file = request.FILES['track_file']
            duration_seconds = 0
            try:
                temp_file_path = track_file.temporary_file_path() if isinstance(track_file, TemporaryUploadedFile) else None
                if track_file.name.lower().endswith('.mp3'):
                    audio_data = MP3(track_file if not temp_file_path else temp_file_path)
                    duration_seconds = round(audio_data.info.length)
                elif track_file.name.lower().endswith('.wav'):
                    audio_data = WAVE(track_file if not temp_file_path else temp_file_path)
                    duration_seconds = round(audio_data.info.length)
                else:
                    messages.error(request, "Unsupported audio format. Only MP3 and WAV are supported.")
                    return redirect('audio_edit', id=id)
                audio.track_file = track_file
                audio.duration = duration_seconds
                print(f"New duration: {duration_seconds} seconds")
            except Exception as e:
                messages.error(request, f"Error processing track file: {str(e)}")
                return redirect('audio_edit', id=id)
        try:
            audio.save()
            messages.success(request, "Audio track updated successfully!")
            return redirect('audio_list')
        except Exception as e:
            messages.error(request, f"Error updating audio track: {str(e)}")
    context = { 'audio': audio, 'admin_user': request.user,}
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
        'admin_user': request.user,
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
    context = {
        'admin_user': request.user,
    }
    return render(request, 'admin/customer_create.html')                            


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def customer_edit(request, id):
    customer = get_object_or_404(account_models.Customer, id=id)
    if request.method == 'POST':
        name = request.POST.get('name', '').strip()
        name_parts = name.split()
        first_name = name_parts[0] if len(name_parts) > 0 else ''
        last_name = ' '.join(name_parts[1:]) if len(name_parts) > 1 else ''

        # Fetch related user instance
        user = customer.user  
        user.first_name = first_name
        user.last_name = last_name
        user.email = request.POST.get('email')
        user.username = request.POST.get('email')

        password = request.POST.get('password')
        if password:
            user.password = make_password(password)

        # Update customer fields
        customer.phone_number = request.POST.get('phone_number')
        customer.gender = request.POST.get('gender')
        customer.dob = request.POST.get('dob')
        customer.status = request.POST.get('status')

        if request.FILES.get('profile_image'):
            customer.profile_image = request.FILES['profile_image']

        try:
            # Save both user and customer instances
            user.save()
            customer.save()
            messages.success(request, "Customer updated successfully!")
            return redirect('customer_list')
        except Exception as e:
            messages.error(request, f"Error updating customer: {str(e)}")

    context = {
        'admin_user': request.user,
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


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def gallery_list(request):
    galleries = models.Gallery.objects.prefetch_related('images').all()
    paginator = Paginator(galleries, 10)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)  
    context = {
        'admin_user': request.user,
        'galleries': page_obj,
    }
    return render(request, 'admin/gallery_list.html', context)

@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def gallery_create(request):
    if request.method == 'POST':
        title = request.POST.get('title', '').strip()
        images = request.FILES.getlist('images') 
        try:
            with transaction.atomic():
                gallery = models.Gallery.objects.create(title=title)
                for image in images:
                    models.GalleryImage.objects.create(gallery=gallery, image=image)
            messages.success(request, "Gallery created successfully!")
            return redirect('gallery_list')
        except Exception as e:
            messages.error(request, f"Error creating gallery: {str(e)}")
    context = { 'admin_user': request.user, }
    return render(request, 'admin/gallery_create.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def gallery_edit(request, id):
    gallery = get_object_or_404(models.Gallery, id=id)
    if request.method == 'POST':
        title = request.POST.get('title', '').strip()
        images = request.FILES.getlist('images')
        remove_images = request.POST.getlist('remove_images')
        try:
            with transaction.atomic():
                gallery.title = title
                gallery.save()
                for image in images:
                    models.GalleryImage.objects.create(gallery=gallery, image=image)
                for image_id in remove_images:
                    try:
                        image = models.GalleryImage.objects.get(id=image_id)
                        image.delete()
                    except models.GalleryImage.DoesNotExist:
                        print("model not found")
            messages.success(request, "Gallery updated successfully!")
            return redirect('gallery_list')
        except Exception as e:
            messages.error(request, f"Error updating gallery: {str(e)}")
    context = {
        'admin_user': request.user,
        'gallery': gallery,
    }
    return render(request, 'admin/gallery_edit.html', context)


@cache_control(no_cache=True, must_revalidate=True, no_store=True)
@login_required
def gallery_delete(request, id):
    if request.method == 'POST':
        try:
            gallery = get_object_or_404(models.Gallery, id=id)
            gallery.images.all().delete()
            gallery.delete()
            messages.success(request, "Gallery deleted successfully!")
            return JsonResponse({'success': True, 'message': 'Gallery deleted successfully!'})
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)})
    return JsonResponse({'success': False, 'message': 'Invalid request method.'})