import 'DivArray.dart';

class ClassArray {
  ClassArray({
    this.classId,
    this.className,
    this.divArray,
  });

  ClassArray.fromJson(dynamic json) {
    classId = json['class_id'];
    className = json['ClassName'];
    // if (json['div_array'] != null) {
    //   divArray = [];
    //   json['div_array'].forEach((v) {
    //     divArray?.add(DivArray.fromJson(v));
    //   });
    // }
  }

  String? classId;
  String? className;
  List<DivArray>? divArray = List.empty();

  //
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['class_id'] = classId;
    map['ClassName'] = className;
    // if (divArray != null) {
    //   map['div_array'] = divArray?.map((v) => v.toJson()).toList();
    // }
    return map;
  }
}
