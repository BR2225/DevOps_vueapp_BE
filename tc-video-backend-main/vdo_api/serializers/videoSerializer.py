from rest_framework import serializers
from streaming_backend.utils import getModel


class VideoReadOnlySerializer(serializers.ModelSerializer):
    class Meta:
        model = getModel("vdo_api.Video")
        fields = "__all__"

    def save(self, **kwargs):
        return super().save(**kwargs)


class VideoReadOnlyHyperlinkedSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = getModel("vdo_api.Video")
        fields = [
            "id",
            "url",
            "user",
            "title",
            "description",
            "thumbnail",
            "video",
            "subtitle",
            "subtitle_file",
            "created_at",
            "updated_at",
            "likes",
            "views",
        ]
