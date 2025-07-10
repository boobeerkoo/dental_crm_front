import 'package:dental_crm_flutter_front/repositories/auth/models/models.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final Dio _dio = Dio();
  static String mainUrl =
      "http://localhost:8081/api/v1/auth";
  var loginUrl = "$mainUrl/login";
  var registerUrl = "$mainUrl/register";

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persisToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<RegistrationResponse> register(RegistrationRequest request) async {
    try {
      final response = await _dio.post(
        registerUrl,
        data: request.toJson(),
      );
      final registrationResponse = RegistrationResponse.fromJson(response.data);

      return registrationResponse;
    } catch (error) {
      throw Exception('Failed to register: $error');
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        loginUrl,
        data: request.toJson(),
      );
      final loginResponse = LoginResponse.fromJson(response.data);

      return loginResponse;
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  // Future<bool> checkAuthStatus() async {
  //   final token = await TokenManager.getToken();
  //   // Перевірка статусу авторизації за наявності токену
  //   return token.isNotEmpty;
  // }
  // Future<User> register(String email, String password) async {
  //   try {
  //     Response response = await _dio.post(
  //       'https://app-sqlite-aiy3mtkmhq-lm.a.run.app/api/v1/auth/register',
  //       data: {
  //         'email': email,
  //         'password': password,
  //       },
  //     );
  //     return User.fromJson(response.data);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future<User> login(String email, String password) async {
  //   try {
  //     Response response = await _dio.post(
  //       'https://app-sqlite-aiy3mtkmhq-lm.a.run.app/api/v1/auth/login',
  //       data: {
  //         'email': email,
  //         'password': password,
  //       },
  //     );
  //     return User.fromJson(response.data);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
}
