class CategoryModel {
  bool? success;
  String? message;
  List<CategoryData>? data;

  CategoryModel({this.success, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }
}

class CategoryData {
  String? sId;
  String? name;
  String? description;
  String? type;
  String? status;

  CategoryData({this.sId, this.name, this.description, this.type, this.status});

  CategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    status = json['status'];
  }
}