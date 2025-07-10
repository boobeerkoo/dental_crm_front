part of 'patients_bloc.dart';

abstract class PatientsState extends Equatable {
  const PatientsState();

}

class PatientsInitial extends PatientsState {
  @override
  List<Object?> get props => [];
}

class PatientLoadingState extends PatientsState {
  @override
  List<Object?> get props => [];
}

class PatientLoadedState extends PatientsState {
  final Patient patient;

  const PatientLoadedState(this.patient);

  @override
  List<Object?> get props => [patient];
}

class PatientsLoadedState extends PatientsState {
  final Patients patients;

  const PatientsLoadedState(this.patients);

  @override
  List<Object?> get props => [patients];
}

class PatientUpdatedState extends PatientsState {
  final Patient patient;

  const PatientUpdatedState(this.patient);

  @override
  List<Object?> get props => [patient];
}

class PatientDeletedState extends PatientsState {
  @override
  List<Object?> get props => [];
}

class PatientErrorState extends PatientsState {
  final String errorMessage;

  const PatientErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class PatientDeleteErrorState extends PatientsState {
  final String errorMessage;

  const PatientDeleteErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
