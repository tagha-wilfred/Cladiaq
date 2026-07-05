from django.db import models
from django.utils import timezone
from USERS.models import CustomUser
from DEVICE.models import Device

class ControlLog(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    device= models.ForeignKey(Device, on_delete=models.CASCADE)
    create_time = models.DateTimeField(default=timezone.now)  # Set default to current datetime
    update_time = models.DateTimeField(auto_now=True)  # Automatically update to current datetime on save
    status = models.CharField(max_length=255)
    # route = models.CharField(max_length=255)

    def __str__(self):
        return f"ControlLog for User {self.user.name}"
    

    
