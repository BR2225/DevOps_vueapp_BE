from rest_framework.routers import DefaultRouter
from vdo_api.views.videoViews import VideoViewSet

videoRouter = DefaultRouter()
videoRouter.register(r'videos', VideoViewSet)