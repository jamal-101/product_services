class ProductCityModel {
  bool? success;
  String? message;
  ProductCityPagination? pagination;
  List<ProductCityData>? data;

  ProductCityModel({this.success, this.message, this.pagination, this.data});

  ProductCityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null ? ProductCityPagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <ProductCityData>[];
      json['data'].forEach((v) {
        data!.add(ProductCityData.fromJson(v));
      });
    }
  }
}

class ProductCityPagination {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  ProductCityPagination({this.page, this.limit, this.total, this.totalPage});

  ProductCityPagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }
}

class ProductCityData {
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

  ProductCityData({
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
  });

  ProductCityData.fromJson(Map<String, dynamic> json) {
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
  }
}