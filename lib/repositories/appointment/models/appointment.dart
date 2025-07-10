class Appointment {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime appointmentDate;
  final Duration duration;
  final String status;
  final String comment;
  final DateTime createdDate;
  final DateTime updatedDate;

  Appointment({
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

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      duration: Duration(
        hours: int.parse(json['duration'].split(':')[0]),
        minutes: int.parse(json['duration'].split(':')[1]),
        seconds: int.parse(json['duration'].split(':')[2]),
      ),
      status: json['status'],
      comment: json['comment'],
      createdDate: DateTime.parse(json['created_date']),
      updatedDate: DateTime.parse(json['updated_date']),
    );
  }
}

class Appointments {
  final List<Appointment> items;

  Appointments({required this.items});

  factory Appointments.fromJson(List<dynamic> json) {
    List<Appointment> appointments =
        json.map((data) => Appointment.fromJson(data)).toList();
    return Appointments(items: appointments);
  }
}
