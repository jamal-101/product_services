class FaqModel {
  bool? success;
  String? message;
  List<FaqData>? data;

  FaqModel({this.success, this.message, this.data});

  FaqModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FaqData>[];
      json['data'].forEach((v) {
        data!.add(FaqData.fromJson(v));
      });
    }
  }
}

class FaqData {
  String? sId;
  String? question;
  String? answer;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  FaqData({
    this.sId,
    this.question,
    this.answer,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  FaqData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}