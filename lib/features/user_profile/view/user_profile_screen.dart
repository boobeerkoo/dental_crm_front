import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/features/user_profile/view/responsive_profile/responsive_profile.dart';
import 'package:dental_crm_flutter_front/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/login', (Route<dynamic> route) => false);
        }
      },
      child: const ResponsiveLayout(
        mobileScaffold: MobileProfile(),
        tabletScaffold: TabletProfile(),
        desktopScaffold: DesktopProfile(),
      ),
    );
  }
}
