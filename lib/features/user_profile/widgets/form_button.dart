import 'package:dental_crm_flutter_front/utils/utils.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.text,
    this.color,
    this.onTap,
    this.textColor,
    this.horizontalEI,
    this.verticalEI,
    this.prefixImage,
  });

  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onTap;
  final double? horizontalEI;
  final double? verticalEI;
  final ImageProvider? prefixImage;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Ink(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalEI ?? 70.0, vertical: verticalEI ?? 18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: color,
          ),
          child: Row(
            children: [
              if (prefixImage != null)
                Image(
                  image: prefixImage!,
                  width: 24.0,
                  height: 24.0,
                ),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: AppStyles.ralewayStyle.copyWith(
                  fontSize: 20.0,
                  color: textColor ?? AppColors.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
