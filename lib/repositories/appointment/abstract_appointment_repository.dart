import 'package:dental_crm_flutter_front/repositories/appointment/models/models.dart';

abstract class AbstractAppointmentRepository {
  Future<Appointment> saveAppointment(SaveAppointmentRequest request);
  Future<Appointment> updateAppointment(UpdateAppointmentRequest request);
  Future<Appointment> getAppointmentById(int id);
  Future<Appointments> getAppointmentsList();
  Future<Appointments> getAppointmentsByPatientId(int patientId);
  Future<void> deleteAppointment(int id);
}
