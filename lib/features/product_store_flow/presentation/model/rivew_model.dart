class RivewModel {
  bool? success;
  String? message;
  Data? data;
  Meta? meta;

  RivewModel({this.success, this.message, this.data, this.meta});

  RivewModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  List<Reviews>? reviews;
  RatingStats? ratingStats;
  bool? isSeller;
  double? averageRating;
  int? totalReviews;

  Data(
      {this.reviews,
        this.ratingStats,
        this.isSeller,
        this.averageRating,
        this.totalReviews});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    ratingStats = json['ratingStats'] != null
        ? RatingStats.fromJson(json['ratingStats'])
        : null;
    isSeller = json['isSeller'];
    averageRating = json['averageRating'] != null
        ? (json['averageRating'] as num).toDouble()
        : null;
    totalReviews = json['totalReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (ratingStats != null) {
      data['ratingStats'] = ratingStats!.toJson();
    }
    data['isSeller'] = isSeller;
    data['averageRating'] = averageRating;
    data['totalReviews'] = totalReviews;
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
  bool? isReplied;
  String? id;
  String? reply; // <-- নতুন ফিল্ড যোগ করা হলো (যদি ব্যাকএন্ডে reply নামে পাঠায়)

  Reviews(
      {this.sId,
        this.storeId,
        this.userId,
        this.rating,
        this.comment,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.isReplied,
        this.id,
        this.reply});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    storeId = json['storeId'];
    userId =
    json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    rating = json['rating'];
    comment = json['comment'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isReplied = json['isReplied'];
    id = json['id'];
    reply = json['reply']; // <-- জেসন থেকে ম্যাপ করা হলো
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
    data['isReplied'] = isReplied;
    data['id'] = id;
    data['reply'] = reply;
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

  UserId(
      {this.sId,
        this.name,
        this.role,
        this.activeRole,
        this.email,
        this.profileImage});

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPage'] = totalPage;
    return data;
  }
}