import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class CustomAppointmentDataSource extends CalendarDataSource {
  CustomAppointmentDataSource(List<CustomAppointment> appointments) {
    this.appointments = appointments;
  }

  @override
  List<CustomAppointment> get appointments =>
      super.appointments as List<CustomAppointment>;

  void addAppointment(CustomAppointment appointment) {
    appointments.add(appointment);
    notifyListeners(
        CalendarDataSourceAction.add, <CustomAppointment>[appointment]);
  }

  void removeAppointment(CustomAppointment appointment) {
    appointments.remove(appointment);
    notifyListeners(
        CalendarDataSourceAction.remove, <CustomAppointment>[appointment]);
  }
}

class CustomAppointment extends Appointment {
  final int appointmentId;
  final String patientName;
  final String doctorName;
  final String comment;

  CustomAppointment({
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
    required Color color,
    required this.appointmentId,
    required this.patientName,
    required this.doctorName,
    required this.comment,
  }) : super(
          startTime: startTime,
          endTime: endTime,
          subject: subject,
          color: color,
        );
}

Widget appointmentBuilder(
    BuildContext context, CalendarAppointmentDetails details) {
  final CustomAppointment appointment = details.appointments.first;
  final Duration duration =
      appointment.endTime.difference(appointment.startTime);
  return Container(
    color: appointment.color,
    padding: const EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (duration >= const Duration(hours: 1, minutes: 5)) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                appointment.startTime.toString().substring(11, 16),
                style: const TextStyle(color: Colors.white),
              ),
              const Text(' - ', style: TextStyle(color: Colors.white)),
              Text(
                appointment.endTime.toString().substring(11, 16),
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(appointment.patientName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          Row(
            children: [
              const Text('Лікар: ', style: TextStyle(color: Colors.white)),
              Text(
                appointment.doctorName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                appointment.comment,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ] else if (duration < const Duration(hours: 1, minutes: 5) &&
            duration >= const Duration(hours: 0, minutes: 40)) ...[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    appointment.startTime.toString().substring(11, 16),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(' - ', style: TextStyle(color: Colors.white)),
                  Text(
                    appointment.endTime.toString().substring(11, 16),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(' ', style: TextStyle(color: Colors.white)),
                  Text(appointment.patientName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const Text('Лікар: ', style: TextStyle(color: Colors.white)),
                  Text(
                    appointment.doctorName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ] else if (duration < const Duration(hours: 0, minutes: 40)) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                appointment.startTime.toString().substring(11, 16),
                style: const TextStyle(color: Colors.white),
              ),
              const Text(' - ', style: TextStyle(color: Colors.white)),
              Text(
                appointment.endTime.toString().substring(11, 16),
                style: const TextStyle(color: Colors.white),
              ),
              const Text(' ', style: TextStyle(color: Colors.white)),
              Text(appointment.patientName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
      ],
    ),
  );
}
