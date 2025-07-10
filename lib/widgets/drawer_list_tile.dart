import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.onTap,
  });

  final String title, svgSrc;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        svgSrc,
        height: 30,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      horizontalTitleGap: 20.0,
      title: Text(
        title,
        style: AppStyles.ralewayStyle.copyWith(
            fontSize: 20,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
