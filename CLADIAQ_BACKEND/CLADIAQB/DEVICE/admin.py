from django.contrib import admin
from .models import Device, SensorData

@admin.register(Device)
class DeviceAdmin(admin.ModelAdmin):
    list_display = ('organisation_id', 'location', 'date_installed')  # Customize as needed
    search_fields = ('organisation_id__name', 'location')  # Adjust based on related fields

@admin.register(SensorData)
class SensorDataAdmin(admin.ModelAdmin):
    list_display = ('device_id', 'time', 'temperature', 'humidity')  # Customize as needed
    search_fields = ('device_id__organisation_id__name', 'time')  # Adjust based on related fields