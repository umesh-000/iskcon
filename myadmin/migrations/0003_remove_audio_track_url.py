# Generated by Django 4.2.16 on 2024-12-12 05:55

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('myadmin', '0002_audio'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='audio',
            name='track_url',
        ),
    ]