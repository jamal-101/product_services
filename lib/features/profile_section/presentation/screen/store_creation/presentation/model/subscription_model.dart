class Subscription_Model {
  bool? success;
  String? message;
  List<Data>? data;

  Subscription_Model({this.success, this.message, this.data});

  Subscription_Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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

  Data(
      {this.sId,
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
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    duration = json['duration'];
    status = json['status'];
    packageType = json['packageType'];
    listingLimit = json['listingLimit'];
    isUnlimitedListings = json['isUnlimitedListings'];
    trialEnabled = json['trialEnabled'];
    trialPeriodDays = json['trialPeriodDays'];
    stripeProductId = json['stripeProductId'];
    stripePriceId = json['stripePriceId'];
    features = json['features'].cast<String>();
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['packageType'] = this.packageType;
    data['listingLimit'] = this.listingLimit;
    data['isUnlimitedListings'] = this.isUnlimitedListings;
    data['trialEnabled'] = this.trialEnabled;
    data['trialPeriodDays'] = this.trialPeriodDays;
    data['stripeProductId'] = this.stripeProductId;
    data['stripePriceId'] = this.stripePriceId;
    data['features'] = this.features;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}