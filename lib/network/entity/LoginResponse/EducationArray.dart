class EducationArray {
  EducationArray({
    this.educationId,
    this.educationName,
  });

  EducationArray.fromJson(dynamic json) {
    educationId = json['EducationId'];
    educationName = json['EducationName'];
  }

  String? educationId;
  String? educationName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EducationId'] = educationId;
    map['EducationName'] = educationName;
    return map;
  }
}
