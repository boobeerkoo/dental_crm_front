import 'package:dental_crm_flutter_front/repositories/treatment/models/models.dart';

class ShowListResponse {
  final List<Treatment> treatments;

  ShowListResponse({required this.treatments});

  factory ShowListResponse.fromJson(List<dynamic> json) {
    List<Treatment> treatments =
        json.map((data) => Treatment.fromJson(data)).toList();
    return ShowListResponse(treatments: treatments);
  }
}
