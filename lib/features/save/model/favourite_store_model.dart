class FavoriteStoreModel {
  bool? success;
  String? message;
  List<FavoriteData>? data;
  Meta? meta;

  FavoriteStoreModel({this.success, this.message, this.data, this.meta});

  FavoriteStoreModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavoriteData>[];
      json['data'].forEach((v) {
        data!.add(FavoriteData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class FavoriteData {
  String? sId;
  String? userId;
  TargetId? targetId;
  String? targetType;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? targetModel;
  String? id;

  FavoriteData({
    this.sId,
    this.userId,
    this.targetId,
    this.targetType,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.targetModel,
    this.id,
  });

  FavoriteData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    targetId = json['targetId'] != null ? TargetId.fromJson(json['targetId']) : null;
    targetType = json['targetType'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    targetModel = json['targetModel'];
    id = json['id'];
  }
}

class TargetId {
  String? sId;
  String? owner;
  String? storeType;
  String? displayName;
  String? description;
  CategoryId? categoryId;
  String? logo;
  String? coverImage;
  String? phone;
  String? whatsapp;
  String? email;
  CityId? cityId;
  String? businessLicenseNumber;
  String? tradeLicense;
  String? tinNumber;
  String? status;
  bool? isVerified;
  int? visitorCount;
  num? averageRating;
  int? ratingCount;
  List<String>? workingDays;
  String? openingTime;
  String? closingTime;
  bool? isOpen24Hours;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? city;
  num? latitude;
  num? longitude;
  String? postalCode;
  String? streetAddress;
  String? documentBack;
  String? documentFront;
  String? documentType;

  TargetId({
    this.sId,
    this.owner,
    this.storeType,
    this.displayName,
    this.description,
    this.categoryId,
    this.logo,
    this.coverImage,
    this.phone,
    this.whatsapp,
    this.email,
    this.cityId,
    this.businessLicenseNumber,
    this.tradeLicense,
    this.tinNumber,
    this.status,
    this.isVerified,
    this.visitorCount,
    this.averageRating,
    this.ratingCount,
    this.workingDays,
    this.openingTime,
    this.closingTime,
    this.isOpen24Hours,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.latitude,
    this.longitude,
    this.postalCode,
    this.streetAddress,
    this.documentBack,
    this.documentFront,
    this.documentType,
  });

  TargetId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    storeType = json['storeType'];
    displayName = json['displayName'];
    description = json['description'];
    categoryId = json['categoryId'] != null ? CategoryId.fromJson(json['categoryId']) : null;
    logo = json['logo'];
    coverImage = json['coverImage'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    cityId = json['cityId'] != null ? CityId.fromJson(json['cityId']) : null;
    businessLicenseNumber = json['businessLicenseNumber'];
    tradeLicense = json['tradeLicense'];
    tinNumber = json['tinNumber'];
    status = json['status'];
    isVerified = json['isVerified'];
    visitorCount = json['visitorCount'];
    averageRating = json['averageRating'];
    ratingCount = json['ratingCount'];
    workingDays = json['workingDays'] != null ? List<String>.from(json['workingDays']) : null;
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    isOpen24Hours = json['isOpen24Hours'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    postalCode = json['postalCode'];
    streetAddress = json['streetAddress'];
    documentBack = json['documentBack'];
    documentFront = json['documentFront'];
    documentType = json['documentType'];
  }
}

class CategoryId {
  String? sId;
  String? name;
  String? description;
  String? type;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CategoryId({
    this.sId,
    this.name,
    this.description,
    this.type,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class CityId {
  String? sId;
  String? country;
  String? countryCode;
  String? city;
  num? latitude;
  num? longitude;
  int? bannerCapacity;
  int? featuredCapacity;
  bool? bannerEnabled;
  bool? featuredEnabled;
  String? status;
  int? lockVersion;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CityId({
    this.sId,
    this.country,
    this.countryCode,
    this.city,
    this.latitude,
    this.longitude,
    this.bannerCapacity,
    this.featuredCapacity,
    this.bannerEnabled,
    this.featuredEnabled,
    this.status,
    this.lockVersion,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  CityId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    country = json['country'];
    countryCode = json['countryCode'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bannerCapacity = json['bannerCapacity'];
    featuredCapacity = json['featuredCapacity'];
    bannerEnabled = json['bannerEnabled'];
    featuredEnabled = json['featuredEnabled'];
    status = json['status'];
    lockVersion = json['lockVersion'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}