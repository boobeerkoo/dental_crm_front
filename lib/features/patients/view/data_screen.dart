import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/patients_bloc/patients_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/view/responsive_data/responsive_data.dart';
import 'package:dental_crm_flutter_front/repositories/patient/patient_repository.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/patient/models/models.dart';

class PatientDataScreen extends StatefulWidget {
  final Patient patient;

  const PatientDataScreen({super.key, required this.patient});

  @override
  State<PatientDataScreen> createState() => _PatientDataScreenState();
}

class _PatientDataScreenState extends State<PatientDataScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientsBloc(PatientRepository()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          }
        },
        child: ResponsiveLayout(
          mobileScaffold: MobileDataScreen(patient: widget.patient),
          tabletScaffold: TabletDataScreen(
            patient: widget.patient,
          ),
          desktopScaffold: DesktopDataScreen(patient: widget.patient),
        ),
      ),
    );
  }
}
