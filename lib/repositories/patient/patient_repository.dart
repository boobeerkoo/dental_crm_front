import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PatientRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static String mainUrl =
      "http://localhost:8081/api/v1";

  Future<Patient> savePatient(SaveRequest request) async {
    final url = '$mainUrl/patients';
    final token = await storage.read(key: 'token');

    final response = await _dio.post(
      url,
      data: request.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Patient.fromJson(response.data);
  }

  Future<Patient> updatePatient(int id, UpdateRequest request) async {
    final url = '$mainUrl/patients/$id';
    final token = await storage.read(key: 'token');

    final response = await _dio.put(
      url,
      data: request.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Patient.fromJson(response.data);
  }

  Future<Patients> getPatients() async {
    final url = '$mainUrl/patients';

    var value = await storage.read(key: 'token');
    final options = Options(
      headers: {
        'Authorization': 'Bearer $value',
      },
    );

    final response = await _dio.get(
      url,
      options: options,
    );

    return Patients.fromJson(response.data);
  }

  Future<Patient> getPatientById(int id) async {
    final url = '$mainUrl/patients/$id';
    final token = await storage.read(key: 'token');

    final response = await _dio.get(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Patient.fromJson(response.data);
  }

  Future<void> deletePatient(int id) async {
    final url = '$mainUrl/patients/$id';
    final token = await storage.read(key: 'token');

    await _dio.delete(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
