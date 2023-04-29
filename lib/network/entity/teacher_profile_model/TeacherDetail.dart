class TeacherDetail {
  TeacherDetail({
    this.name,
    this.address,
    this.gender,
    this.contact1,
    this.photo,
    this.email,
    this.schoolJoining,
    this.dob,
    this.pancardNumber,
    this.drivinglicenceNumber,
    this.gpfNumber,
    this.cpfNumber,
    this.seniorityNumber,
    this.mandaniNumber,
    this.bankaccountNumber,
    this.bankName,
    this.bankBranch,
    this.branchCode,
    this.votercardNumber,
    this.employmentNumber,
  });

  TeacherDetail.fromJson(dynamic json) {
    name = json['name'];
    address = json['address'];
    gender = json['gender'];
    contact1 = json['contact1'];
    photo = json['photo'];
    email = json['email'];
    schoolJoining = json['school_joining'];
    dob = json['dob'];
    pancardNumber = json['pancard_number'];
    drivinglicenceNumber = json['drivinglicence_number'];
    gpfNumber = json['gpf_number'];
    cpfNumber = json['cpf_number'];
    seniorityNumber = json['seniority_number'];
    mandaniNumber = json['mandani_number'];
    bankaccountNumber = json['bankaccount_number'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    branchCode = json['branch_code'];
    votercardNumber = json['votercard_number'];
    employmentNumber = json['employment_number'];
  }

  String? name;
  String? address;
  String? gender;
  String? contact1;
  String? photo;
  String? email;
  String? schoolJoining;
  String? dob;
  String? pancardNumber;
  String? drivinglicenceNumber;
  String? gpfNumber;
  String? cpfNumber;
  String? seniorityNumber;
  String? mandaniNumber;
  String? bankaccountNumber;
  String? bankName;
  String? bankBranch;
  String? branchCode;
  String? votercardNumber;
  String? employmentNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['address'] = address;
    map['gender'] = gender;
    map['contact1'] = contact1;
    map['photo'] = photo;
    map['email'] = email;
    map['school_joining'] = schoolJoining;
    map['dob'] = dob;
    map['pancard_number'] = pancardNumber;
    map['drivinglicence_number'] = drivinglicenceNumber;
    map['gpf_number'] = gpfNumber;
    map['cpf_number'] = cpfNumber;
    map['seniority_number'] = seniorityNumber;
    map['mandani_number'] = mandaniNumber;
    map['bankaccount_number'] = bankaccountNumber;
    map['bank_name'] = bankName;
    map['bank_branch'] = bankBranch;
    map['branch_code'] = branchCode;
    map['votercard_number'] = votercardNumber;
    map['employment_number'] = employmentNumber;
    return map;
  }
}
