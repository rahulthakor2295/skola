class DivArray {
  DivArray({
    this.divId,
    this.divisionName,
  });

  DivArray.fromJson(dynamic json) {
    divId = json['div_id'];
    divisionName = json['DivisionName'];
  }

  String? divId;
  String? divisionName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['div_id'] = divId;
    map['DivisionName'] = divisionName;
    return map;
  }
}
