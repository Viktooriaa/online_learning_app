import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

class CustomTextField extends StatefulWidget {

  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<CustomTextField> {

  late bool isObscured;

  @override
  void initState() {

    super.initState();

    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {

    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return SizedBox(height: 42.h,

      child: TextField(

        obscureText: isObscured,

        style: AppTextStyles.s12w400.copyWith(
          color: isDark
              ? AppColors.lightText
              : AppColors.darkText,
        ),

        decoration: InputDecoration(

          hintText: widget.hintText,

          hintStyle:
          AppTextStyles.s12w400.copyWith(
            color: AppColors.greyText,
          ),

          suffixIcon: widget.obscureText

              ? IconButton(

            onPressed: () {

              setState(() {
                isObscured = !isObscured;
              });
            },

            icon: Icon(

              isObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,

              size: 18.w,

              color: AppColors.greyText,
            ),
          )

              : null,

          filled: true,

          fillColor: isDark
              ? AppColors.cardDark
              : Colors.white,

          contentPadding:
          EdgeInsets.symmetric(horizontal: 14.w,
            vertical: 12,
          ),

          enabledBorder: OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(10.r),

            borderSide: BorderSide(
              color: AppColors.border, width: 1.w,
            ),
          ),

          focusedBorder: OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(10.r),

            borderSide: BorderSide(
              color: AppColors.primary, width: 1.w,
            ),
          ),
        ),
      ),
    );
  }
}