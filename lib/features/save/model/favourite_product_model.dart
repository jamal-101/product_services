class FavouriteProductModel {
  bool? success;
  String? message;
  List<FavoriteData>? data;
  Meta? meta;

  FavouriteProductModel({this.success, this.message, this.data, this.meta});

  FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavoriteData>[];
      json['data'].forEach((v) {
        data!.add(FavoriteData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
}

class FavoriteData {
  String? sId;
  String? userId;
  TargetId? targetId;
  String? targetType;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? targetModel;
  String? id;

  FavoriteData({
    this.sId,
    this.userId,
    this.targetId,
    this.targetType,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.targetModel,
    this.id,
  });

  FavoriteData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    targetId = json['targetId'] != null ? TargetId.fromJson(json['targetId']) : null;
    targetType = json['targetType'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    targetModel = json['targetModel'];
    id = json['id'];
  }
}

class TargetId {
  String? sId;
  String? sellerId;
  String? title;
  num? activePrice;
  num? originalPrice;
  String? description;
  String? additionalInformation;
  List<String>? whatsIncluded;
  List<String>? images;
  String? status;
  bool? isDeleted;

  TargetId({
    this.sId,
    this.sellerId,
    this.title,
    this.activePrice,
    this.originalPrice,
    this.description,
    this.additionalInformation,
    this.whatsIncluded,
    this.images,
    this.status,
    this.isDeleted,
  });

  TargetId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sellerId = json['sellerId'];
    title = json['title'];
    activePrice = json['activePrice'];
    originalPrice = json['originalPrice'];
    description = json['description'];
    additionalInformation = json['additionalInformation'];
    whatsIncluded = json['whatsIncluded'] != null ? List<String>.from(json['whatsIncluded']) : null;
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    status = json['status'];
    isDeleted = json['isDeleted'];
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
}