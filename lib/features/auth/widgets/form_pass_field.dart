import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:dental_crm_flutter_front/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class FormPasswordField extends StatelessWidget {
  const FormPasswordField({
    super.key,
    required this.height,
    required this.width,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.controller,
    this.obscureText = true,
  });

  final double height;
  final double width;
  final Icon? prefixIcon;
  final GestureDetector? suffixIcon;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.whiteColor),
      alignment: Alignment.center,
      child: Padding(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? const EdgeInsets.all(0)
            : const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: AppStyles.ralewayStyle.copyWith(
              fontSize: 18.0,
              color: AppColors.blueDarkColor,
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              onPressed: () {},
              icon: prefixIcon ?? Container(),
            ),
            suffixIcon: suffixIcon ?? Container(),
            hintText: hintText ?? '',
            hintStyle: AppStyles.ralewayStyle.copyWith(
                fontSize: 18.0,
                color: AppColors.blueDarkColor.withOpacity(0.5),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
