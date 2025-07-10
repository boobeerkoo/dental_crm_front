import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';

abstract class AbstractPatientRepository {
  Future<Patient> savePatient(SaveRequest request);
  Future<Patient> updatePatient(UpdateRequest request);
  Future<Patients> getPatients();
  Future<Patient> getPatientById(int id);
  Future<void> deletePatient(int id);
}
