class Treatment {
  final int id;
  final int patientId;
  final int doctorId;
  final String type;
  final String comment;
  final DateTime createdDate;
  final DateTime updatedDate;

  Treatment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.type,
    required this.comment,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      type: json['type'],
      comment: json['comment'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }
}

class Treatments {
  final List<Treatment> treatments;

  Treatments({required this.treatments});

  factory Treatments.fromJson(List<dynamic> json) {
    List<Treatment> treatments =
        json.map((item) => Treatment.fromJson(item)).toList();
    return Treatments(treatments: treatments);
  }
}
