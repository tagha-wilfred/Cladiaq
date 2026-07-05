from django.urls import path, include
from django.contrib import admin
from rest_framework import permissions


# schema_view = get_schema_view(
#     openapi.Info(
#         title="CLADIAQ",
#         default_version='v1',
#         description="API documentation for your CLADIAQ",
#         terms_of_service="https://www.google.com/policies/terms/",
#         contact=openapi.Contact(email="daytabrown@gmail.com"),
#         license=openapi.License(name="BSD License"),
#     ),
#     public=True,
#     permission_classes=(permissions.AllowAny,),
# )

urlpatterns = [
    # path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    # path('', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    path('admin/', admin.site.urls),
    path('api/', include('USERS.urls')),
    path('apid/', include('DEVICE.urls')),  # Your existing API routes
]