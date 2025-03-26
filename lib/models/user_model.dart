class UserModel {
  final int status;
  final Customer customer;
  final Data data;
  final String message;

  UserModel({
    required this.status,
    required this.customer,
    required this.data,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'] as int? ?? 0,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String? ?? '',
    );
  }
}

class Customer {
  final BusinessInfo businessInfo;
  final HomeLocation homeLocation;
  final String id;
  final String email;
  final String username;

  Customer({
    required this.businessInfo,
    required this.homeLocation,
    required this.id,
    required this.email,
    required this.username,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      businessInfo: BusinessInfo.fromJson(json['businessInfo'] as Map<String, dynamic>),
      homeLocation: HomeLocation.fromJson(json['homeLocation'] as Map<String, dynamic>),
      id: json['_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  }
}

class BusinessInfo {
  final BusinessLocation businessLocation;
  final String businessImageUrl;

  BusinessInfo({
    required this.businessLocation,
    required this.businessImageUrl,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    return BusinessInfo(
      businessLocation: BusinessLocation.fromJson(json['businessLocation'] as Map<String, dynamic>),
      businessImageUrl: json['businessImageUrl'] as String? ?? '',
    );
  }
}

class BusinessLocation {
  final dynamic placeId;
  final String country;

  BusinessLocation({
    required this.placeId,
    required this.country,
  });

  factory BusinessLocation.fromJson(Map<String, dynamic> json) {
    return BusinessLocation(
      placeId: json['placeId'],
      country: json['country'] as String? ?? '',
    );
  }
}

class HomeLocation {
  final dynamic completeAddress;
  final dynamic zip;
  final dynamic placeId;

  HomeLocation({
    required this.completeAddress,
    required this.zip,
    required this.placeId,
  });

  factory HomeLocation.fromJson(Map<String, dynamic> json) {
    return HomeLocation(
      completeAddress: json['completeAddress'],
      zip: json['zip'],
      placeId: json['placeId'],
    );
  }
}

class Data {
  final AvailableServices availableServices;

  Data({
    required this.availableServices,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      availableServices: AvailableServices.fromJson(
          json['availableServices'] as Map<String, dynamic>),
    );
  }
}

class AvailableServices {
  final String id;
  final String notaryId;
  final List<Service> services;
  final int v;

  AvailableServices({
    required this.id,
    required this.notaryId,
    required this.services,
    required this.v,
  });

  factory AvailableServices.fromJson(Map<String, dynamic> json) {
    return AvailableServices(
      id: json['_id'] as String? ?? '',
      notaryId: json['notaryId'] as String? ?? '',
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      v: json['__v'] as int? ?? 0,
    );
  }
}

class Service {
  final dynamic paymentLink;
  final ServiceId serviceId;
  final DateTime? createdOn;
  final String? id;
  final String serviceName;
  final String description;
  final int timeToBlockinMins;
  final bool manualPricingFlag;
  final int cost;
  final int timeBlockBeforeAfter;

  Service({
    this.paymentLink,
    required this.serviceId,
    this.createdOn,
    this.id,
    required this.serviceName,
    required this.description,
    required this.timeToBlockinMins,
    required this.manualPricingFlag,
    required this.cost,
    required this.timeBlockBeforeAfter,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      paymentLink: json['paymentLink'],
      serviceId: _parseServiceId(json['serviceId'] as String? ?? 'GEN_OFFLINE'),
      createdOn: json['createdOn'] != null 
          ? DateTime.tryParse(json['createdOn'] as String) 
          : null,
      id: json['_id'] as String?,
      serviceName: json['serviceName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      timeToBlockinMins: json['timeToBlockinMins'] as int? ?? 0,
      manualPricingFlag: json['manualPricingFlag'] as bool? ?? false,
      cost: json['cost'] as int? ?? 0,
      timeBlockBeforeAfter: json['timeBlockBeforeAfter'] as int? ?? 0,
    );
  }

  static ServiceId _parseServiceId(String value) {
    switch (value) {
      case 'GEN_OFFLINE':
        return ServiceId.GEN_OFFLINE;
      case 'GEN_ONLINE':
        return ServiceId.GEN_ONLINE;
      case 'LSA_OFFLINE':
        return ServiceId.LSA_OFFLINE;
      case 'LSA_OFFLINE_INHOUSE':
        return ServiceId.LSA_OFFLINE_INHOUSE;
      case 'LSA_ONLINE':
        return ServiceId.LSA_ONLINE;
      default:
        return ServiceId.GEN_OFFLINE;
    }
  }
}

enum ServiceId {
  GEN_OFFLINE,
  GEN_ONLINE,
  LSA_OFFLINE,
  LSA_OFFLINE_INHOUSE,
  LSA_ONLINE
}