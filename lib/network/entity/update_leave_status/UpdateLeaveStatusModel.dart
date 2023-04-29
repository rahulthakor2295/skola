class UpdateLeaveStatusModel {
  UpdateLeaveStatusModel({
    this.error,
    this.msg,
  });

  UpdateLeaveStatusModel.fromJson(dynamic json) {
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
