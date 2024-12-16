from django.db import models
from django.utils.timezone import now
from django.conf import settings


STATUS_CHOICES = [ (1, 'Active'), (0, 'Inactive'), ]
TARGET_AUDIENCE_CHOICES = [('admin', 'Admin'),('customer', 'Customer'),('all', 'All Users'),]

class Blog(models.Model):
    added_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, related_name='blogs', verbose_name="Added By")
    title = models.CharField(max_length=255, verbose_name="Title")
    subtitle = models.CharField(max_length=255, blank=True, null=True, verbose_name="Subtitle")
    image = models.ImageField(upload_to='blogs/images/', blank=True, null=True, verbose_name="Featured Image")
    description = models.TextField(verbose_name="Description")
    status = models.IntegerField(choices=STATUS_CHOICES, default=0, verbose_name="Status")
    created_at = models.DateTimeField (auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'blogs'
        verbose_name = 'Blog'
        verbose_name_plural = 'Blogs'
    def __str__(self):
        return self.title
    

class Book(models.Model):
    STATUS_CHOICES = [ (1, 'Published'), (0, 'Unpublished'), ]
    title = models.CharField(max_length=255, verbose_name="Book Title")
    author_name = models.CharField(max_length=255, verbose_name="Author Name")
    cover_image = models.ImageField(upload_to='books/covers/', blank=True, null=True, verbose_name="Cover Image")
    status = models.IntegerField(choices=STATUS_CHOICES, default=0, verbose_name="Status")
    book_file = models.FileField(upload_to='books/files/', verbose_name="Book File (PDF)")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Created At")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Updated At")
    class Meta:
        db_table = 'books'
        verbose_name = 'Book'
        verbose_name_plural = 'Books'
    def __str__(self):
        return self.title
    

class Event(models.Model):
    STATUS_CHOICES = [ (1, 'Published'), (0, 'Unpublished'), ]
    title = models.CharField(max_length=255, verbose_name="Event Title")
    image = models.ImageField(upload_to='events/', blank=True, null=True, verbose_name="event Image")
    description = models.TextField(verbose_name="Description")
    venue = models.CharField(max_length=255, verbose_name="Venue", blank=True)
    status = models.IntegerField(choices=STATUS_CHOICES, default=0, verbose_name="Status")
    created_at = models.DateTimeField (auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'myadmin_event'
        verbose_name = "Event"
        verbose_name_plural = "Events"
        ordering = ['-created_at']
    def __str__(self):
        return self.title
    

class AboutUs(models.Model):
    title = models.CharField(max_length=255, default="About Us")
    content = models.TextField()
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'about_us'
    
    def __str__(self):
        return f"{self.title}"
    

    
class PrivacyPolicy(models.Model):
    title = models.CharField(max_length=255, default="Privacy Policy")
    content = models.TextField()
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'privacy_policies'
    def __str__(self):
        return f"{self.title}"
    

class TermsAndConditions(models.Model):
    title = models.CharField(max_length=255, default="Terms and Conditions")
    content = models.TextField()
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'terms_and_conditions'
    def __str__(self):
        return f"{self.title}"



class Notification(models.Model):
    title = models.CharField(max_length=255, verbose_name="Notification Title", blank=True, null=True)
    message = models.TextField(verbose_name="Message", blank=True, null=True)
    target_audience = models.CharField(max_length=20, choices=TARGET_AUDIENCE_CHOICES, blank=True, null=True, verbose_name="Target Audience")
    image = models.ImageField(upload_to='notifications/', blank=True, null=True)
    is_active = models.BooleanField(default=True, verbose_name="Is Active")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'notifications'
        verbose_name = "Notification"
        verbose_name_plural = "Notifications"
        ordering = ['-created_at']
    def __str__(self):
        return self.title
    

class Video(models.Model):
    title = models.CharField(max_length=255, verbose_name="Video Title")
    author = models.CharField(max_length=255, verbose_name="Author/Speaker Name", blank=True, null=True)
    description = models.TextField(blank=True, null=True, verbose_name="Video Description")
    thumbnail = models.ImageField(upload_to='videos/thumbnails/', verbose_name="Video Thumbnail", blank=True, null=True)
    video_file = models.FileField(upload_to='videos/', verbose_name="Upload Video")
    video_url = models.URLField(verbose_name="Video URL", blank=True, null=True)
    uploaded_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='uploaded_videos')
    status = models.IntegerField(choices=STATUS_CHOICES, default=1, verbose_name="Status")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Created At")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Last Updated At")
    class Meta:
        db_table = 'videos'
        verbose_name = "Video"
        verbose_name_plural = "Videos"
        ordering = ['-created_at']
    def __str__(self):
        return self.title
    
    
    


class Audio(models.Model):
    title = models.CharField(max_length=255, verbose_name="Track Name")
    artist = models.CharField(max_length=255, verbose_name="Artist Name", blank=True, null=True)
    duration = models.DurationField(verbose_name="Track Duration", blank=True, null=True)
    thumbnail = models.ImageField(upload_to='audio/thumbnails/', verbose_name="Track Thumbnail", blank=True, null=True)
    track_file = models.FileField(upload_to='audio/tracks/', verbose_name="Upload Track File")
    uploaded_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='uploaded_audio')
    status = models.IntegerField(choices=[(1, 'Published'), (0, 'Unpublished')], default=1, verbose_name="Status")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Created At")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Last Updated At")
    class Meta:
        db_table = 'audio_tracks'
        verbose_name = "Audio Track"
        verbose_name_plural = "Audio Tracks"
        ordering = ['-created_at']
    def __str__(self):
        return self.title

