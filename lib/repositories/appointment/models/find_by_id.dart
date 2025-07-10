class FindByIdResponse {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime appointmentDate;
  final Duration duration;
  final String status;
  final String comment;
  final DateTime createdDate;
  final DateTime updatedDate;

  FindByIdResponse({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.duration,
    required this.status,
    required this.comment,
    required this.createdDate,
    required this.updatedDate,
  });

  factory FindByIdResponse.fromJson(Map<String, dynamic> json) {
    return FindByIdResponse(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      duration: _parseDuration(json['duration']),
      status: json['status'],
      comment: json['comment'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }

  static Duration _parseDuration(String durationString) {
    final parts = durationString.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final seconds = int.parse(parts[2].split('s')[0]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
