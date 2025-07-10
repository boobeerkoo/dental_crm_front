import 'package:dental_crm_flutter_front/repositories/auth/models/models.dart';

class RegistrationRequest {
  final String name;
  final String email;
  final String password;

  RegistrationRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class RegistrationResponse {
  final String token;
  final User user;

  RegistrationResponse({
    required this.token,
    required this.user,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
