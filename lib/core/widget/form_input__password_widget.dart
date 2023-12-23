import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/constant/icon.dart';
import 'package:artikel_aplication/core/constant/size.dart';
import 'package:flutter/material.dart';

class FormInputPassword extends StatefulWidget {
  final String hint;
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;
  const FormInputPassword({
    super.key,
    required this.hint,
    required this.label,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  State<FormInputPassword> createState() => _FormInputPasswordState();
}

class _FormInputPasswordState extends State<FormInputPassword> {
  bool passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      obscureText: passwordVisibility,
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
        labelText: widget.label,
        hintText: widget.hint,
        hintStyle: const TextStyle(color: AppColors.grey500),
        prefixIcon: Transform.scale(      
                  scale: 0.5,       
                  child: const ImageIcon(AppIcons.password, color: AppColors.grey500,),
               ), 
        suffixIcon: IconButton(
          icon: ImageIcon(
            passwordVisibility
                ? AppIcons.disablePassword
                : AppIcons.enablePassword,
            color: AppColors.grey500,
          ),
          onPressed: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
        ),
      ),
    );
  }
}
