part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();
}

class AppointmentInitial extends AppointmentState {
  @override
  List<Object> get props => [];
}

class AppointmentLoadingState extends AppointmentState {
  @override
  List<Object?> get props => [];
}

class AppointmentLoadedState extends AppointmentState {
  final Appointment appointment;

  const AppointmentLoadedState(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class AppointmentsLoadedState extends AppointmentState {
  final Appointments appointments;

  const AppointmentsLoadedState(this.appointments);

  @override
  List<Object?> get props => [appointments];
}

class AppointmentSavedState extends AppointmentState {
  final Appointment appointment;

  const AppointmentSavedState(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class AppointmentUpdatedState extends AppointmentState {
  final Appointment appointment;

  const AppointmentUpdatedState(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class AppointmentDeletedState extends AppointmentState {
  @override
  List<Object?> get props => [];
}

class AppointmentErrorState extends AppointmentState {
  final String errorMessage;

  const AppointmentErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
