import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/auth/view/view.dart';
import 'package:dental_crm_flutter_front/features/patients/view/add_screen.dart';
import 'package:dental_crm_flutter_front/features/patients/view/view.dart';
import 'package:dental_crm_flutter_front/features/schedule/view/schedule_screen.dart';
import 'package:dental_crm_flutter_front/features/user_profile/view/user_profile_screen.dart';
import 'package:dental_crm_flutter_front/repositories/auth/auth_repository.dart';
import 'package:dental_crm_flutter_front/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} $stackTrace');
  }
}

class DentalCrmApp extends StatefulWidget {
  const DentalCrmApp({super.key});

  @override
  State<DentalCrmApp> createState() => _DentalCrmAppState();
}

class _DentalCrmAppState extends State<DentalCrmApp> {
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('uk', 'UA'),
      ],
      locale: const Locale('uk', 'UA'),
      debugShowCheckedModeBanner: false,
      title: 'Dental CRM',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.mainBlueColor,
          appBarTheme: const AppBarTheme(
            color: AppColors.mainBlueColor,
            elevation: 0,
            centerTitle: true,
          ),
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          canvasColor: AppColors.mainBlueColor),
      routes: {
        '/login': (context) => LoginScreen(authRepository: authRepository),
        '/register': (context) => const RegisterScreen(),
        '/patients': (context) => const MainScreen(),
        '/patients/add': (context) => const AddPatientScreen(),
        '/profile': (context) => const UserProfileScreen(),
        '/schedule': (context) => const ScheduleScreen(),
      },
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return const MainScreen();
          }
          if (state is AuthUnauthenticated) {
            return LoginScreen(authRepository: authRepository);
          }
          if (state is AuthLoading) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                width: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.mainBlueColor),
                        strokeWidth: 5.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              color: Colors.white,
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.mainBlueColor),
                      strokeWidth: 5.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
