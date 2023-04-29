import 'DivArray.dart';
import 'ClassArray.dart';
import 'PrincipalArray.dart';
import 'EducationArray.dart';
import 'CategoryArray.dart';
import 'ReligionArray.dart';

class LoginResponse {
  LoginResponse({
    this.error,
    this.msg,
    this.userId,
    this.role,
    this.section,
    this.schoolId,
    this.schoolname,
    this.name,
    this.photo,
    this.email,
    this.yearId,
    this.classId,
    this.className,
    this.divId,
    this.divName,
    this.divArray,
    this.classArray,
    this.classStatus,
    this.principalArray,
    this.educationArray,
    this.categoryArray,
    this.religionArray,
    this.contactNumber1,
  });

  LoginResponse.fromJson(dynamic json) {
    error = json['error'];
    msg = json['msg'];
    userId = json['user_id'];
    role = json['role'];
    section = json['section'];
    schoolId = json['school_id'];
    schoolname = json['schoolname'];
    name = json['name'];
    photo = json['photo'];
    email = json['email'];
    yearId = json['year_id'];
    classId = json['class_id'];
    className = json['class_name'];
    divId = json['div_id'];
    divName = json['div_name'];
    if (json['div_array'] != null) {
      divArray = [];
      json['div_array'].forEach((v) {
        divArray?.add(DivArray.fromJson(v));
      });
    }
    if (json['class_array'] != null) {
      classArray = [];
      json['class_array'].forEach((v) {
        classArray?.add(ClassArray.fromJson(v));
      });
    }
    classStatus = json['class_status'];
    principalArray = (json['principal_array'] != null
        ? PrincipalArray.fromJson(json['principal_array'])
        : null)!;
    if (json['education_array'] != null) {
      educationArray = [];
      json['education_array'].forEach((v) {
        educationArray?.add(EducationArray.fromJson(v));
      });
    }
    if (json['category_array'] != null) {
      categoryArray = [];
      json['category_array'].forEach((v) {
        categoryArray?.add(CategoryArray.fromJson(v));
      });
    }
    if (json['religion_array'] != null) {
      religionArray = [];
      json['religion_array'].forEach((v) {
        religionArray?.add(ReligionArray.fromJson(v));
      });
    }
    contactNumber1 = json['ContactNumber1'];
  }

  bool? error;
  String? msg;
  String? userId;
  String? role;
  String? section;
  String? schoolId;
  String? schoolname;
  String? name;
  String? photo;
  String? email;
  String? yearId;
  String? classId;
  String? className;
  String? divId;
  String? divName;
  List<DivArray>? divArray;
  List<ClassArray>? classArray;
  String? classStatus;
  PrincipalArray? principalArray;
  List<EducationArray>? educationArray;
  List<CategoryArray>? categoryArray;
  List<ReligionArray>? religionArray;
  String? contactNumber1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['msg'] = msg;
    map['user_id'] = userId;
    map['role'] = role;
    map['section'] = section;
    map['school_id'] = schoolId;
    map['schoolname'] = schoolname;
    map['name'] = name;
    map['photo'] = photo;
    map['email'] = email;
    map['year_id'] = yearId;
    map['class_id'] = classId;
    map['class_name'] = className;
    map['div_id'] = divId;
    map['div_name'] = divName;
    if (divArray != null) {
      map['div_array'] = divArray?.map((v) => v.toJson()).toList();
    }
    if (classArray != null) {
      map['class_array'] = classArray?.map((v) => v.toJson()).toList();
    }
    map['class_status'] = classStatus;
    if (principalArray != null) {
      map['principal_array'] = principalArray?.toJson();
    }
    if (educationArray != null) {
      map['education_array'] = educationArray?.map((v) => v.toJson()).toList();
    }
    if (categoryArray != null) {
      map['category_array'] = categoryArray?.map((v) => v.toJson()).toList();
    }
    if (religionArray != null) {
      map['religion_array'] = religionArray?.map((v) => v.toJson()).toList();
    }
    map['ContactNumber1'] = contactNumber1;
    return map;
  }
}
