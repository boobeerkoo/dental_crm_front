part of 'patients_bloc.dart';

abstract class PatientsEvent extends Equatable {
  const PatientsEvent();
}

class PatientInitialEvent extends PatientsEvent {
  @override
  List<Object?> get props => [];
}

class SavePatientEvent extends PatientsEvent {
  final SaveRequest request;

  const SavePatientEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class UpdatePatientEvent extends PatientsEvent {
  final int id;
  final UpdateRequest request;

  const UpdatePatientEvent(this.id, this.request);

  @override
  List<Object?> get props => [id, request];
}

class GetPatientsEvent extends PatientsEvent {
  @override
  List<Object?> get props => [];
}

class GetPatientByIdEvent extends PatientsEvent {
  final int id;

  const GetPatientByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeletePatientEvent extends PatientsEvent {
  final int id;

  const DeletePatientEvent(this.id);

  @override
  List<Object?> get props => [id];
}
