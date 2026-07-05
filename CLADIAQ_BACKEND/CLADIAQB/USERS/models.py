from django.contrib.auth.models import AbstractUser
from django.db import models

class Profile(models.Model):
    name = models.CharField(max_length=255)
    address = models.CharField(max_length=255, null=True)
    phone_number = models.CharField(max_length=255, null=True)
    email = models.CharField(max_length=255)
    picture = models.ImageField(upload_to='profile_pics/', blank=True, null=True)
    
    def __str__(self):
        return self.name

class Organization(models.Model):
    SIZE = (
        ('home', 'Home'),
        ('Sm Ent', 'Small Enterprice'),
        ('Lg Ent', 'Large Enterprice')
    )
    name = models.CharField(max_length=25)
    profile = models.ForeignKey(Profile, null=True, on_delete = models.SET_NULL )
    size = models.CharField(max_length=30, choices=SIZE, null=True)
    industry = models.CharField(max_length=255, null=True)
    verified = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class CustomUser(AbstractUser):
    # Add any additional fields you want here
    address = models.TextField(blank=True, null=True)
    tell_num = models.TextField(blank=True, null=True)
    profile = models.ForeignKey(Profile, on_delete=models.SET_NULL, null=True)
    

    def __str__(self):
        return self.username
    
class UserOrganizationRole(models.Model):
    USER_TYPE_CHOICES = (
        ('admin', 'Admin'),
        ('org_user', 'Organization User')
    )
    
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    organization = models.ForeignKey(Organization, on_delete=models.CASCADE)
    type = models.CharField(max_length=10, choices=USER_TYPE_CHOICES)

    class Meta:
        unique_together = ('user', 'organization')

class SpecializedServices(models.Model):
    profile= models.ForeignKey(Profile, on_delete=models.CASCADE)

    def __str__(self):
        return self.profile.name
    

class Recommendation(models.Model):
    recommendation = models.TextField()
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, null=True)
    
    time = models.DateTimeField(auto_now=True)