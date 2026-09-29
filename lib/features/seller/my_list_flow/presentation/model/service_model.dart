class ServiceModel {
  bool? success;
  String? message;
  List<Data>? data;
  Meta? meta;

  ServiceModel({this.success, this.message, this.data, this.meta});

  ServiceModel.fromJson(Map<String, dynamic> json) {
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
  String? sellerId;
  StoreId? storeId;
  String? title;
  num? activePrice;
  num? originalPrice;
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
    sellerId = json['sellerId'];
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
    data['sellerId'] = this.sellerId;
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
  // int? averageRating;
  num? averageRating;
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
    visitorCount = json['visitorCount'];
    // averageRating = json['averageRating'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['totalPage'] = this.totalPage;
    return data;
  }
}