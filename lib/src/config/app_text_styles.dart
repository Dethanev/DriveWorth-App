import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// 全域文字樣式中心，統一管理字級與字重。
///
/// 原則：
/// - 只在這裡改 `fontSize`、`fontWeight`、`letterSpacing`、`height`
/// - 外部使用時若要調整顏色或少量樣式，盡量只 `copyWith(color: ...)`，避免再改字級
class AppTextStyles {
  /// H1：頁面主標（例如：畫面頂部大標題）
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.4,
    color: AppColors.black,
  );

  /// H2：區塊標題（例如：卡片大標、AppBar 標題）
  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.2,
    color: AppColors.black,
  );

  /// H3：中型標題（例如：列表項標題、內頁標題）
  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.black,
  );

  /// H4：小型標題（例如：設定區塊標題、卡片小標）
  static TextStyle h4 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: 0,
    color: AppColors.black,
  );

  /// H5：卡片 / 標籤用的小標題
  static TextStyle h5 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0,
    color: AppColors.black,
  );

  /// Body：主體內文（一般段落）
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.black,
  );

  /// Body 小字：次要說明文字、補充內容
  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.black,
  );

  /// Body 粗體：需要稍微強調的內文
  static TextStyle bodyBold = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.black,
  );

  /// Body 小字：次要說明文字、補充內容
  static TextStyle bodySmallBold = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.45,
    color: AppColors.black,
  );

  /// 主要按鈕文字（CTA）
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    color: AppColors.black,
  );

  /// 次要按鈕 / 細尺寸按鈕
  static TextStyle buttonSm = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    color: AppColors.black,
  );

  /// Caption / 小標註文字
  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: AppColors.textSecondary,
  );

  static TextStyle fontWeight600 = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
  );
}
