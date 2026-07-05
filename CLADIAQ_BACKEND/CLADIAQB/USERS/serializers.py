# users/serializers.py
from rest_framework import serializers
from .models import CustomUser, Profile, Organization, UserOrganizationRole
from django.contrib.auth import authenticate


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ['id', 'name', 'address', 'phone_number', 'email', 'picture']

class OrganizationSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer()
    class Meta:
        model = Organization
        fields = ['id', 'name', 'profile', 'size', 'industry', 'verified', 'created_at']

class UserSerializer(serializers.ModelSerializer):
    profile = ProfileSerializer()
    organizations = OrganizationSerializer(many=True, read_only=True)

    class Meta:
        model = CustomUser
        fields = ['id', 'username',  'profile', 'organizations']

class UserOrganizationRoleSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    organization = OrganizationSerializer()

    class Meta:
        model = UserOrganizationRole
        fields = ['id', 'user', 'organization', 'type']

class OrganizationUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['username', 'password', 'email', 'address', 'tell_num']

    def create(self, validated_data):
        # Extract organization information from the context if needed
        organization = self.context['organization']

        user = CustomUser(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        # Create the user-organization relationship with the 'org_user' role
        UserOrganizationRole.objects.create(
            user=user,
            organization=organization,
            type='org_user'
        )

        return user
    
class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, attrs):
        username = attrs.get('username')
        password = attrs.get('password')

        user = authenticate(username=username, password=password)
        if user is None:
            raise serializers.ValidationError("Invalid username or password.")
        
        attrs['user'] = user
        return attrs

class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = CustomUser
        fields = ['username','email', 'password', 'address', 'tell_num']

    def create(self, validated_data):
        # Create the user
        user = CustomUser(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        # Create the profile
        profile = Profile.objects.create(
            name=validated_data['username'],  # or any logic to set the name
            email=validated_data['email'],
            address=validated_data.get('address'),
            phone_number=validated_data.get('tell_num'),
        )
        user.profile = profile
        user.save()

        # Create the organization
        organization = Organization.objects.create(
            name=profile.name,
            profile=profile,
            verified=False  # Initially unverified
        )

        # Assign the admin role to the user
        UserOrganizationRole.objects.create(
            user=user,
            organization=organization,
            type='admin'
        )

        return user