import 'package:dental_crm_flutter_front/repositories/appointment/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppointmentRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static String mainUrl =
      "http://localhost:8081/api/v1";

  Future<Appointment> saveAppointment(SaveAppointmentRequest request) async {
    final url = '$mainUrl/appointments';
    final token = await storage.read(key: 'token');

    final response = await _dio.post(
      url,
      data: request.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Appointment.fromJson(response.data);
  }

  Future<Appointment> updateAppointment(
      int id, UpdateAppointmentRequest request) async {
    final url = '$mainUrl/appointments/$id';
    final token = await storage.read(key: 'token');

    final response = await _dio.put(
      url,
      data: request.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Appointment.fromJson(response.data);
  }

  Future<Appointments> getAppointmentsList() async {
    final url = '$mainUrl/appointments';

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

    return Appointments.fromJson(response.data);
  }

  Future<Appointment> getAppointmentById(int id) async {
    final url = '$mainUrl/appointments/$id';
    final token = await storage.read(key: 'token');

    final response = await _dio.get(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Appointment.fromJson(response.data);
  }

  Future<Appointments> getAppointmentsByPatientId(int patientId) async {
    final url = '$mainUrl/appointments/byPatient/$patientId';
    final token = await storage.read(key: 'token');

    final response = await _dio.get(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Appointments.fromJson(response.data);
  }

  Future<void> deleteAppointment(int id) async {
    final url = '$mainUrl/appointments/$id';
    final token = await storage.read(key: 'token');

    await _dio.delete(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
