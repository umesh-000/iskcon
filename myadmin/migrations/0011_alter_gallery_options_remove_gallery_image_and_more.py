# Generated by Django 4.2.17 on 2024-12-18 09:20

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('myadmin', '0010_gallery'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='gallery',
            options={'ordering': ['-created_at'], 'verbose_name': 'Gallery Album', 'verbose_name_plural': 'Gallery Albums'},
        ),
        migrations.RemoveField(
            model_name='gallery',
            name='image',
        ),
        migrations.RemoveField(
            model_name='gallery',
            name='uploaded_at',
        ),
        migrations.AddField(
            model_name='gallery',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now, verbose_name='Created At'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='gallery',
            name='title',
            field=models.CharField(default=None, max_length=255, verbose_name='Gallery Title'),
            preserve_default=False,
        ),
        migrations.AlterModelTable(
            name='gallery',
            table='gallery_albums',
        ),
        migrations.CreateModel(
            name='GalleryImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='gallery/images/', verbose_name='Upload Image')),
                ('uploaded_at', models.DateTimeField(auto_now_add=True, verbose_name='Uploaded At')),
                ('gallery', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='myadmin.gallery', verbose_name='Gallery')),
            ],
            options={
                'verbose_name': 'Gallery Image',
                'verbose_name_plural': 'Gallery Images',
                'db_table': 'gallery_images',
                'ordering': ['-uploaded_at'],
            },
        ),
    ]