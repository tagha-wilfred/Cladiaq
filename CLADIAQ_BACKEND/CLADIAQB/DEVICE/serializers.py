
from rest_framework import serializers
from .models import Device, SensorData
from USERS.models import Organization

class DeviceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Device
        fields = ['id', 'date_installed', 'organisation_id', 'location']

class SensorDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = SensorData
        fields = [
            'id', 'device_id', 'temperature', 'humidity', 'atm_pressure',
            'light_intensity', 'nh3', 'co', 'co2', 'o3', 'c5h5', 'cov',
            'inflamables', 'picture', 'time'
        ]