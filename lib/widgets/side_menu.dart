import 'package:dental_crm_flutter_front/features/auth/auth_bloc/auth_bloc.dart';
import 'package:dental_crm_flutter_front/utils/app_colors.dart';
import 'package:dental_crm_flutter_front/widgets/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.mainBlueColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Transform.scale(
                  scale: 0.7, child: Image.asset("assets/images/logo.png")),
            ),
            DrawerListTile(
              title: 'Пацієнти',
              svgSrc: "assets/icons/patients_icon.svg",
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/patients', (Route<dynamic> route) => false);
              },
            ),
            DrawerListTile(
              title: 'Розклад',
              svgSrc: "assets/icons/calendar_icon.svg",
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/schedule', (Route<dynamic> route) => false);
              },
            ),
            DrawerListTile(
              title: 'Профіль',
              svgSrc: "assets/icons/settings_icon.svg",
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/profile', (Route<dynamic> route) => false);
              },
            ),
            DrawerListTile(
              title: 'Вийти',
              svgSrc: "assets/icons/logout_icon.svg",
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
