from typing import Iterable, Optional
from django.conf import settings
from django.db import models
from django.contrib.auth.models import User
import uuid


class Video(models.Model):
    class VideoManager(models.Manager):
        class VideoQuerySet(models.QuerySet):
            def user_search(self, user):
                if user:
                    return self.filter(user__username__in=user)
                return self

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    title = models.CharField(max_length=500)
    description = models.TextField(null=True, blank=True)
    thumbnail = models.ImageField(
        upload_to="thumbnails/upload/", null=True, blank=True)
    video = models.FileField(upload_to="videos/upload/")
    subtitle = models.TextField(null=True, blank=True)
    subtitle_file = models.FileField(
        upload_to="subtitles/upload/", null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    likes = models.BigIntegerField(default=0)
    views = models.BigIntegerField(default=0)

    # We can use these as additional features in a more production like settings
    # tags = models.ManyToManyField('Tags')
    # comments = models.ManyToManyField('Comments')

    def save(self, *args, **kwargs):
        # name = 'subtitle_vtt_' + str(uuid.uuid1()) + '.vtt'
        # name = self.generate_contract()
        # name = str(name).replace("\\", "/")
        # print(name)
        # with open(name, 'w') as vttfile:
        #     file = vttfile.writelines(self.subtitle)
        #     print(file)
        filename = settings.MEDIA_ROOT + 'test.vtt'
        f = open(filename, "w")
        f.write(self.subtitle)
        f.close()

        name = str(filename).replace("\\", "/")

        with open(name, 'r') as filevtt:
            print(filevtt.readline())
            self.subtitle_file.save("subtitle.vtt", filevtt, save=False)

        return super(Video, self).save()

    # @staticmethod
    # def generate_contract(self, *args, **kwargs):
    #     filename = settings.MEDIA_ROOT + 'test.vtt'
    #     f = open(filename, "w")
    #     f.write(self.subtitle)
    #     f.close()
    #     return filename
