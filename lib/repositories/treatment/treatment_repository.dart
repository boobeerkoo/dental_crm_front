import 'package:dental_crm_flutter_front/repositories/treatment/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TreatmentRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static String mainUrl =
      "https://dental-crm-back.onrender.com";

  Future<Treatment> saveTreatment(SaveTreatmentRequest request) async {
    final url = '$mainUrl/treatments';
    final token = await storage.read(key: 'token');

    try {
      final response = await _dio.post(
        url,
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Treatment.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to save treatment: $error');
    }
  }

  Future<Treatment> updateTreatment(
      int id, UpdateTreatmentRequest request) async {
    final url = '$mainUrl/treatments/$id';
    final token = await storage.read(key: 'token');

    try {
      final response = await _dio.put(
        url,
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Treatment.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to update treatment: $error');
    }
  }

  Future<Treatments> getTreatmentsList() async {
    final url = '$mainUrl/treatments';

    try {
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

      return Treatments.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to get treatments list: $error');
    }
  }

  Future<Treatment> getTreatmentById(int id) async {
    final url = '$mainUrl/treatments/$id';
    final token = await storage.read(key: 'token');

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Treatment.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to get treatment by ID: $error');
    }
  }

  Future<Treatments> getTreatmentsByPatientId(int patientId) async {
    final url = '$mainUrl/treatments/byPatient/$patientId';
    final token = await storage.read(key: 'token');

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Treatments.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to get treatments by patient ID: $error');
    }
  }

  Future<void> deleteTreatment(int id) async {
    final url = '$mainUrl/treatments/$id';
    final token = await storage.read(key: 'token');

    try {
      await _dio.delete(
        url,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (error) {
      throw Exception('Failed to delete treatment: $error');
    }
  }
}
