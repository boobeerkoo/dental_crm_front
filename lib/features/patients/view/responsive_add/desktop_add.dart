import 'dart:io';

import 'package:dental_crm_flutter_front/features/patients/patients_bloc/patients_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/widgets/date_selection.dart';
import 'package:dental_crm_flutter_front/features/patients/widgets/form_button.dart';
import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';

class DesktopAddPatientForm extends StatefulWidget {
  const DesktopAddPatientForm({super.key});

  @override
  State<DesktopAddPatientForm> createState() => _DesktopAddPatientFormState();
}

class _DesktopAddPatientFormState extends State<DesktopAddPatientForm> {
  String? _gender = 'Чоловік';
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phone1Controller = TextEditingController();
  final TextEditingController _phone2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String selectedDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(DateTime.now());

  late PatientsBloc patientsBloc;
  PatientRepository patientRepository = PatientRepository();

  @override
  void initState() {
    super.initState();
    patientsBloc = PatientsBloc(patientRepository);
  }

  @override
  void dispose() {
    super.dispose();
    patientsBloc.close();
    _surnameController.dispose();
    _nameController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _infoController.dispose();
    _commentController.dispose();
  }

  void _savePatient(BuildContext context) {
    SaveRequest request;
    final patientsBloc = BlocProvider.of<PatientsBloc>(context);
    String dateOfBirth =
        selectedDate.endsWith("Z") ? selectedDate : "${selectedDate}Z";
    request = SaveRequest(
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
    // Perform the save operation by dispatching an event
    patientsBloc.add(SavePatientEvent(request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: BlocListener<PatientsBloc, PatientsState>(
              listener: (context, state) {
                if (state is PatientErrorState) {
                  final error = state.errorMessage;
                  MotionToast.error(
                          title: const Text("Щось пішло не так"),
                          description:
                              const Text("Перeвірте чи все ви ввели правильно"))
                      .show(context);
                  print(error);
                }
                if (state is PatientLoadedState) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/patients', (Route<dynamic> route) => false);
                  MotionToast.success(
                          description: const Text("Пацієнт успішно доданий"))
                      .show(context);
                }
              },
              child: BlocBuilder<PatientsBloc, PatientsState>(
                builder: (context, state) {
                  if (state is PatientLoadingState) {
                    return const MyProgressIndicator();
                  }
                  return _addPatienBuild(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView _addPatienBuild(BuildContext context) {
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
            _buildHeader(),
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
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: "Ім'я"),
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
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: "Адреса"),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: "E-mail"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Стать:'),
                          const SizedBox(width: 10),
                          Radio(
                            value: 'Чоловік',
                            groupValue: _gender,
                            onChanged: (String? value) =>
                                setState(() => _gender = value),
                          ),
                          const Text('Чоловік'),
                          Radio(
                            value: 'Жінка',
                            groupValue: _gender,
                            onChanged: (String? value) =>
                                setState(() => _gender = value),
                          ),
                          const Text('Жінка'),
                        ],
                      ),
                      TextField(
                        controller: _infoController,
                        decoration:
                            const InputDecoration(labelText: "Валива інф-я"),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _commentController,
                        decoration:
                            const InputDecoration(labelText: "Коментар"),
                      ),
                      const SizedBox(height: 10),
                      DateSelection(
                        onDateSelected: (DateTime date) {
                          final formattedDate =
                              DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);
                          setState(() {
                            selectedDate = formattedDate;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FormButton(
                            text: 'Зберегти',
                            color: AppColors.mainBlueColor,
                            onTap: () {
                              _savePatient(context);
                            },
                          ),
                          const SizedBox(width: 10),
                          FormButton(
                            text: 'Відмінити',
                            textColor: Colors.black,
                            color: const Color.fromARGB(255, 201, 199, 199),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )
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

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.add_circle_outline_sharp, size: 24),
            SizedBox(width: 8),
            Text(
              'Новий пацієнт',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
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
                // Implement delete image logic
              },
            ),
          ),
        ),
      ],
    );
  }
}
