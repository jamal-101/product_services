class SubscriptionHistory {
  bool? success;
  String? message;
  List<Data>? data;

  SubscriptionHistory({this.success, this.message, this.data});

  SubscriptionHistory.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? stripeSubscriptionId;
  double? amountPaid;
  String? createdAt;
  String? expiresAt;
  bool? isDeleted;
  PackageId? packageId;
  String? packageType;
  String? status;
  String? stripeSessionId;
  String? trxId;
  String? updatedAt;
  String? userId;
  CityConfigId? cityConfigId;

  Data({
    this.sId,
    this.stripeSubscriptionId,
    this.amountPaid,
    this.createdAt,
    this.expiresAt,
    this.isDeleted,
    this.packageId,
    this.packageType,
    this.status,
    this.stripeSessionId,
    this.trxId,
    this.updatedAt,
    this.userId,
    this.cityConfigId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stripeSubscriptionId = json['stripeSubscriptionId'];

    // int আসলেও নিরাপদে double-এ কনভার্ট করবে
    amountPaid = json['amountPaid'] != null ? (json['amountPaid'] as num).toDouble() : null;

    createdAt = json['createdAt'];
    expiresAt = json['expiresAt'];
    isDeleted = json['isDeleted'];
    packageId = json['packageId'] != null ? PackageId.fromJson(json['packageId']) : null;
    packageType = json['packageType'];
    status = json['status'];
    stripeSessionId = json['stripeSessionId'];
    trxId = json['trxId'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    cityConfigId = json['cityConfigId'] != null ? CityConfigId.fromJson(json['cityConfigId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['stripeSubscriptionId'] = stripeSubscriptionId;
    data['amountPaid'] = amountPaid;
    data['createdAt'] = createdAt;
    data['expiresAt'] = expiresAt;
    data['isDeleted'] = isDeleted;
    if (packageId != null) {
      data['packageId'] = packageId!.toJson();
    }
    data['packageType'] = packageType;
    data['status'] = status;
    data['stripeSessionId'] = stripeSessionId;
    data['trxId'] = trxId;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    if (cityConfigId != null) {
      data['cityConfigId'] = cityConfigId!.toJson();
    }
    return data;
  }
}

class PackageId {
  String? sId;
  String? name;
  double? price;
  String? duration;
  String? status;
  String? packageType;
  int? listingLimit;
  bool? isUnlimitedListings;
  bool? trialEnabled;
  int? trialPeriodDays;
  String? stripeProductId;
  String? stripePriceId;
  List<String>? features;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  PackageId({
    this.sId,
    this.name,
    this.price,
    this.duration,
    this.status,
    this.packageType,
    this.listingLimit,
    this.isUnlimitedListings,
    this.trialEnabled,
    this.trialPeriodDays,
    this.stripeProductId,
    this.stripePriceId,
    this.features,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  PackageId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];

    // int আসলেও নিরাপদে double-এ কনভার্ট করবে
    price = json['price'] != null ? (json['price'] as num).toDouble() : null;

    duration = json['duration'];
    status = json['status'];
    packageType = json['packageType'];
    listingLimit = json['listingLimit'];
    isUnlimitedListings = json['isUnlimitedListings'];
    trialEnabled = json['trialEnabled'];
    trialPeriodDays = json['trialPeriodDays'];
    stripeProductId = json['stripeProductId'];
    stripePriceId = json['stripePriceId'];
    if (json['features'] != null) {
      features = json['features'].cast<String>();
    }
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['duration'] = duration;
    data['status'] = status;
    data['packageType'] = packageType;
    data['listingLimit'] = listingLimit;
    data['isUnlimitedListings'] = isUnlimitedListings;
    data['trialEnabled'] = trialEnabled;
    data['trialPeriodDays'] = trialPeriodDays;
    data['stripeProductId'] = stripeProductId;
    data['stripePriceId'] = stripePriceId;
    data['features'] = features;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class CityConfigId {
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

  CityConfigId({
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

  CityConfigId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    country = json['country'];
    countryCode = json['countryCode'];
    city = json['city'];

    // double কাস্টিং
    latitude = json['latitude'] != null ? (json['latitude'] as num).toDouble() : null;
    longitude = json['longitude'] != null ? (json['longitude'] as num).toDouble() : null;

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