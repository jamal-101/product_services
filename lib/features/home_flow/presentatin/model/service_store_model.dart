class ServiceStoreModel {
  bool? success;
  String? message;
  List<ServiceStoreData>? data;
  Meta? meta;

  ServiceStoreModel({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  factory ServiceStoreModel.fromJson(Map<String, dynamic> json) {
    return ServiceStoreModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<ServiceStoreData>.from(
          json['data'].map((v) => ServiceStoreData.fromJson(v)))
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class ServiceStoreData {
  String? sId;
  Owner? owner;
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
  String? plan;
  int? listings;
  bool? isFavorite;

  ServiceStoreData({
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
    this.plan,
    this.listings,
    this.isFavorite,
  });

  factory ServiceStoreData.fromJson(Map<String, dynamic> json) {
    return ServiceStoreData(
      sId: json['_id'],
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
      storeType: json['storeType'],
      displayName: json['displayName'],
      description: json['description'],
      categoryId: json['categoryId'] != null
          ? CategoryId.fromJson(json['categoryId'])
          : null,
      logo: json['logo'],
      coverImage: json['coverImage'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      email: json['email'],
      cityId: json['cityId'] != null ? CityId.fromJson(json['cityId']) : null,
      businessLicenseNumber: json['businessLicenseNumber'],
      tradeLicense: json['tradeLicense'],
      tinNumber: json['tinNumber'],
      status: json['status'],
      isVerified: json['isVerified'],
      visitorCount: json['visitorCount'],
      averageRating: json['averageRating'],
      ratingCount: json['ratingCount'],
      workingDays: json['workingDays'] != null
          ? List<String>.from(json['workingDays'])
          : null,
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      isOpen24Hours: json['isOpen24Hours'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      plan: json['plan'],
      listings: json['listings'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['storeType'] = storeType;
    data['displayName'] = displayName;
    data['description'] = description;
    if (categoryId != null) {
      data['categoryId'] = categoryId!.toJson();
    }
    data['logo'] = logo;
    data['coverImage'] = coverImage;
    data['phone'] = phone;
    data['whatsapp'] = whatsapp;
    data['email'] = email;
    if (cityId != null) {
      data['cityId'] = cityId!.toJson();
    }
    data['businessLicenseNumber'] = businessLicenseNumber;
    data['tradeLicense'] = tradeLicense;
    data['tinNumber'] = tinNumber;
    data['status'] = status;
    data['isVerified'] = isVerified;
    data['visitorCount'] = visitorCount;
    data['averageRating'] = averageRating;
    data['ratingCount'] = ratingCount;
    data['workingDays'] = workingDays;
    data['openingTime'] = openingTime;
    data['closingTime'] = closingTime;
    data['isOpen24Hours'] = isOpen24Hours;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['plan'] = plan;
    data['listings'] = listings;
    data['isFavorite'] = isFavorite;

    return data;
  }
}

class Owner {
  String? sId;
  String? name;
  String? email;
  String? profileImage;
  String? phone;

  Owner({this.sId, this.name, this.email, this.profileImage, this.phone});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      sId: json['_id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['phone'] = phone;
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

  factory CategoryId.fromJson(Map<String, dynamic> json) {
    return CategoryId(
      sId: json['_id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      status: json['status'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
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

  factory CityId.fromJson(Map<String, dynamic> json) {
    return CityId(
      sId: json['_id'],
      country: json['country'],
      countryCode: json['countryCode'],
      city: json['city'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      bannerCapacity: json['bannerCapacity'],
      featuredCapacity: json['featuredCapacity'],
      bannerEnabled: json['bannerEnabled'],
      featuredEnabled: json['featuredEnabled'],
      status: json['status'],
      lockVersion: json['lockVersion'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['country'] = country;
    data['countryCode'] = countryCode;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['bannerCapacity'] = bannerCapacity;
    data['featuredCapacity'] = featuredCapacity;
    data['bannerEnabled'] = bannerEnabled;
    data['featuredEnabled'] = featuredEnabled;
    data['status'] = status;
    data['lockVersion'] = lockVersion;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPage'] = totalPage;
    return data;
  }
}