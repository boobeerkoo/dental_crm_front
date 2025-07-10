import 'package:dental_crm_flutter_front/repositories/treatment/models/models.dart';

abstract class AbstractTreatmentRepository {
  Future<Treatment> saveTreatment(SaveTreatmentRequest request);
  Future<Treatment> updateTreatment(int id, UpdateTreatmentRequest request);
  Future<Treatments> getTreatmentsList();
  Future<Treatment> getTreatmentById(int id);
  Future<Treatments> getTreatmentsByPatientId(int patientId);
  Future<void> deleteTreatment(int id);
}
