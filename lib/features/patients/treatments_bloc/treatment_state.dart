part of 'treatment_bloc.dart';

abstract class TreatmentState extends Equatable {
  const TreatmentState();
}

class TreatmentInitial extends TreatmentState {
  @override
  List<Object> get props => [];
}

class TreatmentLoadingState extends TreatmentState {
  @override
  List<Object?> get props => [];
}

class TreatmentLoadedState extends TreatmentState {
  final Treatment treatment;

  const TreatmentLoadedState(this.treatment);

  @override
  List<Object?> get props => [treatment];
}

class TreatmentsLoadedState extends TreatmentState {
  final Treatments treatments;

  const TreatmentsLoadedState(this.treatments);

  @override
  List<Object?> get props => [treatments];
}

class TreatmentSavedState extends TreatmentState {
  final Treatment treatment;

  const TreatmentSavedState(this.treatment);

  @override
  List<Object?> get props => [treatment];
}

class TreatmentUpdatedState extends TreatmentState {
  final Treatment treatment;

  const TreatmentUpdatedState(this.treatment);

  @override
  List<Object?> get props => [treatment];
}

class TreatmentDeletedState extends TreatmentState {
  @override
  List<Object?> get props => [];
}

class TreatmentErrorState extends TreatmentState {
  final String errorMessage;

  const TreatmentErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class TreatmentDeleteErrorState extends TreatmentState {
  final String errorMessage;

  const TreatmentDeleteErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
