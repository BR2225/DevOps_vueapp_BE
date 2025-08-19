from rest_framework.routers import DefaultRouter
from vdo_api.views.userViews import UserViewSet, GroupViewSet

router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'groups', GroupViewSet)