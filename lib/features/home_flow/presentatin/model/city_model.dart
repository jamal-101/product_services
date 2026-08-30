class CityModel {
  bool? success;
  String? message;
  List<CityData>? data;

  CityModel({this.success, this.message, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(CityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityData {
  String? sId;
  String? country;
  String? countryCode;
  String? city;
  double? latitude;
  double? longitude;
  int? price;
  String? status;
  bool? isDeleted;

  CityData({
    this.sId,
    this.country,
    this.countryCode,
    this.city,
    this.latitude,
    this.longitude,
    this.price,
    this.status,
    this.isDeleted,
  });

  CityData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    country = json['country'];
    countryCode = json['countryCode'];
    city = json['city'];
    latitude = json['latitude']?.toDouble();
    longitude = json['longitude']?.toDouble();
    price = json['price'];
    status = json['status'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.sId;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['price'] = this.price;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}