import 'dart:developer';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.style,
    this.controller,
    this.onTap,
    this.enableEdit = true,
    this.fillColor,
    this.textAlignCenter = true,
    this.manLines = 1,
    this.enableValodator = true,
    this.isPassword = false,
    this.maxLength,
  });
  final String label;
  final TextStyle? style;
  final TextEditingController? controller;
  final Function()? onTap;
  final bool enableEdit;
  final Color? fillColor;
  final bool textAlignCenter;
  final int? manLines;
  final bool enableValodator;
  final bool isPassword;
  final int? maxLength;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.enableEdit
          ? (value) => value!.isEmpty ? 'Field is required' : null
          : null,
      onTap: widget.onTap,
      maxLength: widget.maxLength,
      enabled: widget.enableEdit,
      controller: widget.controller,
      maxLines: widget.manLines,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        suffix: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                    log(obscureText.toString());
                  });
                },
                child: Icon(
                  !obscureText ? Icons.visibility : Icons.visibility_off,
                  size: 25.w,
                  color: AppColors.kBlueColor,
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        errorBorder: buildBorder(),
        enabledBorder: buildBorder(),
        filled: true,
        label: widget.textAlignCenter
            ? Center(
                child: Text(
                  widget.label,
                  style: widget.style ?? AppTextStyles.title20KBlueColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Text(
                widget.label,
                style: widget.style ?? AppTextStyles.title20KBlueColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        border: buildBorder(),
        fillColor: widget.fillColor ?? AppColors.kGreyColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kBlueColor),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0.r),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(16.0.r),
      ),
    );
  }
}
