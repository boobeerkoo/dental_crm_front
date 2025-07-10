import 'package:calendar_view/calendar_view.dart';
import 'package:dental_crm_flutter_front/features/schedule/bloc/appointment_bloc.dart';
import 'package:dental_crm_flutter_front/features/schedule/widgets/appointment.dart';
import 'package:dental_crm_flutter_front/repositories/appointment/appointment_repository.dart';
import 'package:dental_crm_flutter_front/repositories/appointment/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/doctor/doctor_repository.dart';
import 'package:dental_crm_flutter_front/repositories/doctor/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TabletSchedule extends StatefulWidget {
  const TabletSchedule({super.key});

  @override
  State<TabletSchedule> createState() => _TabletScheduleState();
}

final CustomAppointmentDataSource tdataSource =
    CustomAppointmentDataSource(tgetAppointments());

List<CustomAppointment> tgetAppointments() {
  List<CustomAppointment> appointments = <CustomAppointment>[];

  return appointments;
}

void taddNewAppointment(
    DateTime startTime,
    DateTime endTime,
    String subject,
    Color color,
    String patientName,
    String doctorName,
    String comment,
    int id) {
  final CustomAppointment appointment = CustomAppointment(
    appointmentId: id,
    startTime: startTime,
    endTime: endTime,
    subject: subject,
    color: color,
    patientName: patientName,
    doctorName: doctorName,
    comment: comment,
  );

  tdataSource.addAppointment(appointment);
}

class _TabletScheduleState extends State<TabletSchedule> {
  AppointmentRepository appointmentRepository = AppointmentRepository();
  late AppointmentBloc appointmentBloc;
  PatientRepository patientRepository = PatientRepository();
  DoctorRepository doctorRepository = DoctorRepository();

  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now().add(const Duration(hours: 1));
  List<Patient> patients = [];
  List<Doctor> doctors = [];
  Patient? selectedPatient;
  Doctor? selectedDoctor;

  String status = 'Заплановано';

  @override
  void initState() {
    super.initState();
    appointmentBloc = AppointmentBloc(AppointmentRepository());
    appointmentBloc.add(GetAppointmentsEvent());
    loadPatients();
    loadDoctors();
  }

  @override
  void dispose() {
    appointmentBloc.close();
    super.dispose();
  }

  void _saveAppointment(BuildContext context) {
    SaveAppointmentRequest request;
    final appointmentBloc = BlocProvider.of<AppointmentBloc>(context);
    final formattedDate =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(selectedDate);
    request = SaveAppointmentRequest(
      appointmentDate: "${formattedDate}Z",
      duration: selectedEndDate.difference(selectedDate),
      status: status,
      patientId: selectedPatient!.id,
      doctorId: selectedDoctor!.id,
      comment: commentController.text,
    );

    appointmentBloc.add(SaveAppointmentEvent(request));
  }

  void handleAppointmentsLoaded(Appointments appointments) {
    tdataSource.appointments.clear(); // Clear existing appointments

    for (var element in appointments.items) {
      getPatientById(element.patientId).then((patient) {
        getDoctorById(element.doctorId).then((doctor) {
          final existingAppointmentIndex = tdataSource.appointments.indexWhere(
            (appointment) => appointment.appointmentId == element.id,
          );

          if (existingAppointmentIndex == -1) {
            taddNewAppointment(
              element.appointmentDate,
              element.appointmentDate.add(element.duration),
              element.status,
              Colors.blue,
              patient.name,
              doctor.name,
              element.comment,
              element.id,
            );
          }
        });
      });
    }
  }

  Future<void> loadPatients() async {
    try {
      final patientsData = await patientRepository.getPatients();
      final patientList = patientsData.items; // Access the items property

      setState(() {
        patients = patientList;
      });
    } catch (error) {
      print('Error loading patients: $error');
    }
  }

  Future<void> loadDoctors() async {
    try {
      final doctorsData = await doctorRepository.getDoctors();
      final doctorsList = doctorsData.items; // Access the items property

      setState(() {
        doctors = doctorsList;
      });
    } catch (error) {
      print('Error loading doctors: $error');
    }
  }

  Future<Patient> getPatientById(int patientId) async {
    try {
      final patient = await patientRepository.getPatientById(patientId);
      return patient;
    } catch (error) {
      throw Exception('Failed to get patient by id: $error');
    }
  }

  Future<Doctor> getDoctorById(int doctorId) async {
    try {
      final doctor = await doctorRepository.getDoctorById(doctorId);
      return doctor;
    } catch (error) {
      throw Exception('Failed to get doctor by id: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Розклад'),
        centerTitle: true,
      ),
      drawer: const SideMenu(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<AppointmentBloc, AppointmentState>(
          bloc: appointmentBloc,
          builder: (context, state) {
            if (state is AppointmentLoadingState) {
              tdataSource.appointments.clear();
              return const MyProgressIndicator();
            } else if (state is AppointmentsLoadedState) {
              handleAppointmentsLoaded(state.appointments);
              return BlocListener<AppointmentBloc, AppointmentState>(
                listener: (context, state) {
                  if (state is AppointmentErrorState) {
                    final error = state.errorMessage;
                    MotionToast.error(
                            title: const Text("Щось пішло не так"),
                            description: const Text(
                                "Не вдалося додати запис. Спробуйте ще раз"))
                        .show(context);
                    print(error);
                    tdataSource.appointments.removeLast();
                  } else if (state is AppointmentSavedState) {
                    taddNewAppointment(
                        selectedDate,
                        selectedEndDate,
                        status,
                        Colors.blue,
                        selectedPatient!.name,
                        selectedDoctor!.name,
                        commentController.text,
                        state.appointment.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Запис успішно створено'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is AppointmentDeletedState) {
                    MotionToast.delete(
                            description:
                                const Text("Пацієнта успішно видалено"))
                        .show(context);
                  }
                },
                child: SfCalendar(
                  dataSource: tdataSource,
                  view: CalendarView.week,
                  cellBorderColor: Colors.grey,
                  showDatePickerButton: true,
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeFormat: 'HH:mm',
                    startHour: 7,
                    endHour: 22,
                    numberOfDaysInView: 1,
                    timeIntervalHeight: 80,
                  ),
                  appointmentBuilder: appointmentBuilder,
                  onTap: (CalendarTapDetails details) {
                    if (details.targetElement == CalendarElement.appointment) {
                      final CustomAppointment appointmentDetails =
                          details.appointments![0] as CustomAppointment;
                      buildShowAppointmentDetails(context, appointmentDetails);
                    } else if (details.targetElement ==
                        CalendarElement.calendarCell) {
                      date = details.date!;
                      selectedDate = DateTime(date.year, date.month, date.day,
                          date.hour, date.minute);
                      selectedEndDate =
                          selectedDate.add(const Duration(hours: 1));
                      Duration duration =
                          selectedEndDate.difference(selectedDate);
                      buildCreateAppointmentDialog(context, duration);
                    }
                  },
                ),
              );
            } else if (state is AppointmentErrorState) {
              return Text('Error: ${state.errorMessage}');
            } else if (state is AppointmentDeletedState) {
              appointmentBloc.add(GetAppointmentsEvent());
              return SfCalendar(
                dataSource: tdataSource,
                view: CalendarView.week,
                cellBorderColor: Colors.grey,
                showDatePickerButton: true,
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeFormat: 'HH:mm',
                  startHour: 7,
                  endHour: 22,
                  numberOfDaysInView: 1,
                  timeIntervalHeight: 80,
                ),
                appointmentBuilder: appointmentBuilder,
                onTap: (CalendarTapDetails details) {
                  if (details.targetElement == CalendarElement.appointment) {
                    final CustomAppointment appointmentDetails =
                        details.appointments![0] as CustomAppointment;
                    buildShowAppointmentDetails(context, appointmentDetails);
                  } else if (details.targetElement ==
                      CalendarElement.calendarCell) {
                    date = details.date!;
                    selectedDate = DateTime(date.year, date.month, date.day,
                        date.hour, date.minute);
                    selectedEndDate =
                        selectedDate.add(const Duration(hours: 1));
                    Duration duration =
                        selectedEndDate.difference(selectedDate);
                    buildCreateAppointmentDialog(context, duration);
                  }
                },
              );
            } else {
              return const Text('No appointments found.');
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> buildCreateAppointmentDialog(
      BuildContext context, Duration duration) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      Icon(Ionicons.bag_add),
                      SizedBox(width: 10),
                      Text('Візит пацієнта'),
                    ]),
                    DropdownButton<String>(
                      value: status,
                      dropdownColor: Colors.grey[200],
                      icon: const Icon(
                        Ionicons.chevron_down_outline,
                        color: Colors.black,
                      ),
                      underline: Container(
                        height: 0,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          status = newValue!;
                        });
                      },
                      items: <String>[
                        'Заплановано',
                        'Підтверджено',
                        'Виконано',
                        'Пропущено',
                        'Перенесено',
                        'Не дозвонились',
                        'Запізнюється',
                        'В клініці',
                        'В кабінеті',
                        'Скасовано'
                      ].map<DropdownMenuItem<String>>((String value) {
                        final Map<String, Color> itemColors = {
                          'Заплановано': Colors.blue,
                          'Підтверджено': Colors.green,
                          'Виконано': Colors.orange,
                          'Пропущено': Colors.red,
                          'Перенесено': Color.fromARGB(255, 240, 218, 21),
                          'Не дозвонились': Colors.purple,
                          'Запізнюється': Colors.teal,
                          'В клініці': Colors.cyan,
                          'В кабінеті': Colors.brown,
                          'Скасовано': Colors.grey,
                        };

                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: itemColors[value],
                            ),
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.white, // Set the text color
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Дата: ${selectedDate.day}.${selectedDate.month}.${selectedDate.year}'),
                    Text('Час: ${selectedDate.hour.toString().padLeft(2, '0')}:'
                        '${selectedDate.minute.toString().padLeft(2, '0')} '
                        '- ${selectedEndDate.hour.toString().padLeft(2, '0')}:'
                        '${selectedEndDate.minute.toString().padLeft(2, '0')}'),
                    DropdownButtonFormField<Patient>(
                      selectedItemBuilder: (BuildContext context) {
                        return patients.map<Widget>((Patient patient) {
                          return Row(
                            children: [
                              Text(patient.name),
                              Text(
                                " ${patient.dateOfBirth.day}.${patient.dateOfBirth.month}.${patient.dateOfBirth.year}",
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          );
                        }).toList();
                      },
                      decoration: const InputDecoration(labelText: 'Пацієнт'),
                      value: selectedPatient,
                      onChanged: (Patient? newValue) {
                        setState(() {
                          selectedPatient = newValue;
                        });
                      },
                      dropdownColor: AppColors.mainBlueColor,
                      items: patients.map<DropdownMenuItem<Patient>>(
                        (Patient patient) {
                          return DropdownMenuItem<Patient>(
                            value: patient,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(patient.name),
                                  const SizedBox(width: 10),
                                  Text(
                                    " ${patient.dateOfBirth.day} ${patient.dateOfBirth.month}.${patient.dateOfBirth.year}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ]),
                          );
                        },
                      ).toList(),
                    ),
                    DropdownButtonFormField<Doctor>(
                      decoration: const InputDecoration(labelText: 'Лікар'),
                      value: selectedDoctor,
                      onChanged: (Doctor? newValue) {
                        setState(() {
                          selectedDoctor = newValue;
                        });
                      },
                      dropdownColor: AppColors.mainBlueColor,
                      items: doctors.map<DropdownMenuItem<Doctor>>(
                        (Doctor doctor) {
                          return DropdownMenuItem<Doctor>(
                            value: doctor,
                            child: Row(children: [
                              Text(doctor.name),
                              const SizedBox(width: 10),
                              Text(
                                " ${doctor.specialization}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ]),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('з'),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedDate = selectedDate
                                      .add(const Duration(hours: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_up_outline),
                            ),
                            Text('${selectedDate.hour}'),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedDate = selectedDate
                                      .subtract(const Duration(hours: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_down_outline),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedDate = selectedDate
                                      .add(const Duration(minutes: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_up_outline),
                            ),
                            Text('${selectedDate.minute}'),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedDate = selectedDate
                                      .subtract(const Duration(minutes: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_down_outline),
                            ),
                          ],
                        ),
                        const Text('до'),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedEndDate = selectedEndDate
                                      .add(const Duration(hours: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_up_outline),
                            ),
                            Text('${selectedEndDate.hour}'),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedEndDate = selectedEndDate
                                      .subtract(const Duration(hours: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_down_outline),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedEndDate = selectedEndDate
                                      .add(const Duration(minutes: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_up_outline),
                            ),
                            Text('${selectedEndDate.minute}'),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedEndDate = selectedEndDate
                                      .subtract(const Duration(minutes: 1));
                                  duration =
                                      selectedEndDate.difference(selectedDate);
                                });
                              },
                              icon: const Icon(Ionicons.arrow_down_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(labelText: 'Коментар'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      selectedPatient = null;
                      selectedDoctor = null;
                      selectedDate = DateTime.now();
                      selectedEndDate =
                          DateTime.now().add(const Duration(hours: 1));
                      commentController.clear();
                    });
                  },
                  child: const Text('Відміна'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainBlueColor,
                  ),
                  onPressed: () {
                    _saveAppointment(context);
                    Navigator.of(context).pop();
                    setState(() {
                      selectedPatient = null;
                      selectedDoctor = null;
                      selectedDate = DateTime.now();
                      selectedEndDate =
                          DateTime.now().add(const Duration(hours: 1));
                      commentController.clear();
                    });
                  },
                  child: const Text('Зберегти'),
                ),
              ],
            );
          });
        });
  }

  Future<dynamic> buildShowAppointmentDetails(
      BuildContext context, CustomAppointment appointmentDetails) {
    setState(() {
      status = appointmentDetails.subject;
    });
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      Icon(Ionicons.calendar_outline),
                      SizedBox(width: 10),
                      Text('Візит пацієнта'),
                    ]),
                    DropdownButton<String>(
                      value: status,
                      dropdownColor: Colors.grey[200],
                      icon: const Icon(
                        Ionicons.chevron_down_outline,
                        color: Colors.black,
                      ),
                      underline: Container(
                        height: 0,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          status = newValue!;
                        });
                      },
                      items: <String>[
                        'Заплановано',
                        'Підтверджено',
                        'Виконано',
                        'Пропущено',
                        'Перенесено',
                        'Не дозвонились',
                        'Запізнюється',
                        'В клініці',
                        'В кабінеті',
                        'Скасовано',
                        'Новий',
                      ].map<DropdownMenuItem<String>>((String value) {
                        // Define a map with custom text and background colors for each item
                        final Map<String, Color> itemColors = {
                          'Заплановано': Colors.blue,
                          'Підтверджено': Colors.green,
                          'Виконано': Colors.orange,
                          'Пропущено': Colors.red,
                          'Перенесено': const Color.fromARGB(255, 172, 160, 55),
                          'Не дозвонились': Colors.purple,
                          'Запізнюється': Colors.teal,
                          'В клініці': Colors.cyan,
                          'В кабінеті': Colors.brown,
                          'Скасовано': Colors.grey,
                          'Новий': Colors.blue,
                        };

                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: itemColors[value],
                            ),
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appointmentDetails.patientName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text('+380503368838', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                      '${appointmentDetails.startTime.day}.${appointmentDetails.startTime.month}.${appointmentDetails.startTime.year} '
                      '${appointmentDetails.startTime.hour.toString().padLeft(2, '0')}:'
                      '${appointmentDetails.startTime.minute.toString().padLeft(2, '0')} - '
                      '${appointmentDetails.endTime.hour.toString().padLeft(2, '0')}:'
                      '${appointmentDetails.endTime.minute.toString().padLeft(2, '0')}'),
                  const SizedBox(height: 10),
                  Text('Лікар: ${appointmentDetails.doctorName}',
                      style: const TextStyle(fontSize: 16)),
                  Text('Коментар: ${appointmentDetails.comment}',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    tdataSource.removeAppointment(appointmentDetails);
                    appointmentBloc.add(DeleteAppointmentEvent(
                        appointmentDetails.appointmentId));

                    Navigator.of(context).pop();
                  },
                  child: const Text('Видалити'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Закрити'),
                ),
              ],
            );
          });
        });
  }
}
