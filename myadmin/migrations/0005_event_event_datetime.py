# Generated by Django 4.2.17 on 2024-12-17 05:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myadmin', '0004_aboutus'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='event_datetime',
            field=models.DateTimeField(blank=True, null=True, verbose_name='Event Date and Time'),
        ),
    ]
