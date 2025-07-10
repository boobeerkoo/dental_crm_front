class SaveTreatmentRequest {
  final int patientId;
  final int doctorId;
  final String type;
  final String comment;

  SaveTreatmentRequest({
    required this.patientId,
    required this.doctorId,
    required this.type,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'doctor_id': doctorId,
      'type': type,
      'comment': comment,
    };
  }
}

class SaveTreatmentResponse {
  final int id;
  final int patientId;
  final int doctorId;
  final String type;
  final String comment;
  final DateTime createdDate;
  final DateTime updatedDate;

  SaveTreatmentResponse({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.type,
    required this.comment,
    required this.createdDate,
    required this.updatedDate,
  });

  factory SaveTreatmentResponse.fromJson(Map<String, dynamic> json) {
    return SaveTreatmentResponse(
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
