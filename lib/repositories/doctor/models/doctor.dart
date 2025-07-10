class Doctor {
  int id;
  String name;
  String phone1;
  String phone2;
  String sex;
  String specialization;
  int userId;
  DateTime createdDate;
  DateTime updatedDate;

  Doctor({
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

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
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

class Doctors {
  final List<Doctor> items;

  Doctors({required this.items});

  factory Doctors.fromJson(List<dynamic> json) {
    List<Doctor> appointments =
        json.map((data) => Doctor.fromJson(data)).toList();
    return Doctors(items: appointments);
  }
}
