import 'TeacherDetail.dart';

class TeacherProfileModel {
  TeacherProfileModel({
    this.error,
    this.msg,
    this.teacherDetail,});

  TeacherProfileModel.fromJson(dynamic json) {
    error = json['error'];
    msg = json['msg'];
    teacherDetail = json['teacher_detail'] != null ? TeacherDetail.fromJson(
        json['teacher_detail']) : null;
  }

  bool? error;
  String? msg;
  TeacherDetail? teacherDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['msg'] = msg;
    if (teacherDetail != null) {
      map['teacher_detail'] = teacherDetail!.toJson();
    }
    return map;
  }

}