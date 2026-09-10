class featuresModel {
  bool? success;
  String? message;
  List<FeaturedData>? data;

  featuresModel({this.success, this.message, this.data});

  featuresModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<FeaturedData>.from(
        json['data'].map((v) => FeaturedData.fromJson(v)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedData {
  int? price;
  String? sId;
  String? sellerId;
  StoreId? storeId;
  String? advertisementType;
  String? campaignName;
  String? cityAdConfigId;
  String? country;
  String? countryCode;
  String? city;
  double? latitude;
  double? longitude;
  String? startDate;
  String? endDate;
  String? featuredImage;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  FeaturedData({
    this.price,
    this.sId,
    this.sellerId,
    this.storeId,
    this.advertisementType,
    this.campaignName,
    this.cityAdConfigId,
    this.country,
    this.countryCode,
    this.city,
    this.latitude,
    this.longitude,
    this.startDate,
    this.endDate,
    this.featuredImage,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  FeaturedData.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    sId = json['_id'];
    sellerId = json['sellerId'];
    storeId = json['storeId'] != null
        ? StoreId.fromJson(json['storeId'])
        : null;
    advertisementType = json['advertisementType'];
    campaignName = json['campaignName'];
    cityAdConfigId = json['cityAdConfigId'];
    country = json['country'];
    countryCode = json['countryCode'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    featuredImage = json['featuredImage'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = this.price;
    data['_id'] = this.sId;
    data['sellerId'] = this.sellerId;
    if (this.storeId != null) {
      data['storeId'] = this.storeId!.toJson();
    }
    data['advertisementType'] = this.advertisementType;
    data['campaignName'] = this.campaignName;
    data['cityAdConfigId'] = this.cityAdConfigId;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['featuredImage'] = this.featuredImage;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class StoreId {
  String? sId;
  String? owner;
  String? storeType;
  String? displayName;
  String? description;
  String? categoryId;
  String? logo;
  String? coverImage;
  String? phone;
  String? whatsapp;
  String? email;
  String? cityId;
  String? businessLicenseNumber;
  String? tradeLicense;
  String? tinNumber;
  String? status;
  bool? isVerified;
  int? visitorCount;
  double? averageRating;
  int? ratingCount;
  List<String>? workingDays;
  String? openingTime;
  String? closingTime;
  bool? isOpen24Hours;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? city;
  double? latitude;
  double? longitude;
  String? postalCode;
  String? streetAddress;

  StoreId({
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
    // this.averageRating,
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
    double? averageRating,
  });

  StoreId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    storeType = json['storeType'];
    displayName = json['displayName'];
    description = json['description'];
    categoryId = json['categoryId'];
    logo = json['logo'];
    coverImage = json['coverImage'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    cityId = json['cityId'];
    businessLicenseNumber = json['businessLicenseNumber'];
    tradeLicense = json['tradeLicense'];
    tinNumber = json['tinNumber'];
    status = json['status'];
    isVerified = json['isVerified'];
    averageRating = json['averageRating'] != null
        ? (json['averageRating'] as num).toDouble()
        : null;
    visitorCount = json['visitorCount'];
    ratingCount = json['ratingCount'];
    workingDays = json['workingDays'] != null
        ? List<String>.from(json['workingDays'])
        : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['owner'] = this.owner;
    data['storeType'] = this.storeType;
    data['displayName'] = this.displayName;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['logo'] = this.logo;
    data['coverImage'] = this.coverImage;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['cityId'] = this.cityId;
    data['businessLicenseNumber'] = this.businessLicenseNumber;
    data['tradeLicense'] = this.tradeLicense;
    data['tinNumber'] = this.tinNumber;
    data['status'] = this.status;
    data['isVerified'] = this.isVerified;
    data['visitorCount'] = this.visitorCount;
    data['averageRating'] = this.averageRating;
    data['averageRating'] = this.averageRating;
    data['workingDays'] = this.workingDays;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['isOpen24Hours'] = this.isOpen24Hours;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['postalCode'] = this.postalCode;
    data['streetAddress'] = this.streetAddress;
    return data;
  }
}
