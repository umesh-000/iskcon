# Generated by Django 4.2.16 on 2024-12-05 07:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myadmin', '0002_book'),
    ]

    operations = [
        migrations.CreateModel(
            name='Event',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=255, verbose_name='Event Title')),
                ('date_time', models.DateTimeField(verbose_name='Date and Time')),
                ('description', models.TextField(blank=True, verbose_name='Description')),
                ('venue', models.CharField(blank=True, max_length=255, verbose_name='Venue')),
                ('status', models.CharField(choices=[('published', 'Published'), ('unpublished', 'Unpublished')], default='unpublished', max_length=20, verbose_name='Status')),
                ('created_at', models.DateTimeField(auto_now_add=True, verbose_name='Created At')),
                ('updated_at', models.DateTimeField(auto_now=True, verbose_name='Updated At')),
            ],
            options={
                'verbose_name': 'Event',
                'verbose_name_plural': 'Events',
                'ordering': ['-date_time'],
            },
        ),
    ]