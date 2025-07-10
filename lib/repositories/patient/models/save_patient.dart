class SaveRequest {
  final String name;
  final String phone;
  final String phone2;
  final String address;
  final String email;
  final String sex;
  final String importantInfo;
  final String comment;
  final String dateOfBirth;

  SaveRequest({
    required this.name,
    required this.phone,
    required this.phone2,
    required this.address,
    required this.email,
    required this.sex,
    required this.importantInfo,
    required this.comment,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'phone2': phone2,
      'address': address,
      'email': email,
      'sex': sex,
      'important_info': importantInfo,
      'comment': comment,
      'date_of_birth': dateOfBirth,
    };
  }
}

class SaveResponse {
  final int id;
  final String name;
  final String phone1;
  final String phone2;
  final String address;
  final String email;
  final String sex;
  final String importantInfo;
  final String comment;
  final DateTime dateOfBirth;
  final DateTime createdDate;
  final DateTime updatedDate;

  SaveResponse({
    required this.id,
    required this.name,
    required this.phone1,
    required this.phone2,
    required this.address,
    required this.email,
    required this.sex,
    required this.importantInfo,
    required this.comment,
    required this.dateOfBirth,
    required this.createdDate,
    required this.updatedDate,
  });

  factory SaveResponse.fromJson(Map<String, dynamic> json) {
    return SaveResponse(
      id: json['id'],
      name: json['name'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      address: json['address'],
      email: json['email'],
      sex: json['sex'],
      importantInfo: json['important_info'],
      comment: json['comment'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }
}
