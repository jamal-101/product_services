class GetMyStore {
  bool? success;
  String? message;
  Data? data;

  GetMyStore({this.success, this.message, this.data});

  GetMyStore.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  Seller? seller;
  String? plan;
  int? listings;
  List<Products>? products; // এখানে List<dynamic> এর পরিবর্তে List<Products> করা হয়েছে
  List<Services>? services;
  List<Reviews>? reviews;
  RatingStats? ratingStats;
  int? totalReviews;

  Data({
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
    this.seller,
    this.plan,
    this.listings,
    this.products,
    this.services,
    this.reviews,
    this.ratingStats,
    this.totalReviews,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    averageRating = json['averageRating']?.toDouble();
    ratingCount = json['ratingCount'];
    workingDays = json['workingDays']?.cast<String>();
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    isOpen24Hours = json['isOpen24Hours'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    plan = json['plan'];
    listings = json['listings'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        if (v != null) {
          products!.add(Products.fromJson(v as Map<String, dynamic>));
        }
      });
    }

    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        if (v != null) {
          services!.add(Services.fromJson(v as Map<String, dynamic>));
        }
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    ratingStats = json['ratingStats'] != null ? RatingStats.fromJson(json['ratingStats']) : null;
    totalReviews = json['totalReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['owner'] = owner;
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
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['plan'] = plan;
    data['listings'] = listings;

    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (ratingStats != null) {
      data['ratingStats'] = ratingStats!.toJson();
    }
    data['totalReviews'] = totalReviews;
    return data;
  }
}

// নতুন যুক্ত করা Products ক্লাস
class Products {
  String? sId;
  String? sellerId;
  String? storeId;
  String? title;
  int? activePrice;
  int? originalPrice;
  String? description;
  String? additionalInformation;
  List<String>? images;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Products({
    this.sId,
    this.sellerId,
    this.storeId,
    this.title,
    this.activePrice,
    this.originalPrice,
    this.description,
    this.additionalInformation,
    this.images,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['sellerId'];
    storeId = json['storeId'];
    title = json['title'];
    activePrice = json['activePrice'];
    originalPrice = json['originalPrice'];
    description = json['description'];
    additionalInformation = json['additionalInformation'];
    images = json['images']?.cast<String>();
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sellerId'] = sellerId;
    data['storeId'] = storeId;
    data['title'] = title;
    data['activePrice'] = activePrice;
    data['originalPrice'] = originalPrice;
    data['description'] = description;
    data['additionalInformation'] = additionalInformation;
    data['images'] = images;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
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

class Seller {
  String? sId;
  String? user;
  String? store;
  String? status;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Seller({
    this.sId,
    this.user,
    this.store,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  Seller.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    store = json['store'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['store'] = store;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Services {
  String? sId;
  String? sellerId;
  String? storeId;
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

  Services({
    this.sId,
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
    this.updatedAt,
  });

  Services.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['sellerId'];
    storeId = json['storeId'];
    title = json['title'];
    activePrice = json['activePrice'];
    originalPrice = json['originalPrice'];
    description = json['description'];
    whatsIncluded = json['whatsIncluded']?.cast<String>();
    images = json['images']?.cast<String>();
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sellerId'] = sellerId;
    data['storeId'] = storeId;
    data['title'] = title;
    data['activePrice'] = activePrice;
    data['originalPrice'] = originalPrice;
    data['description'] = description;
    data['whatsIncluded'] = whatsIncluded;
    data['images'] = images;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Reviews {
  String? sId;
  String? storeId;
  UserId? userId;
  int? rating;
  String? comment;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  OwnerReply? ownerReply;
  bool? isReplied;
  String? id;

  Reviews({
    this.sId,
    this.storeId,
    this.userId,
    this.rating,
    this.comment,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.ownerReply,
    this.isReplied,
    this.id,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    storeId = json['storeId'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    rating = json['rating'];
    comment = json['comment'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ownerReply = json['ownerReply'] != null ? OwnerReply.fromJson(json['ownerReply']) : null;
    isReplied = json['isReplied'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['storeId'] = storeId;
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (ownerReply != null) {
      data['ownerReply'] = ownerReply!.toJson();
    }
    data['isReplied'] = isReplied;
    data['id'] = id;
    return data;
  }
}

class UserId {
  String? sId;
  String? name;
  String? role;
  String? activeRole;
  String? email;
  String? profileImage;

  UserId({
    this.sId,
    this.name,
    this.role,
    this.activeRole,
    this.email,
    this.profileImage,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
    activeRole = json['activeRole'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['role'] = role;
    data['activeRole'] = activeRole;
    data['email'] = email;
    data['profileImage'] = profileImage;
    return data;
  }
}

class OwnerReply {
  String? comment;
  String? createdAt;

  OwnerReply({this.comment, this.createdAt});

  OwnerReply.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    return data;
  }
}

class RatingStats {
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;

  RatingStats({this.i1, this.i2, this.i3, this.i4, this.i5});

  RatingStats.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1;
    data['2'] = i2;
    data['3'] = i3;
    data['4'] = i4;
    data['5'] = i5;
    return data;
  }
}