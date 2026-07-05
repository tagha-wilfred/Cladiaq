from django.urls import path
from .views import UserRegistrationView, UserViewSet, ProfileViewSet, OrganizationViewSet, UserOrganizationRoleViewSet, UserLoginView, CreateOrganizationUserView
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'profiles', ProfileViewSet)
router.register(r'organizations', OrganizationViewSet)
router.register(r'user-roles', UserOrganizationRoleViewSet)

urlpatterns = [
    path('login/', UserLoginView.as_view(), name='user-login'),
    path('create-org-user/', CreateOrganizationUserView.as_view(), name='create-org-user'),
    path('register/', UserRegistrationView.as_view(), name='user-register'),

]

urlpatterns += router.urls