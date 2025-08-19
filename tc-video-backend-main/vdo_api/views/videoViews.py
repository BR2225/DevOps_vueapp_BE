from rest_framework import viewsets
from rest_framework import permissions
from vdo_api.serializers.videoSerializer import VideoReadOnlyHyperlinkedSerializer
from streaming_backend.utils import getModel


class VideoViewSet(viewsets.ModelViewSet):
    model = getModel("vdo_api.Video")
    queryset = model.objects.all().order_by('-created_at')
    serializer_class = VideoReadOnlyHyperlinkedSerializer
    # permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    # video get views
    # Add a method to update the Views and other parameters for every api get req call
