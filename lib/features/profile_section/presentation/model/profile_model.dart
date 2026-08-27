class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? subscriptionExpiresAt;
  String? subscriptionPackageId;
  String? timezone;

  Data(
      {this.location,
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
        this.timezone});

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
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
    subscriptionExpiresAt = json['subscriptionExpiresAt'];
    subscriptionPackageId = json['subscriptionPackageId'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['role'] = this.role;
    data['activeRole'] = this.activeRole;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['countryCode'] = this.countryCode;
    data['verified'] = this.verified;
    data['averageRating'] = this.averageRating;
    data['totalRatings'] = this.totalRatings;
    data['totalReviews'] = this.totalReviews;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['stripeCustomerId'] = this.stripeCustomerId;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['stripeSubscriptionId'] = this.stripeSubscriptionId;
    data['subscriptionExpiresAt'] = this.subscriptionExpiresAt;
    data['subscriptionPackageId'] = this.subscriptionPackageId;
    data['timezone'] = this.timezone;
    return data;
  }
}

class Location {
  String? type;
  List<int>? coordinates;
  String? address;

  Location({this.type, this.coordinates, this.address});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['address'] = this.address;
    return data;
  }
}