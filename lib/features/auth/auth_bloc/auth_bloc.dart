import 'package:dental_crm_flutter_front/repositories/auth/auth_repository.dart';
import 'package:dental_crm_flutter_front/repositories/auth/models/models.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AppStared>((event, emit) async {
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await authRepository.persisToken(event.token);
      emit(AuthAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await authRepository.deleteToken();
      emit(AuthUnauthenticated());
    });

    on<RegistrationEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final response =
            await authRepository.register(event.registrationRequest);
        final token = response.token;
        add(LoggedIn(token: token));
        emit(AuthSuccess(response));
      } catch (error) {
        emit(AuthFailure(error: 'Failed to register: $error'));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await authRepository.login(event.loginRequest);
        final token = response.token;
        add(LoggedIn(token: token));
        emit(AuthSuccess(response));
      } catch (error) {
        emit(AuthFailure(error: 'Failed to login: $error'));
      }
    });
  }
}
