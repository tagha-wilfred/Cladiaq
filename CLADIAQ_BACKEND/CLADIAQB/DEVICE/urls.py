# devices/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import DeviceViewSet, SensorDataViewSet, analytics

router = DefaultRouter()
router.register(r'devices', DeviceViewSet)
router.register(r'sensor-data', SensorDataViewSet)

urlpatterns = [
    path('', include(router.urls)),      
    path('get_analytics/', analytics)
]