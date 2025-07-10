
import 'package:dental_crm_flutter_front/repositories/treatment/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/treatment/treatment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'treatment_event.dart';

part 'treatment_state.dart';

class TreatmentBloc extends Bloc<TreatmentEvent, TreatmentState> {
  final TreatmentRepository treatmentRepository;

  TreatmentBloc(this.treatmentRepository) : super(TreatmentInitial()) {
    on<TreatmentInitialEvent>((event, emit) async {
      emit(TreatmentLoadingState());
    });

    on<SaveTreatmentEvent>((event, emit) async {
      emit(TreatmentLoadingState());
      try {
        final treatment =
            await treatmentRepository.saveTreatment(event.request);
        emit(TreatmentSavedState(treatment));
      } catch (error) {
        emit(TreatmentErrorState(error.toString()));
      }
    });

    on<UpdateTreatmentEvent>((event, emit) async {
      emit(TreatmentLoadingState());
      try {
        final treatment =
            await treatmentRepository.updateTreatment(event.id, event.request);
        emit(TreatmentUpdatedState(treatment));
        emit(TreatmentLoadedState(treatment));
      } catch (error) {
        emit(TreatmentErrorState(error.toString()));
      }
    });

    on<GetTreatmentsEvent>((event, emit) async {
      emit(TreatmentLoadingState());
      try {
        final treatments = await treatmentRepository.getTreatmentsList();
        emit(TreatmentsLoadedState(treatments));
      } catch (error) {
        emit(TreatmentErrorState(error.toString()));
      }
    });

    on<GetTreatmentByIdEvent>((event, emit) async {
      emit(TreatmentLoadingState());
      try {
        final treatment = await treatmentRepository.getTreatmentById(event.id);
        emit(TreatmentLoadedState(treatment));
      } catch (error) {
        emit(TreatmentErrorState(error.toString()));
      }
    });

    on<GetTreatmentsByPatientIdEvent>((event, emit) async {
      emit(TreatmentLoadingState());
      try {
        final treatments =
            await treatmentRepository.getTreatmentsByPatientId(event.patientId);
        emit(TreatmentsLoadedState(treatments));
      } catch (error) {
        emit(TreatmentErrorState(error.toString()));
      }
    });

    on<DeleteTreatmentEvent>((event, emit) async {
      emit(TreatmentLoadingState());
      try {
        await treatmentRepository.deleteTreatment(event.id);
        emit(TreatmentDeletedState());
      } catch (error) {
        emit(TreatmentDeleteErrorState(error.toString()));
      }
    });
  }
}
