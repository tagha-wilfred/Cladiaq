from rest_framework import viewsets, permissions, generics, status
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.decorators import action
from django.contrib.auth import authenticate
from .models import CustomUser, Profile, Organization, UserOrganizationRole
from .serializers import UserRegistrationSerializer, UserLoginSerializer, UserSerializer, ProfileSerializer, OrganizationSerializer, UserOrganizationRoleSerializer, OrganizationUserSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = CustomUser.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=False, methods=['get'], permission_classes=[permissions.IsAuthenticated])
    def me(self, request):
        # Get the current authenticated user from the request
        user = request.user
        # Serialize the user object
        serializer = self.get_serializer(user)
        return Response(serializer.data)  # Only authenticated users can view

class ProfileViewSet(viewsets.ModelViewSet):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [permissions.AllowAny]  # Only authenticated users can view

class OrganizationViewSet(viewsets.ModelViewSet):
    queryset = Organization.objects.all()
    serializer_class = OrganizationSerializer
    #isadminuser
    permission_classes = [permissions.AllowAny]  # Only admins can view

class UserOrganizationRoleViewSet(viewsets.ModelViewSet):
    queryset = UserOrganizationRole.objects.all()
    serializer_class = UserOrganizationRoleSerializer
    permission_classes = [permissions.AllowAny]  # Only authenticated users can view

class UserLoginView(generics.GenericAPIView):
    serializer_class = UserLoginSerializer
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')

        user = authenticate(username=username, password=password)
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            return Response({'token': token.key, 'user': user.id,
            'username': user.username,
            'email': user.email,}, status=200)
        return Response({'error': 'Invalid Credentials'}, status=400)

class CreateOrganizationUserView(generics.CreateAPIView):
    serializer_class = OrganizationUserSerializer
    permission_classes = [permissions.AllowAny]

    def perform_create(self, serializer):
        user = self.request.user
        user_roles = UserOrganizationRole.objects.filter(user=user)
        if user_roles.exists():
            organization = user_roles.first().organization  # Get the first organization
        else:
            raise NotFound("User does not have an associated organization.")  # Handle the case where the user has no organization role        
        serializer.save(organization=organization)

class UserRegistrationView(generics.CreateAPIView):
    serializer_class = UserRegistrationSerializer
    permission_classes = [permissions.AllowAny]

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()

        return Response({
            'id': user.id,
            'lusername': user.username,
            'email': user.email,
            'message': 'User registered successfully.'
        }, status=status.HTTP_201_CREATED)