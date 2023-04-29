import 'Data.dart';

class StudentGetLeaveModel {
  StudentGetLeaveModel({
    this.error,
    this.msg,
    this.data,
  });

  StudentGetLeaveModel.fromJson(dynamic json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  bool? error;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
