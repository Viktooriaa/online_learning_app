import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';


class AppTextStyles {
  static TextStyle get s32w700 => GoogleFonts.poppins(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
      );

  static TextStyle get s24w700 => GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
      );

  static TextStyle get s22w700 => GoogleFonts.poppins(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
        height: 1.3,
      );

  static TextStyle get s20w700 => GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.darkText,
      );

  static TextStyle get s18w600 => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
      );

  static TextStyle get s16w400 => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.greyText,
        height: 1.5,
      );

  static TextStyle get s16w500 => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.lightText,
      );

  static TextStyle get s14w500 => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.greyText,
      );

  static TextStyle get s14w400 => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.greyText,
      );

  static TextStyle get s12w500 => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.greyText,
      );

  static TextStyle get s12w400 => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.greyText,
      );

  static TextStyle get s10w400 => GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.greyText,
      );
}
