part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

}

class AppointmentInitialEvent extends AppointmentEvent {
  @override
  List<Object?> get props => [];
}

class SaveAppointmentEvent extends AppointmentEvent {
  final SaveAppointmentRequest request;

  const SaveAppointmentEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class UpdateAppointmentEvent extends AppointmentEvent {
  final int id;
  final UpdateAppointmentRequest request;

  const UpdateAppointmentEvent(this.id, this.request);

  @override
  List<Object?> get props => [id, request];
}

class GetAppointmentsEvent extends AppointmentEvent {
  @override
  List<Object?> get props => [];
}

class GetAppointmentByIdEvent extends AppointmentEvent {
  final int id;

  const GetAppointmentByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetAppointmentByPatientIdEvent extends AppointmentEvent {
  final int patientId;

  const GetAppointmentByPatientIdEvent(this.patientId);

  @override
  List<Object?> get props => [patientId];
}

class DeleteAppointmentEvent extends AppointmentEvent {
  final int id;

  const DeleteAppointmentEvent(this.id);

  @override
  List<Object?> get props => [id];
}
