from django.contrib import admin
from .models import Profile, Organization, CustomUser, UserOrganizationRole, SpecializedServices, Recommendation

@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('name', 'email', 'phone_number')  # Customize as needed
    search_fields = ('name', 'email')

@admin.register(Organization)
class OrganizationAdmin(admin.ModelAdmin):
    list_display = ('name', 'size', 'industry', 'created_at')  # Customize as needed
    search_fields = ('name', 'industry')

@admin.register(CustomUser)
class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'tell_num')  # Customize as needed
    search_fields = ('username', 'email')

@admin.register(UserOrganizationRole)
class UserOrganizationRoleAdmin(admin.ModelAdmin):
    list_display = ('user', 'organization', 'type')  # Customize as needed
    search_fields = ('user__username', 'organization__name')

@admin.register(SpecializedServices)
class SpecializedServicesAdmin(admin.ModelAdmin):
    list_display = ('profile',)  # Customize as needed
    search_fields = ('profile__name',)


@admin.register(Recommendation)
class RecommendationAdmin(admin.ModelAdmin):
    list_display = ('user', 'time', 'recommendation')  # Customize as needed
    search_fields = ('user__username', 'recommendation')  # Adjust based on related fields