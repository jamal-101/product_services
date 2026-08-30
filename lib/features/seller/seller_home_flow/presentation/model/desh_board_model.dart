class desh_board_model {
  bool? success;
  String? message;
  Data? data;

  desh_board_model({this.success, this.message, this.data});

  desh_board_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalItems;
  int? storeVisitors;
  List<WeeklyTraffic>? weeklyTraffic;

  Data({this.totalItems, this.storeVisitors, this.weeklyTraffic});

  Data.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    storeVisitors = json['storeVisitors'];
    if (json['weeklyTraffic'] != null) {
      weeklyTraffic = <WeeklyTraffic>[];
      json['weeklyTraffic'].forEach((v) {
        weeklyTraffic!.add(new WeeklyTraffic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['storeVisitors'] = this.storeVisitors;
    if (this.weeklyTraffic != null) {
      data['weeklyTraffic'] =
          this.weeklyTraffic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeeklyTraffic {
  String? day;
  int? count;

  WeeklyTraffic({this.day, this.count});

  WeeklyTraffic.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['count'] = this.count;
    return data;
  }
}