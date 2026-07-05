from django.contrib import admin
from .models import ControlLog

@admin.register(ControlLog)
class ControlLogAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'device_id', 'create_time', 'update_time', 'status')  # Customize as needed
    search_fields = ( 'user_id__username', 'device_id__device_id')  # Adjust based on related fields
