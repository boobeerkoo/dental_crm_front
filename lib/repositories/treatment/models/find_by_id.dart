class FindByIdResponse {
  final int id;
  final int patientId;
  final int doctorId;
  final String type;
  final String comment;
  final DateTime createdDate;
  final DateTime updatedDate;

  FindByIdResponse({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.type,
    required this.comment,
    required this.createdDate,
    required this.updatedDate,
  });

  factory FindByIdResponse.fromJson(Map<String, dynamic> json) {
    return FindByIdResponse(
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
