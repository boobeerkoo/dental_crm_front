import 'package:dental_crm_flutter_front/repositories/patient/models/patient.dart';

class ListResponse {
  final List<Patient> items;
  final int total;
  final int pages;

  ListResponse({
    required this.items,
    required this.total,
    required this.pages,
  });

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    List<Patient> patientList =
        (json['items'] as List).map((item) => Patient.fromJson(item)).toList();

    return ListResponse(
      items: patientList,
      total: json['total'],
      pages: json['pages'],
    );
  }
}
