import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/patients_bloc/patients_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/view/responsive_add/responsive_add.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientsBloc>(
      create: (context) => PatientsBloc(PatientRepository()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (Route<dynamic> route) => false,
            );
          }
        },
        child: const ResponsiveLayout(
          mobileScaffold: MobileAddPatientsForm(),
          tabletScaffold: TabletAddPatientsForm(),
          desktopScaffold: DesktopAddPatientForm(),
        ),
      ),
    );
  }
}
