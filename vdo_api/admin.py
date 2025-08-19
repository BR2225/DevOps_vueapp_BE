from django.contrib import admin
from vdo_api.models import Video


@admin.register(Video)
class ProductReviewAdmin(admin.ModelAdmin):
    list_display = ("title", "video")
