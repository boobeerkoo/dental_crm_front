import 'package:dental_crm_flutter_front/repositories/user/models/user.dart';
import 'package:dental_crm_flutter_front/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitialState()) {
    on<FetchUserEvent>((event, emit) async {
      emit(UserLoadignState());
      try {
        User user = await userRepository.me();
        emit(UserLoadedState(user: user));
      } catch (error) {
        emit(UserErrorState('Failed to load user: $error'));
      }
    });
  }
}
