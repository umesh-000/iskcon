from django.shortcuts import redirect, render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.views.decorators.cache import cache_control
from django.contrib.auth import get_user_model
from django.core.paginator import Paginator
from django.http import JsonResponse
from django.contrib import messages
from myadmin import models
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
    pass

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
        description = request.POST.get('description')
        status = request.POST.get('status')
        try:
            models.Notification.objects.create(title=title,description=description,status=status,)
            messages.success(request, "Notification created successfully!")
            return redirect('notifications')
        except Exception as e:
            messages.error(request, f"Error creating notification: {str(e)}")
    return render(request, 'admin/notification_create.html')