import 'package:dental_crm_flutter_front/repositories/user/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static String mainUrl =
      "http://localhost:8081/api/v1";

  var meUrl = '$mainUrl/users';
  var updateUrl = '$mainUrl/update';
  var deleteUrl = '$mainUrl/users';

  Future<User> me() async {
    try {
      var value = await storage.read(key: 'token');
      final options = Options(
        headers: {
          'Authorization': 'Bearer $value',
        },
      );

      final response = await _dio.get(meUrl, options: options);
      final user = User.fromJson(response.data);

      return user;
    } catch (error) {
      throw Exception('Failed to get user: $error');
    }
  }
}
