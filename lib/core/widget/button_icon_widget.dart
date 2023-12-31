import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/constant/size.dart';
import 'package:artikel_aplication/core/extention/doubel_ext.dart';
import 'package:flutter/material.dart';

class FormButtonIcon extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final Image image;

  const FormButtonIcon({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.border,
    this.width,
    this.height,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40.0,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(AppSizes.radiusButton),
        color: onPressed == null
            ? backgroundColor?.withOpacity(0.5) ?? AppColors.primary300
            : backgroundColor ?? AppColors.primary500,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: image,
            ),
            8.0.width,
            Text(
              label,
              style: TextStyle(
                color: textColor ?? AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.buttonFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
