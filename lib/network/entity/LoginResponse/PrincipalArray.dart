class PrincipalArray {
  PrincipalArray({
    this.userId,
    this.name,
    this.photo,});

  PrincipalArray.fromJson(dynamic json) {
    userId = json['user_id'];
    name = json['name'];
    photo = json['photo'];
  }

  String? userId;
  String? name;
  String? photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['name'] = name;
    map['photo'] = photo;
    return map;
  }

}