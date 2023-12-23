import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/constant/size.dart';
import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? icon;
  final void Function(String value)? onChanged;
  const FormInput({
    super.key,
    required this.hint,
    required this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.secondary, vertical: AppSizes.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.grey300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusForm),
          borderSide: const BorderSide(color: AppColors.error500),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.grey500),
        prefixIcon: icon,
      ),
    );
  }
}
