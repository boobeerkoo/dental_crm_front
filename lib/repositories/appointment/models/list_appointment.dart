import 'package:dental_crm_flutter_front/repositories/appointment/models/models.dart';

class ShowListResponse {
  final List<Appointment> appointments;

  ShowListResponse({required this.appointments});

  factory ShowListResponse.fromJson(List<dynamic> json) {
    List<Appointment> appointments =
        json.map((data) => Appointment.fromJson(data)).toList();
    return ShowListResponse(appointments: appointments);
  }
}
