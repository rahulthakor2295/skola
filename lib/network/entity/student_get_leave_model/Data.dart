class Data {
  Data({
    this.leaveId,
    this.userId,
    this.startDate,
    this.endDate,
    this.leaveType,
    this.leaveReason,
    this.leaveNote,
    this.leaveStatus,
    this.leaveRemark,
    this.userName,
    this.role,
    this.days,
  });

  Data.fromJson(dynamic json) {
    leaveId = json['leave_id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    leaveType = json['leave_type'];
    leaveReason = json['leave_reason'];
    leaveNote = json['leave_note'];
    leaveStatus = json['leave_status'];
    leaveRemark = json['leave_remark'];
    userName = json['user_name'];
    role = json['role'];
    days = json['days'];
  }

  String? leaveId;
  String? userId;
  String? startDate;
  String? endDate;
  String? leaveType;
  String? leaveReason;
  String? leaveNote;
  String? leaveStatus;
  dynamic? leaveRemark;
  String? userName;
  String? role;
  String? days;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leave_id'] = leaveId;
    map['user_id'] = userId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['leave_type'] = leaveType;
    map['leave_reason'] = leaveReason;
    map['leave_note'] = leaveNote;
    map['leave_status'] = leaveStatus;
    map['leave_remark'] = leaveRemark;
    map['user_name'] = userName;
    map['role'] = role;
    map['days'] = days;
    return map;
  }
}
