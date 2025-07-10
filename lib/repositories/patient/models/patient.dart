class Patient {
  int id;
  String name;
  String phone1;
  String phone2;
  String address;
  String email;
  String sex;
  String importantInfo;
  String comment;
  DateTime dateOfBirth;
  DateTime createdDate;
  DateTime updatedDate;

  Patient({
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

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
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

class Patients {
  List<Patient> items;
  int total;
  int pages;

  Patients({
    required this.items,
    required this.total,
    required this.pages,
  });

  factory Patients.fromJson(Map<String, dynamic> json) {
    List<Patient> patientList =
        (json['items'] as List).map((item) => Patient.fromJson(item)).toList();

    return Patients(
      items: patientList,
      total: json['total'],
      pages: json['pages'],
    );
  }
}
