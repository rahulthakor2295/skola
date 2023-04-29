import 'package:floor_annotation/floor_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddLeaveResponseModel {
  AddLeaveResponseModel({
    this.error,
    this.msg,
  });

  AddLeaveResponseModel.fromJson(dynamic json) {
    error = json['error'];
    msg = json['msg'];
  }

  bool? error;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['msg'] = msg;
    return map;
  }
}
