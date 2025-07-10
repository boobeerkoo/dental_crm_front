import 'package:dental_crm_flutter_front/dental_crm_app.dart';
import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/patients/treatments_bloc/treatment_bloc.dart';
import 'package:dental_crm_flutter_front/features/schedule/bloc/appointment_bloc.dart';
import 'package:dental_crm_flutter_front/repositories/appointment/appointment_repository.dart';
import 'package:dental_crm_flutter_front/repositories/auth/auth_repository.dart';
import 'package:dental_crm_flutter_front/repositories/treatment/treatment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final authRepository = AuthRepository();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) {
              return AuthBloc(authRepository)..add(AppStared());
            },
          ),
          BlocProvider<AppointmentBloc>(
            create: (context) {
              return AppointmentBloc(AppointmentRepository());
            },
          ),
          BlocProvider<TreatmentBloc>(create: (context) {
            return TreatmentBloc(TreatmentRepository());
          })
        ],
        child: const DentalCrmApp(),
      ),
    ),
  );
}
// BlocProvider<AuthBloc>(
// create: (context) {
// return AuthBloc(authRepository)..add(AppStared());
// },
