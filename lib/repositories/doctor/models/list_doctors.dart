import 'package:dental_crm_flutter_front/repositories/doctor/models/doctor.dart';

class ShowListResponse {
  final List<Doctor> doctors;

  ShowListResponse({required this.doctors});

  factory ShowListResponse.fromJson(List<dynamic> json) {
    List<Doctor> doctors = json.map((data) => Doctor.fromJson(data)).toList();
    return ShowListResponse(doctors: doctors);
  }
}
