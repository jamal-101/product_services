class ServiceModel {
  bool? success;
  String? message;
  Data? data;

  ServiceModel({this.success, this.message, this.data});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  SellerId? sellerId;
  StoreId? storeId;
  String? title;
  int? activePrice;
  int? originalPrice;
  String? description;
  List<String>? whatsIncluded;
  List<String>? images;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
        this.sellerId,
        this.storeId,
        this.title,
        this.activePrice,
        this.originalPrice,
        this.description,
        this.whatsIncluded,
        this.images,
        this.status,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['sellerId'] != null
        ? new SellerId.fromJson(json['sellerId'])
        : null;
    storeId =
    json['storeId'] != null ? new StoreId.fromJson(json['storeId']) : null;
    title = json['title'];
    activePrice = json['activePrice'];
    originalPrice = json['originalPrice'];
    description = json['description'];
    whatsIncluded = json['whatsIncluded'].cast<String>();
    images = json['images'].cast<String>();
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.sellerId != null) {
      data['sellerId'] = this.sellerId!.toJson();
    }
    if (this.storeId != null) {
      data['storeId'] = this.storeId!.toJson();
    }
    data['title'] = this.title;
    data['activePrice'] = this.activePrice;
    data['originalPrice'] = this.originalPrice;
    data['description'] = this.description;
    data['whatsIncluded'] = this.whatsIncluded;
    data['images'] = this.images;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class SellerId {
  String? sId;
  String? name;
  String? email;

  SellerId({this.sId, this.name, this.email});

  SellerId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class StoreId {
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
  double? averageRating;
  int? ratingCount;
  List<String>? workingDays;
  String? openingTime;
  String? closingTime;
  bool? isOpen24Hours;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  StoreId(
      {this.sId,
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
        this.updatedAt});

  StoreId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    storeType = json['storeType'];
    displayName = json['displayName'];
    description = json['description'];
    categoryId = json['categoryId'] != null
        ? new CategoryId.fromJson(json['categoryId'])
        : null;
    logo = json['logo'];
    coverImage = json['coverImage'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    cityId =
    json['cityId'] != null ? new CityId.fromJson(json['cityId']) : null;
    businessLicenseNumber = json['businessLicenseNumber'];
    tradeLicense = json['tradeLicense'];
    tinNumber = json['tinNumber'];
    status = json['status'];
    isVerified = json['isVerified'];
    visitorCount = json['visitorCount'];
    averageRating = json['averageRating'];
    ratingCount = json['ratingCount'];
    workingDays = json['workingDays'].cast<String>();
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    isOpen24Hours = json['isOpen24Hours'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['owner'] = this.owner;
    data['storeType'] = this.storeType;
    data['displayName'] = this.displayName;
    data['description'] = this.description;
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId!.toJson();
    }
    data['logo'] = this.logo;
    data['coverImage'] = this.coverImage;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    if (this.cityId != null) {
      data['cityId'] = this.cityId!.toJson();
    }
    data['businessLicenseNumber'] = this.businessLicenseNumber;
    data['tradeLicense'] = this.tradeLicense;
    data['tinNumber'] = this.tinNumber;
    data['status'] = this.status;
    data['isVerified'] = this.isVerified;
    data['visitorCount'] = this.visitorCount;
    data['averageRating'] = this.averageRating;
    data['ratingCount'] = this.ratingCount;
    data['workingDays'] = this.workingDays;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['isOpen24Hours'] = this.isOpen24Hours;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
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

  CategoryId(
      {this.sId,
        this.name,
        this.description,
        this.type,
        this.status,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CityId {
  String? sId;
  String? country;
  String? countryCode;
  String? city;
  double? latitude;
  double? longitude;
  int? bannerCapacity;
  int? featuredCapacity;
  bool? bannerEnabled;
  bool? featuredEnabled;
  String? status;
  int? lockVersion;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  CityId(
      {this.sId,
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
        this.updatedAt});

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['bannerCapacity'] = this.bannerCapacity;
    data['featuredCapacity'] = this.featuredCapacity;
    data['bannerEnabled'] = this.bannerEnabled;
    data['featuredEnabled'] = this.featuredEnabled;
    data['status'] = this.status;
    data['lockVersion'] = this.lockVersion;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}