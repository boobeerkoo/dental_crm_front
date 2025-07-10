part of 'treatment_bloc.dart';

abstract class TreatmentEvent extends Equatable {
  const TreatmentEvent();
}

class TreatmentInitialEvent extends TreatmentEvent {
  @override
  List<Object> get props => [];
}

class SaveTreatmentEvent extends TreatmentEvent {
  final SaveTreatmentRequest request;

  const SaveTreatmentEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class UpdateTreatmentEvent extends TreatmentEvent {
  final int id;
  final UpdateTreatmentRequest request;

  const UpdateTreatmentEvent(this.id, this.request);

  @override
  List<Object?> get props => [id, request];
}

class GetTreatmentsEvent extends TreatmentEvent {
  @override
  List<Object?> get props => [];
}

class GetTreatmentsByPatientIdEvent extends TreatmentEvent {
  final int patientId;

  const GetTreatmentsByPatientIdEvent(this.patientId);

  @override
  List<Object?> get props => [patientId];
}

class GetTreatmentByIdEvent extends TreatmentEvent {
  final int id;

  const GetTreatmentByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteTreatmentEvent extends TreatmentEvent {
  final int id;

  const DeleteTreatmentEvent(this.id);

  @override
  List<Object?> get props => [id];
}
