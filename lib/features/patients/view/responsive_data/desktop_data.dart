import 'dart:io';
import 'package:dental_crm_flutter_front/features/patients/patients_bloc/patients_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/treatments_bloc/treatment_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/view/view.dart';
import 'package:dental_crm_flutter_front/features/patients/widgets/widgets.dart';
import 'package:dental_crm_flutter_front/features/user_profile/bloc/user_bloc.dart';
import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:dental_crm_flutter_front/repositories/treatment/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/treatment/treatment_repository.dart';
import 'package:dental_crm_flutter_front/repositories/user/user_repository.dart';
import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';

import 'package:motion_toast/motion_toast.dart';

class DesktopDataScreen extends StatefulWidget {
  final Patient patient;

  const DesktopDataScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<DesktopDataScreen> createState() => _DesktopDataScreenState();
}

class _DesktopDataScreenState extends State<DesktopDataScreen>
    with SingleTickerProviderStateMixin {
  PatientRepository patientRepository = PatientRepository();
  UserRepository userRepository = UserRepository();
  TreatmentRepository treatmentRepository = TreatmentRepository();
  late PatientsBloc patientsBloc;
  late UserBloc userBloc;
  late TreatmentBloc treatmentBloc;
  late TabController _tabController;

  bool showConfirmation = false;
  bool isEditing = false;
  bool isBold = false;
  String? _gender = 'Чоловік';
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phone1Controller = TextEditingController();
  final TextEditingController _phone2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _etapController = TextEditingController();
  List<TextEditingController> _commentControllers = [];
  String selectedDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now());
  String userName = '';

  @override
  void initState() {
    super.initState();

    patientsBloc = PatientsBloc(patientRepository);
    userBloc = UserBloc(userRepository);
    treatmentBloc = TreatmentBloc(treatmentRepository);
    userBloc.add(FetchUserEvent());
    patientsBloc.add(GetPatientByIdEvent(widget.patient.id));
    treatmentBloc.add(GetTreatmentsByPatientIdEvent(widget.patient.id));
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    patientsBloc.close();
    _surnameController.dispose();
    _nameController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _infoController.dispose();
    _commentController.dispose();
    _etapController.dispose();
    for (var controller in _commentControllers) {
      controller.dispose();
    }
  }

  void _updatePatient(BuildContext context) {
    UpdateRequest request;
    final patientsBloc = BlocProvider.of<PatientsBloc>(context);
    String dateOfBirth =
        selectedDate.endsWith("Z") ? selectedDate : "${selectedDate}Z";
    request = UpdateRequest(
      name: '${_surnameController.text} ${_nameController.text} ',
      phone: _phone1Controller.text,
      phone2: _phone2Controller.text,
      address: _addressController.text,
      email: _emailController.text,
      sex: _gender ?? "Чоловік",
      importantInfo: _infoController.text,
      comment: _commentController.text,
      dateOfBirth: dateOfBirth,
    );

    patientsBloc.add(UpdatePatientEvent(widget.patient.id, request));
  }

  void _saveTreatment(BuildContext context, String comment) {
    SaveTreatmentRequest request;
    final treatmentsBloc = BlocProvider.of<TreatmentBloc>(context);
    request = SaveTreatmentRequest(
      patientId: widget.patient.id,
      doctorId: 1,
      type: _etapController.text,
      comment: comment,
    );

    treatmentsBloc.add(SaveTreatmentEvent(request));
  }

  void _updateTreatment(BuildContext context, String comment, int id) {
    UpdateTreatmentRequest request;
    final treatmentsBloc = BlocProvider.of<TreatmentBloc>(context);
    request = UpdateTreatmentRequest(
      patientId: widget.patient.id,
      doctorId: 1,
      type: _etapController.text,
      comment: comment,
    );

    treatmentsBloc.add(UpdateTreatmentEvent(id, request));
  }

  void _deleteTreatment(BuildContext context, int id) {
    final treatmentsBloc = BlocProvider.of<TreatmentBloc>(context);
    treatmentsBloc.add(DeleteTreatmentEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: BlocProvider<PatientsBloc>(
              create: (context) {
                return patientsBloc;
              },
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    dividerColor: Colors.black,
                    indicator: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 240, 240),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.mainBlueColor,
                          width: 3,
                        ),
                      ),
                    ),
                    tabs: const [
                      Tab(text: 'Профіль пацієнта'),
                      Tab(text: 'Історія лікування'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _dataForm(context),
                        _buildTreatmentHistoryTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatmentHistoryTab() {
    return SingleChildScrollView(
      child: BlocListener<PatientsBloc, PatientsState>(
        bloc: patientsBloc,
        listener: (context, state) {
          if (state is PatientErrorState) {
            final error = state.errorMessage;
            MotionToast.error(
                    title: const Text("Щось пішло не так"),
                    description: const Text("Помилка завантаження даних"))
                .show(context);
            print(error);
          }
        },
        child: BlocBuilder<PatientsBloc, PatientsState>(
          bloc: patientsBloc,
          builder: (context, state) {
            if (state is PatientLoadedState) {
              final patient = state.patient;
              List<String> nameParts = patient.name.split(' ');
              _surnameController.text = nameParts[0];
              _nameController.text = nameParts.length > 1 ? nameParts[1] : '';
              _phone1Controller.text = patient.phone1;
              final year = patient.dateOfBirth.year;
              final dob = patient.dateOfBirth;
              return loadHistoryTab(year, dob);
            } else if (state is PatientLoadingState) {
              return const MyProgressIndicator();
            }
            return const Center(child: Text('Помилка завантаження даних'));
          },
        ),
      ),
    );
  }

  Column loadHistoryTab(int year, DateTime dob) {
    return Column(
      children: [
        HistoryTabHeader(
          pickedImagePath: _pickedImagePath,
          surnameController: _surnameController,
          nameController: _nameController,
          phone1Controller: _phone1Controller,
          year: year,
        ),
        BlocListener<TreatmentBloc, TreatmentState>(
          listener: (context, state) {
            if (state is TreatmentSavedState) {
              MotionToast.success(
                      title: const Text("Успішно"),
                      description: const Text("Дані успішно збережено"))
                  .show(context);
              patientsBloc.add(GetPatientByIdEvent(widget.patient.id));
              treatmentBloc
                  .add(GetTreatmentsByPatientIdEvent(widget.patient.id));
            } else if (state is TreatmentErrorState) {
              final error = state.errorMessage;
              MotionToast.error(
                      title: const Text("Щось пішло не так"),
                      description: const Text("Помилка завантаження даних"))
                  .show(context);
              print(error);
            }
          },
          child: BlocBuilder<TreatmentBloc, TreatmentState>(
            bloc: treatmentBloc,
            builder: (context, state) {
              if (state is TreatmentsLoadedState) {
                final treatments = state.treatments;
                _commentControllers = List.generate(
                    treatments.treatments.length,
                    (index) => TextEditingController());
                final reversedTreatments =
                    treatments.treatments.reversed.toList();
                return Column(
                  children: [
                    CreateCommentTile(
                      etapController: _etapController,
                      onTap: () {
                        setState(() {
                          final newCommentController = TextEditingController();
                          _commentControllers.add(newCommentController);
                          final newTreatment = Treatment(
                            type: _etapController.text,
                            comment: '',
                            updatedDate: DateTime.now(),
                            id: 0,
                            createdDate: DateTime.now(),
                            doctorId: 0,
                            patientId: widget.patient.id,
                          );
                          treatments.treatments.add(newTreatment);
                        });
                      },
                      onAddTooth: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DentalFormulaScreen(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: reversedTreatments.length,
                      itemBuilder: (context, index) {
                        final treatment = reversedTreatments[index];
                        _commentControllers[index].text = treatment.comment;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CommentTile(
                            isEditing: treatment.id == 0 ? true : false,
                            etap: treatment.type,
                            pickedImagePath: _pickedImagePath,
                            userName: userName,
                            historyComment: _commentControllers[index],
                            updatedDate: treatment.updatedDate
                                .add(const Duration(hours: 3)),
                            onDeleteTap: () {
                              if (treatment.id != 0) {
                                _deleteTreatment(context, treatment.id);

                                setState(() {
                                  treatments.treatments.remove(treatment);
                                  _commentControllers.removeAt(index);
                                });
                              } else {
                                setState(() {
                                  treatments.treatments.remove(treatment);
                                  _commentControllers.removeAt(index);
                                });
                              }
                            },
                            onSaveTap: () {
                              if (treatment.id == 0) {
                                _saveTreatment(
                                    context, _commentControllers[index].text);
                              } else {
                                _updateTreatment(
                                    context,
                                    _commentControllers[index].text,
                                    treatment.id);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else if (state is TreatmentLoadingState) {
                return const MyProgressIndicator();
              }
              return const Center(child: Text('Помилка завантаження даних'));
            },
          ),
        ),
      ],
    );
  }

  SingleChildScrollView _dataForm(BuildContext context) {
    return SingleChildScrollView(
      child: MultiBlocListener(
        listeners: [
          BlocListener<PatientsBloc, PatientsState>(
            bloc: patientsBloc,
            listener: (context, state) {
              if (state is PatientDeletedState) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/patients', (Route<dynamic> route) => false);
                MotionToast.delete(
                        description: const Text("Пацієнта успішно видалено"))
                    .show(context);
              } else if (state is PatientDeleteErrorState) {
                final error = state.errorMessage;
                MotionToast.error(
                        title: const Text("Щось пішло не так"),
                        description: const Text("Не вдалося видалити пацієнта"))
                    .show(context);
                print(error);
              } else if (state is PatientErrorState) {
                final error = state.errorMessage;
                MotionToast.error(
                        title: const Text("Щось пішло не так"),
                        description: const Text("Помилка завантаження даних"))
                    .show(context);
                print(error);
              } else if (state is PatientUpdatedState) {
                MotionToast.success(
                        description:
                            const Text("Дані пацієнта успішно оновлено"))
                    .show(context);
              }
            },
          ),
          BlocListener<UserBloc, UserState>(
            bloc: userBloc,
            listener: (context, state) {
              if (state is UserLoadedState) {
                userName = state.user.name;
              }
            },
          ),
        ],
        child: BlocBuilder<PatientsBloc, PatientsState>(
          bloc: patientsBloc,
          builder: (context, state) {
            if (state is PatientLoadedState) {
              final patient = state.patient;
              List<String> nameParts = patient.name.split(' ');
              _surnameController.text = nameParts[0];
              _nameController.text = nameParts.length > 1 ? nameParts[1] : '';
              _phone1Controller.text = patient.phone1;
              _phone2Controller.text = patient.phone2;
              _emailController.text = patient.email;
              _addressController.text = patient.address;
              _infoController.text = patient.importantInfo;
              _gender = patient.sex;
              _commentController.text = patient.comment;
              final day = patient.dateOfBirth.day;
              final month = patient.dateOfBirth.month;
              final year = patient.dateOfBirth.year;
              return _showDataForm(context, day, month, year);
            } else if (state is PatientLoadingState) {
              return const MyProgressIndicator();
            }
            return const Center(child: Text('Помилка завантаження даних'));
          },
        ),
      ),
    );
  }

  SingleChildScrollView _showDataForm(
      BuildContext context, int day, month, year) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildPatientImage(),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: _surnameController,
                        decoration:
                            const InputDecoration(labelText: 'Прізвище'),
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: "Ім'я"),
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          TextFormField(
                            controller: _phone1Controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              PhoneInputFormatter(),
                            ],
                            decoration:
                                const InputDecoration(labelText: 'Телефон 1'),
                            enabled: isEditing,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _phone2Controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          PhoneInputFormatter(),
                        ],
                        decoration:
                            const InputDecoration(labelText: 'Телефон 2'),
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: "Адреса"),
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: "E-mail"),
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Стать:'),
                          const SizedBox(width: 10),
                          Radio(
                            value: 'Чоловік',
                            groupValue: _gender,
                            onChanged: null,
                            //(String? value) =>
                            //setState(() => _gender = value)
                          ),
                          const Text('Чоловік'),
                          Radio(
                            value: 'Жінка',
                            groupValue: _gender,
                            onChanged: null,
                            //(String? value) =>
                            //    setState(() => _gender = value)
                          ),
                          const Text('Жінка'),
                        ],
                      ),
                      TextField(
                        controller: _infoController,
                        decoration:
                            const InputDecoration(labelText: "Валива інф-я"),
                        enabled: isEditing,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _commentController,
                        decoration:
                            const InputDecoration(labelText: "Коментар"),
                        enabled: isEditing,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 10),
                      DateSelection(
                        day: day,
                        month: month,
                        year: year,
                        onDateSelected: (DateTime date) {
                          final formattedDate =
                              DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(date);
                          setState(() {
                            selectedDate = formattedDate;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      if (!isEditing) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FormButton(
                              text: 'Редагувати',
                              color: AppColors.mainBlueColor,
                              onTap: () {
                                setState(() {
                                  isEditing = true;
                                });
                              },
                            ),
                            const SizedBox(width: 50),
                          ],
                        ),
                      ],
                      if (isEditing) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FormButton(
                              text: 'Зберегти',
                              color: AppColors.mainBlueColor,
                              onTap: () {
                                _updatePatient(context);
                                setState(() {
                                  isEditing = false;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            FormButton(
                              text: 'Відмінити',
                              textColor: Colors.black,
                              color: const Color.fromARGB(255, 201, 199, 199),
                              onTap: () {
                                setState(() {
                                  isEditing = false;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPatientImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 200,
            height: 200,
            color: AppColors.tilesBgColor,
            child: _pickedImagePath != null
                ? Image.file(
                    File(_pickedImagePath!),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/profile2.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainBlueColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: _selectImage,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.mainBlueColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _pickedImagePath = null;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  String? _pickedImagePath;

  Future<void> _selectImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        setState(() {
          _pickedImagePath = file.path;
        });
      }
    } on PlatformException catch (e) {
      print('Error while picking the image: $e');
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.person, size: 24),
                SizedBox(width: 8),
                Text(
                  'Дані пацієнта',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Видалити пацієнта?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                patientsBloc
                                    .add(DeletePatientEvent(widget.patient.id));
                                Navigator.pop(context);
                              },
                              child: const Text('Так'),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppColors.mainBlueColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ні'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Видалити'),
                ),
                const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/patients', (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
