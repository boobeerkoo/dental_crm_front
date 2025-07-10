part of 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final dynamic response;

  AuthSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}
