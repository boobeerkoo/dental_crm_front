import 'package:dental_crm_flutter_front/repositories/doctor/models/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DoctorRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static String mainUrl =
      "https://dental-crm-back.onrender.com";

  Future<Doctor> saveDoctor(SaveDoctorRequest request) async {
    final url = '$mainUrl/doctors';
    final token = await storage.read(key: 'token');

    final response = await _dio.post(
      url,
      data: request.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Doctor.fromJson(response.data);
  }

  Future<Doctor> updateDoctor(int id, UpdateDoctorRequest request) async {
    final url = '$mainUrl/doctors/$id';
    final token = await storage.read(key: 'token');

    final response = await _dio.put(
      url,
      data: request.toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Doctor.fromJson(response.data);
  }

  Future<Doctors> getDoctors() async {
    final url = '$mainUrl/doctors';

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

    return Doctors.fromJson(response.data);
  }

  Future<Doctor> getDoctorById(int id) async {
    final url = '$mainUrl/doctors/$id';
    final token = await storage.read(key: 'token');

    final response = await _dio.get(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Doctor.fromJson(response.data);
  }

  Future<void> deleteDoctor(int id) async {
    final url = '$mainUrl/doctors/$id';
    final token = await storage.read(key: 'token');

    await _dio.delete(
      url,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
