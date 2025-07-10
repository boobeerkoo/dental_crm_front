class SaveDoctorRequest {
  final String name;
  final String phone;
  final String phone2;
  final String sex;
  final String specialization;
  final int userId;

  SaveDoctorRequest({
    required this.name,
    required this.phone,
    required this.phone2,
    required this.sex,
    required this.specialization,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'phone2': phone2,
      'sex': sex,
      'specialization': specialization,
      'user_id': userId,
    };
  }
}

class SaveDoctorResponse {
  final int id;
  final String name;
  final String phone1;
  final String phone2;
  final String sex;
  final String specialization;
  final int userId;
  final DateTime createdDate;
  final DateTime updatedDate;

  SaveDoctorResponse({
    required this.id,
    required this.name,
    required this.phone1,
    required this.phone2,
    required this.sex,
    required this.specialization,
    required this.userId,
    required this.createdDate,
    required this.updatedDate,
  });

  factory SaveDoctorResponse.fromJson(Map<String, dynamic> json) {
    return SaveDoctorResponse(
      id: json['id'],
      name: json['name'],
      phone1: json['phone1'],
      phone2: json['phone2'],
      sex: json['sex'],
      specialization: json['specialization'],
      userId: json['user_id'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }
}
