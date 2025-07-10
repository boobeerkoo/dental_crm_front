import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/schedule/bloc/appointment_bloc.dart';
import 'package:dental_crm_flutter_front/features/schedule/view/responsive_schedule/responsive_shedule.dart';
import 'package:dental_crm_flutter_front/repositories/appointment/appointment_repository.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentBloc>(
      create: (context) => AppointmentBloc(AppointmentRepository()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          }
        },
        child: ResponsiveLayout(
          mobileScaffold: BlocProvider<AppointmentBloc>.value(
            value: BlocProvider.of<AppointmentBloc>(context),
            child: const MobileSchedule(),
          ),
          tabletScaffold: BlocProvider<AppointmentBloc>.value(
            value: BlocProvider.of<AppointmentBloc>(context),
            child: const TabletSchedule(),
          ),
          desktopScaffold: BlocProvider<AppointmentBloc>.value(
            value: BlocProvider.of<AppointmentBloc>(context),
            child: const DesktopSchedule(),
          ),
        ),
      ),
    );
  }
}
