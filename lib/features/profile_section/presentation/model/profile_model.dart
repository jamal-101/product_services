class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  Location? location;
  String? sId;
  String? name;
  String? role;
  String? activeRole;
  String? email;
  String? profileImage;
  String? gender;
  String? status;
  String? phone;
  String? countryCode;
  bool? verified;
  int? averageRating;
  int? totalRatings;
  int? totalReviews;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? stripeCustomerId;
  String? subscriptionStatus;
  String? stripeSubscriptionId;
  String? datafastRegistrationToken;
  bool? isVerified;
  String? subscriptionExpiresAt;
  String? subscriptionPackageId;
  String? timezone;
  String? address;
  String? postalCode;
  String? state;
  bool? isSubscribed;
  StoreSubscription? storeSubscription;
  PostSubscription? postSubscription;
  bool? isStoreCreated;
  String? storeType;

  Data({
    this.location,
    this.sId,
    this.name,
    this.role,
    this.activeRole,
    this.email,
    this.profileImage,
    this.gender,
    this.status,
    this.phone,
    this.countryCode,
    this.verified,
    this.averageRating,
    this.totalRatings,
    this.totalReviews,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.stripeCustomerId,
    this.subscriptionStatus,
    this.stripeSubscriptionId,
    this.subscriptionExpiresAt,
    this.subscriptionPackageId,
    this.timezone,
    this.address,
    this.postalCode,
    this.state,
    this.isSubscribed,
    this.storeSubscription,
    this.postSubscription,
    this.isStoreCreated,
    this.storeType,
  });

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
    activeRole = json['activeRole'];
    email = json['email'];
    profileImage = json['profileImage'];
    gender = json['gender'];
    status = json['status'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    verified = json['verified'];
    averageRating = json['averageRating'];
    totalRatings = json['totalRatings'];
    totalReviews = json['totalReviews'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    stripeCustomerId = json['stripeCustomerId'];
    subscriptionStatus = json['subscriptionStatus'];
    stripeSubscriptionId = json['stripeSubscriptionId'];
    datafastRegistrationToken = json['datafastRegistrationToken']; // <--- [ADD] পার্সিং
    isVerified = json['isVerified'];
    subscriptionExpiresAt = json['subscriptionExpiresAt'];
    subscriptionPackageId = json['subscriptionPackageId'];
    timezone = json['timezone'];
    address = json['address'];
    postalCode = json['postalCode'];
    state = json['state'];
    isStoreCreated = json['isStoreCreated'];
    isSubscribed = json['isSubscribed'];
    storeType = json['storeType'];
    storeSubscription = json['storeSubscription'] != null
        ? StoreSubscription.fromJson(json['storeSubscription'])
        : null;
    postSubscription = json['postSubscription'] != null
        ? PostSubscription.fromJson(json['postSubscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['role'] = role;
    data['activeRole'] = activeRole;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['gender'] = gender;
    data['status'] = status;
    data['phone'] = phone;
    data['countryCode'] = countryCode;
    data['verified'] = verified;
    data['averageRating'] = averageRating;
    data['totalRatings'] = totalRatings;
    data['totalReviews'] = totalReviews;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['stripeCustomerId'] = stripeCustomerId;
    data['subscriptionStatus'] = subscriptionStatus;
    data['stripeSubscriptionId'] = stripeSubscriptionId;
    data['datafastRegistrationToken'] = datafastRegistrationToken; // <--- [ADD] JSON ম্যাপে যুক্ত
    data['isVerified'] = isVerified;
    data['subscriptionExpiresAt'] = subscriptionExpiresAt;
    data['subscriptionPackageId'] = subscriptionPackageId;
    data['timezone'] = timezone;
    data['address'] = address;
    data['postalCode'] = postalCode;
    data['state'] = state;
    data['isSubscribed'] = isSubscribed;
    data['isStoreCreated'] = isStoreCreated;
    data['storeType'] = storeType;
    if (storeSubscription != null) {
      data['storeSubscription'] = storeSubscription!.toJson();
    }
    if (postSubscription != null) {
      data['postSubscription'] = postSubscription!.toJson();
    }
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;
  String? address;
  String? canton;       // <--- নতুন
  String? city;         // <--- নতুন
  String? country;      // <--- নতুন
  String? neighborhood; // <--- নতুন
  String? province;     // <--- নতুন
  String? sector;


  Location({this.type, this.coordinates, this.address,this.canton,
    this.city,
    this.country,
    this.neighborhood,
    this.province,
    this.sector,});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = (json['coordinates'] as List).map((e) => (e as num).toDouble()).toList();
    }
    address = json['address'];
    canton = json['canton'];             // <--- [ADD] fromJson-এ যুক্ত
    city = json['city'];                 // <--- [ADD] fromJson-এ যুক্ত
    country = json['country'];           // <--- [ADD] fromJson-এ যুক্ত
    neighborhood = json['neighborhood']; // <--- [ADD] fromJson-এ যুক্ত
    province = json['province'];         // <--- [ADD] fromJson-এ যুক্ত
    sector = json['sector'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    data['address'] = address;
    data['canton'] = canton;             // <--- [ADD] toJson-এ যুক্ত
    data['city'] = city;                 // <--- [ADD] toJson-এ যুক্ত
    data['country'] = country;           // <--- [ADD] toJson-এ যুক্ত
    data['neighborhood'] = neighborhood; // <--- [ADD] toJson-এ যুক্ত
    data['province'] = province;         // <--- [ADD] toJson-এ যুক্ত
    data['sector'] = sector;
    return data;
  }
}

class StoreSubscription {
  bool? isPurchased;
  String? expiresAt;
  String? status;
  int? remainingDays;


  StoreSubscription({this.isPurchased, this.expiresAt,this.status,        // <--- [ADD] কনস্ট্রাক্টরে যুক্ত
    this.remainingDays,});

  StoreSubscription.fromJson(Map<String, dynamic> json) {
    isPurchased = json['isPurchased'];
    expiresAt = json['expiresAt'];
    status = json['status'];               // <--- [ADD] fromJson-এ যুক্ত
    remainingDays = json['remainingDays'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isPurchased'] = isPurchased;
    data['expiresAt'] = expiresAt;
    data['status'] = status;               // <--- [ADD] toJson-এ যুক্ত
    data['remainingDays'] = remainingDays;
    return data;
  }
}

class PostSubscription {
  bool? isPurchased;
  String? expiresAt;
  int? remainingDays;
  String? status;

  PostSubscription({this.isPurchased, this.expiresAt,this.remainingDays, // <--- [ADD] কনস্ট্রাক্টরে যুক্ত
    this.status,});

  PostSubscription.fromJson(Map<String, dynamic> json) {
    isPurchased = json['isPurchased'];
    expiresAt = json['expiresAt'];
    remainingDays = json['remainingDays']; // <--- [ADD] fromJson-এ যুক্ত
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isPurchased'] = isPurchased;
    data['expiresAt'] = expiresAt;
    data['remainingDays'] = remainingDays; // <--- [ADD] toJson-এ যুক্ত
    data['status'] = status;
    return data;
  }
}