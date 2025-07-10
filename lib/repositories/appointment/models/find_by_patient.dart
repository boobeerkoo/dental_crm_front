import 'package:dental_crm_flutter_front/repositories/appointment/models/models.dart';

class FindByPatientIdResponse {
  final List<Appointment> appointments;

  FindByPatientIdResponse({required this.appointments});

  factory FindByPatientIdResponse.fromJson(List<dynamic> json) {
    final appointments =
        json.map((data) => Appointment.fromJson(data)).toList();
    return FindByPatientIdResponse(appointments: appointments);
  }
}
