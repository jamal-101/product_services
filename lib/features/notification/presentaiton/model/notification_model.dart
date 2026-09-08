class NotificationModel {
  bool? success;
  String? message;
  List<Data>? data;
  Meta? meta;

  NotificationModel({this.success, this.message, this.data, this.meta});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? text;
  Receiver? receiver;
  ReferenceId? referenceId;
  String? referenceModel;
  bool? read;
  String? type;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
        this.title,
        this.text,
        this.receiver,
        this.referenceId,
        this.referenceModel,
        this.read,
        this.type,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    text = json['text'];
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    referenceId = json['referenceId'] != null
        ? new ReferenceId.fromJson(json['referenceId'])
        : null;
    referenceModel = json['referenceModel'];
    read = json['read'];
    type = json['type'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['text'] = this.text;
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    if (this.referenceId != null) {
      data['referenceId'] = this.referenceId!.toJson();
    }
    data['referenceModel'] = this.referenceModel;
    data['read'] = this.read;
    data['type'] = this.type;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Receiver {
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
  String? subscriptionStatus;
  String? timezone;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? subscriptionExpiresAt;
  String? subscriptionPackageId;

  Receiver(
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
        this.subscriptionStatus,
        this.timezone,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.subscriptionExpiresAt,
        this.subscriptionPackageId});

  Receiver.fromJson(Map<String, dynamic> json) {
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
    subscriptionStatus = json['subscriptionStatus'];
    timezone = json['timezone'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subscriptionExpiresAt = json['subscriptionExpiresAt'];
    subscriptionPackageId = json['subscriptionPackageId'];
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
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['timezone'] = this.timezone;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['subscriptionExpiresAt'] = this.subscriptionExpiresAt;
    data['subscriptionPackageId'] = this.subscriptionPackageId;
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

class ReferenceId {
  String? sId;
  String? sellerId;
  String? storeId;
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
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? userId;
  int? rating;
  String? comment;
  OwnerReply? ownerReply;
  bool? isReplied;
  String? id;
  String? packageId;
  String? packageType;
  String? expiresAt;
  String? cityConfigId;
  String? trxId;

  ReferenceId(
      {this.sId,
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
        this.price,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.rating,
        this.comment,
        this.ownerReply,
        this.isReplied,
        this.id,
        this.packageId,
        this.packageType,
        this.expiresAt,
        this.cityConfigId,
        this.trxId});

  ReferenceId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['sellerId'];
    storeId = json['storeId'];
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
    price = json['price'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    rating = json['rating'];
    comment = json['comment'];
    ownerReply = json['ownerReply'] != null
        ? new OwnerReply.fromJson(json['ownerReply'])
        : null;
    isReplied = json['isReplied'];
    id = json['id'];
    packageId = json['packageId'];
    packageType = json['packageType'];
    expiresAt = json['expiresAt'];
    cityConfigId = json['cityConfigId'];
    trxId = json['trxId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sellerId'] = this.sellerId;
    data['storeId'] = this.storeId;
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
    data['price'] = this.price;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    if (this.ownerReply != null) {
      data['ownerReply'] = this.ownerReply!.toJson();
    }
    data['isReplied'] = this.isReplied;
    data['id'] = this.id;
    data['packageId'] = this.packageId;
    data['packageType'] = this.packageType;
    data['expiresAt'] = this.expiresAt;
    data['cityConfigId'] = this.cityConfigId;
    data['trxId'] = this.trxId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;
  int? unreadCount;

  Meta({this.page, this.limit, this.total, this.totalPage, this.unreadCount});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
    unreadCount = json['unreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['totalPage'] = this.totalPage;
    data['unreadCount'] = this.unreadCount;
    return data;
  }
}