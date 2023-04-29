class ReligionArray {
  ReligionArray({
    this.religionId,
    this.religionName,
  });

  ReligionArray.fromJson(dynamic json) {
    religionId = json['ReligionId'];
    religionName = json['ReligionName'];
  }

  String? religionId;
  String? religionName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ReligionId'] = religionId;
    map['ReligionName'] = religionName;
    return map;
  }
}
