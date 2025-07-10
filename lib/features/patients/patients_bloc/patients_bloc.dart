import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final PatientRepository patientRepository;
  PatientsBloc(this.patientRepository) : super(PatientsInitial()) {
    on<PatientInitialEvent>((event, emit) async {
      emit(PatientLoadingState());
    });

    on<SavePatientEvent>((event, emit) async {
      emit(PatientLoadingState());
      try {
        final patient = await patientRepository.savePatient(event.request);
        emit(PatientLoadedState(patient));
      } catch (error) {
        emit(PatientErrorState(error.toString()));
      }
    });

    on<UpdatePatientEvent>((event, emit) async {
      emit(PatientLoadingState());
      try {
        final patient =
            await patientRepository.updatePatient(event.id, event.request);
        emit(PatientUpdatedState(patient));
        emit(PatientLoadedState(patient));
      } catch (error) {
        emit(PatientErrorState(error.toString()));
      }
    });

    on<GetPatientsEvent>((event, emit) async {
      emit(PatientLoadingState());
      try {
        final patients = await patientRepository.getPatients();
        emit(PatientsLoadedState(patients));
      } catch (error) {
        emit(PatientErrorState(error.toString()));
      }
    });

    on<GetPatientByIdEvent>((event, emit) async {
      emit(PatientLoadingState());
      try {
        final patient = await patientRepository.getPatientById(event.id);
        emit(PatientLoadedState(patient));
      } catch (error) {
        emit(PatientErrorState(error.toString()));
      }
    });

    on<DeletePatientEvent>((event, emit) async {
      emit(PatientLoadingState());
      try {
        await patientRepository.deletePatient(event.id);
        emit(PatientDeletedState());
      } catch (error) {
        emit(PatientDeleteErrorState(error.toString()));
      }
    });
  }
}
