from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings

from vdo_api.routers.userRouters import router as userRouter
from vdo_api.routers.videoRouters import videoRouter

from . import views

# Use of an FTP Server is preferable here

urlpatterns = [
    path('', include(userRouter.urls)),
    path('admin/', admin.site.urls),
    path('api/', include(videoRouter.urls)),
    path('.well-known/pki-validation/B0184553A4E9FD077261539D69B80460.txt',
         views.verifySite, name="verifySite"),
    path('.well-known/pki-validation/72670B498D44157B84B95313641C7C5D.txt',
         views.verifySite2, name="verifySite2"),
]


urlpatterns += static(
    "/media/", document_root=settings.MEDIA_ROOT
)

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
