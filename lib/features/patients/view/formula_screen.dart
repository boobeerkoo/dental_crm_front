import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/view/responsive_formula/responsive_formula.dart';
import 'package:dental_crm_flutter_front/repositories/patient/models/models.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DentalFormulaScreen extends StatefulWidget {
  final Patient patient;

  const DentalFormulaScreen({super.key, required this.patient});

  @override
  State<DentalFormulaScreen> createState() => _DentalFormulaScreenState();
}

class _DentalFormulaScreenState extends State<DentalFormulaScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        }
      },
      child: ResponsiveLayout(
        mobileScaffold: const MobileFormula(),
        tabletScaffold: const TabletFormula(),
        desktopScaffold: DesktopFormula(patient: widget.patient),
      ),
    );
  }
}
