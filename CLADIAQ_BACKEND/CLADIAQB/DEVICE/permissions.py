from rest_framework.permissions import BasePermission

class IsUserOrESP32(BasePermission):
    def has_permission(self, request, view):
        print(request.user)
        print(request.headers)
        # Allow read-only access to authenticated users
        # if request.method in ['GET']:
        #     return request.user and request.user.is_authenticated
        # Allow all requests for writing (like POST) to ESP32 or any client
        return True