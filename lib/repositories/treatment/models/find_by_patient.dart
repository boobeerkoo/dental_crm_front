import 'package:dental_crm_flutter_front/repositories/treatment/models/models.dart';

class FindByPatientIdResponse {
  final List<Treatment> treatments;

  FindByPatientIdResponse({
    required this.treatments,
  });

  factory FindByPatientIdResponse.fromJson(List<dynamic> json) {
    final treatments =
        json.map((treatment) => Treatment.fromJson(treatment)).toList();
    return FindByPatientIdResponse(
      treatments: treatments,
    );
  }
}
