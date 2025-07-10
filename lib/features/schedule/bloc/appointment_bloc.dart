import 'package:dental_crm_flutter_front/repositories/appointment/appointment_repository.dart';
import 'package:dental_crm_flutter_front/repositories/appointment/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointment_event.dart';

part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository;

  AppointmentBloc(this.appointmentRepository) : super(AppointmentInitial()) {
    on<AppointmentInitialEvent>((event, emit) {
      emit(AppointmentLoadingState());
    });

    on<SaveAppointmentEvent>((event, emit) async {
      emit(AppointmentLoadingState());
      try {
        final appointment =
        await appointmentRepository.saveAppointment(event.request);
        emit(AppointmentSavedState(appointment));
      } catch (error) {
        emit(AppointmentErrorState(error.toString()));
      }
    });

    on<UpdateAppointmentEvent>((event, emit) async {
      emit(AppointmentLoadingState());
      try {
        final appointment = await appointmentRepository.updateAppointment(
            event.id, event.request);
        emit(AppointmentUpdatedState(appointment));
        emit(AppointmentLoadedState(appointment));
      } catch (error) {
        emit(AppointmentErrorState(error.toString()));
      }
    });

    on<GetAppointmentsEvent>((event, emit) async {
      emit(AppointmentLoadingState());
      try {
        final appointments = await appointmentRepository.getAppointmentsList();
        emit(AppointmentsLoadedState(appointments));
      } catch (error) {
        emit(AppointmentErrorState(error.toString()));
      }
    });

    on<GetAppointmentByIdEvent>((event, emit) async {
      emit(AppointmentLoadingState());
      try {
        final appointment =
        await appointmentRepository.getAppointmentById(event.id);
        emit(AppointmentLoadedState(appointment));
      } catch (error) {
        emit(AppointmentErrorState(error.toString()));
      }
    });

    on<GetAppointmentByPatientIdEvent>((event, emit) async {
      emit(AppointmentLoadingState());
      try {
        final appointments = await appointmentRepository
            .getAppointmentsByPatientId(event.patientId);
        emit(AppointmentsLoadedState(appointments));
      } catch (error) {
        emit(AppointmentErrorState(error.toString()));
      }
    });

    on<DeleteAppointmentEvent>((event, emit) async {
      try {
        await appointmentRepository.deleteAppointment(event.id);
        emit(AppointmentDeletedState());
      } catch (error) {
        emit(AppointmentErrorState(error.toString()));
      }
    });
  }
}
