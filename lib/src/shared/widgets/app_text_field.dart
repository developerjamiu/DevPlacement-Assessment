import 'package:flutter/material.dart';

import '../../contents/constants/app_colors.dart';
import '../../contents/constants/app_styles.dart';

class AppTextField extends StatelessWidget {
  /// Customised App Text Button
  ///
  /// All Properties can be null
  final String label;
  final String hintText;
  final bool obscureText;
  final int maxLines;
  final bool enabled;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Widget suffixIcon;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function(String) onFieldSubmitted;
  final TextInputType keyboardType;
  final String errorText;

  const AppTextField({
    Key key,
    this.label,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.textInputAction,
    this.validator,
    this.enabled,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLines,
    this.obscureText,
    this.keyboardType,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? Text(label) : SizedBox(),
        label != null ? SizedBox(height: 8.0) : SizedBox(),
        TextFormField(
          validator: validator,
          controller: controller,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.done,
          style: AppStyles.bodyText1,
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
          enabled: enabled,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            errorText: errorText,
            contentPadding: EdgeInsets.all(16.0),
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade900, width: 2.0),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent, width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent, width: 2.0),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent, width: 2.0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
