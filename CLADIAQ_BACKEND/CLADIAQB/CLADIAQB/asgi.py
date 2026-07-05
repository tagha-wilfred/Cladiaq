# asgi.py

import os
from django.core.asgi import get_asgi_application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from django.urls import path
from DEVICE.consumers import SensorDataConsumer
 # Replace with your app name


os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'CLADIAQB.settings')  # Replace with your project name

application = ProtocolTypeRouter({
    "http": get_asgi_application(),
    "websocket": AuthMiddlewareStack(
        URLRouter(
            [
                path('ws/sensor-data/', SensorDataConsumer.as_asgi()),
            ]
        )
    ),
})