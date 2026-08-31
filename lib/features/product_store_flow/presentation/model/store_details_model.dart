import '../../../home_flow/presentatin/model/city_model.dart';
import '../../../profile_section/presentation/screen/store_creation/presentation/model/category_model.dart';

class StoreDetailsModel {
  bool? success;
  String? message;
  StoreData? data;

  StoreDetailsModel({this.success, this.message, this.data});

  StoreDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? StoreData.fromJson(json['data']) : null;
  }
}

class StoreData {
  Store? store;
  List<ProductItem>? products;
  List<ServiceItem>? services;

  StoreData({this.store, this.products, this.services});

  StoreData.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    if (json['products'] != null) {
      products = <ProductItem>[];
      json['products'].forEach((v) {
        products!.add(ProductItem.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <ServiceItem>[];
      json['services'].forEach((v) {
        services!.add(ServiceItem.fromJson(v));
      });
    }
  }
}

class Store {
  String? sId;
  String? storeType;
  String? displayName;
  String? description;
  String? logo;
  String? coverImage;
  String? phone;
  String? whatsapp;
  String? email;
  int? visitorCount;
  num? averageRating;
  int? ratingCount;
  List<String>? workingDays;
  String? openingTime;
  String? closingTime;
  String? plan;
  int? listings;
  CityData? cityId;
  CategoryData? categoryId;
  bool? isVerified;

  Store({
    this.sId,
    this.storeType,
    this.displayName,
    this.description,
    this.logo,
    this.coverImage,
    this.phone,
    this.whatsapp,
    this.email,
    this.visitorCount,
    this.averageRating,
    this.ratingCount,
    this.workingDays,
    this.openingTime,
    this.closingTime,
    this.plan,
    this.listings,
    this.isVerified,
    this.categoryId,
  });

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    storeType = json['storeType'];
    displayName = json['displayName'];
    description = json['description'];
    logo = json['logo'];
    coverImage = json['coverImage'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    cityId = json['cityId'] != null ? CityData.fromJson(json['cityId']) : null;
    categoryId = json['categoryId'] != null ? CategoryData.fromJson(json['categoryId']) : null;
    visitorCount = json['visitorCount'];
    averageRating = json['averageRating'];
    ratingCount = json['ratingCount'];
    workingDays = json['workingDays'] != null ? List<String>.from(json['workingDays']) : null;
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    plan = json['plan'];
    listings = json['listings'];
    isVerified = json['isVerified'];
  }
}

class ProductItem {
  String? sId;
  String? title;
  num? activePrice;
  num? originalPrice;
  String? description;
  String? additionalInformation;
  List<String>? images;

  ProductItem({
    this.sId,
    this.title,
    this.activePrice,
    this.originalPrice,
    this.description,
    this.additionalInformation,
    this.images,
  });

  ProductItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    activePrice = json['activePrice'];
    originalPrice = json['originalPrice'];
    description = json['description'];
    additionalInformation = json['additionalInformation'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
  }
}

class ServiceItem {
  String? sId;
  String? title;
  num? activePrice;
  num? originalPrice;
  String? description;
  List<String>? whatsIncluded;
  List<String>? images;

  ServiceItem({
    this.sId,
    this.title,
    this.activePrice,
    this.originalPrice,
    this.description,
    this.whatsIncluded,
    this.images,
  });

  ServiceItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    activePrice = json['activePrice'];
    originalPrice = json['originalPrice'];
    description = json['description'];
    whatsIncluded = json['whatsIncluded'] != null ? List<String>.from(json['whatsIncluded']) : null;
    images = json['images'] != null ? List<String>.from(json['images']) : null;
  }
}