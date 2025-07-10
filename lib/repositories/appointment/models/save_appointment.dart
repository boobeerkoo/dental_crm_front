class SaveAppointmentRequest {
  final int patientId;
  final int doctorId;
  final String appointmentDate;
  final Duration duration;
  final String status;
  final String comment;

  SaveAppointmentRequest({
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.duration,
    required this.status,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_date': appointmentDate,
      'duration': _formatDuration(duration),
      'status': status,
      'comment': comment,
    };
  }

  String _formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${hours}h${minutes}m${seconds}s';
  }
}

class SaveAppointmentResponse {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime appointmentDate;
  final Duration duration;
  final String status;
  final String comment;
  final DateTime createdDate;
  final DateTime updatedDate;

  SaveAppointmentResponse({
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

  factory SaveAppointmentResponse.fromJson(Map<String, dynamic> json) {
    return SaveAppointmentResponse(
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
    List<String> parts = durationString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
