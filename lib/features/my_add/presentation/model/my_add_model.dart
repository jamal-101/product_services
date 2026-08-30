class MyAddModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  MyAddModel({this.success, this.message, this.pagination, this.data});

  MyAddModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Pagination({this.page, this.limit, this.total, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
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

class Data {
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
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  Data(
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
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}