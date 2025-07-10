part of 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStared extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;

  const LoggedIn({required this.token});
  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return 'LoggedIN {token: $token}';
  }
}

class LoggedOut extends AuthEvent {}

class RegistrationEvent extends AuthEvent {
  final RegistrationRequest registrationRequest;

  const RegistrationEvent(this.registrationRequest);

  @override
  List<Object> get props => [registrationRequest];

  @override
  String toString() {
    return 'RegistrationEvent {registrationRequest: ${registrationRequest.name}, ${registrationRequest.email}, ${registrationRequest.password},}';
  }
}

class LoginEvent extends AuthEvent {
  final LoginRequest loginRequest;

  const LoginEvent(this.loginRequest);

  @override
  List<Object> get props => [loginRequest];

  @override
  String toString() {
    return 'LoginEvent {loginRequest: ${loginRequest.email}, ${loginRequest.password}}';
  }
}
