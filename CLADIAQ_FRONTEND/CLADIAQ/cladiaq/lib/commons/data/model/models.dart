// Profile Model
class Profile {
  final String name;
  final String? address;
  final String? phoneNumber;
  final String email;
  final String? picture;

  Profile({
    required this.name,
    this.address,
    this.phoneNumber,
    required this.email,
    this.picture,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'picture': picture,
    };
  }

  static List<Profile> listFromJson(List<dynamic> json) {
    return json.map((item) => Profile.fromJson(item)).toList();
  }
}

// Organization Model
class Organization {
  final String name;
  final Profile? profile;
  final String? size;
  final String? industry;
  final bool verified;
  final DateTime createdAt;

  Organization({
    required this.name,
    this.profile,
    this.size,
    this.industry,
    required this.verified,
    required this.createdAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      name: json['name'],
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      size: json['size'],
      industry: json['industry'],
      verified: json['verified'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile': profile?.toJson(),
      'size': size,
      'industry': industry,
      'verified': verified,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static List<Organization> listFromJson(List<dynamic> json) {
    return json.map((item) => Organization.fromJson(item)).toList();
  }
}

// CustomUser Model
class CustomUser {
  final int id;
  final String username;
  final String? message;
  final String? email;
  final String? address;
  final String? tellNum;
  final Profile? profile;

  CustomUser({
    required this.username,
    required this.id,
    this.email,
    this.address,
    this.tellNum,
    this.profile,
    this.message,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      tellNum: json['tell_num'],
      message: json['message'],
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'address': address,
      'tell_num': tellNum,
      'message': message,
      'profile': profile?.toJson(),
    };
  }

  static List<CustomUser> listFromJson(List<dynamic> json) {
    return json.map((item) => CustomUser.fromJson(item)).toList();
  }
}

// UserOrganizationRole Model
class UserOrganizationRole {
  final CustomUser user;
  final Organization organization;
  final String type;

  UserOrganizationRole({
    required this.user,
    required this.organization,
    required this.type,
  });

  factory UserOrganizationRole.fromJson(Map<String, dynamic> json) {
    return UserOrganizationRole(
      user: CustomUser.fromJson(json['user']),
      organization: Organization.fromJson(json['organization']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'organization': organization.toJson(),
      'type': type,
    };
  }

  static List<UserOrganizationRole> listFromJson(List<dynamic> json) {
    return json.map((item) => UserOrganizationRole.fromJson(item)).toList();
  }
}

// SpecializedServices Model
class SpecializedServices {
  final Profile profile;

  SpecializedServices({required this.profile});

  factory SpecializedServices.fromJson(Map<String, dynamic> json) {
    return SpecializedServices(
      profile: Profile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile.toJson(),
    };
  }

  static List<SpecializedServices> listFromJson(List<dynamic> json) {
    return json.map((item) => SpecializedServices.fromJson(item)).toList();
  }
}

// Recommendation Model
class Recommendation {
  final String recommendation;
  final CustomUser? user;
  final DateTime time;

  Recommendation({
    required this.recommendation,
    this.user,
    required this.time,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      recommendation: json['recommendation'],
      user: json['user'] != null ? CustomUser.fromJson(json['user']) : null,
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendation': recommendation,
      'user': user?.toJson(),
      'time': time.toIso8601String(),
    };
  }

  static List<Recommendation> listFromJson(List<dynamic> json) {
    return json.map((item) => Recommendation.fromJson(item)).toList();
  }
}

// Device Model
class Device {
  final DateTime dateInstalled;
  final Organization organizationId;
  final String location;

  Device({
    required this.dateInstalled,
    required this.organizationId,
    required this.location,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      dateInstalled: DateTime.parse(json['date_installed']),
      organizationId: Organization.fromJson(json['organisation_id']),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_installed': dateInstalled.toIso8601String(),
      'organisation_id': organizationId.toJson(),
      'location': location,
    };
  }

  static List<Device> listFromJson(List<dynamic> json) {
    return json.map((item) => Device.fromJson(item)).toList();
  }
}

// SensorData Model
class SensorData {
  final int deviceId;
  final double? temperature;
  final double? humidity;
  final double? atmPressure;
  final double? lightIntensity;
  final double? nh3;
  final double? co;
  final double? co2;
  final double? o3;
  final double? c5h5;
  final double? cov;
  final double? inflamables;
  final String? picture;
  final DateTime time;

  SensorData({
    required this.deviceId,
    this.temperature,
    this.humidity,
    this.atmPressure,
    this.lightIntensity,
    this.nh3,
    this.co,
    this.co2,
    this.o3,
    this.c5h5,
    this.cov,
    this.inflamables,
    this.picture,
    required this.time,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      deviceId: json['id'],
      // deviceId: Device.fromJson(json['device_id']),
      temperature: json['temperature'],
      humidity: json['humidity'],
      atmPressure: json['atm_pressure'],
      lightIntensity: json['light_intensity'],
      nh3: json['nh3'],
      co: json['co'],
      co2: json['co2'],
      o3: json['o3'],
      c5h5: json['c5h5'],
      cov: json['cov'],
      inflamables: json['inflamables'],
      picture: json['picture'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'temperature': temperature,
      'humidity': humidity,
      'atm_pressure': atmPressure,
      'light_intensity': lightIntensity,
      'nh3': nh3,
      'co': co,
      'co2': co2,
      'o3': o3,
      'c5h5': c5h5,
      'cov': cov,
      'inflamables': inflamables,
      'picture': picture,
      'time': time.toIso8601String(),
    };
  }

  static List<SensorData> listFromJson(List<dynamic> json) {
    return json.map((item) => SensorData.fromJson(item)).toList();
  }
}

class AQIsum {
  final int aqi;
  final double temperature;
  final int sound;
  final int humidity;
  final int pressure;

  AQIsum(this.aqi, this.temperature, this.sound, this.humidity, this.pressure);
}

// List<Profile> profiles = Profile.listFromJson(jsonResponse);
// List<Organization> organizations = Organization.listFromJson(jsonResponse);