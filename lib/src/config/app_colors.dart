import 'package:flutter/material.dart';

class AppColors {
  // Primary Visuals
  static const Color primary = Color.fromARGB(255, 255, 235, 184); // 暖黃色 - 背景高亮區、主視覺光暈
  static const Color secondary = Color.fromARGB(255, 255, 208, 90); // 金黃色 - 主按鈕、icon 重點色
  static const Color accent = Color(0xFFFF6F2E); // 橘色 - CTA / 通知強調

  // Base
  static const Color surface = Color(0xFFFFFFFF); // 白色 - 卡片、輸入框
  static const Color background = Color.fromARGB(255, 255, 246, 227); // 極淺暖灰 - App scaffold 底色

  // Text
  static const Color textPrimary = Color(0xFF1D1D1F); // 深灰主文字
  static const Color textSecondary = Color(0xFF6B6B6B); // 中灰副文字

  // Divider / Border
  static const Color divider = Color(0xFFE0E0E0); // 淡灰分隔線（表單/區塊用）
  static const Color borderLight = Color(0xFFE0E0E0); // 淡灰邊框

  // Status
  static const Color statusDanger = Color(0xFFFF4D4F); // 高風險（紅）
  static const Color statusSafe = Color(0xFF3BB273); // 安全（綠）
  static const Color statusSuspicious = Color(0xFFFFC107); // 可疑（黃）

  // Auth / Login
  static const Color loginBackground = Color(0xFFD6E2EA); // 登入頁背景色
  static const Color socialButtonPrimary = Color(0xFF7B68EE); // 社交登入按鈕主色
  static const Color socialButtonBorder = Color(0xFFBDBDBD); // 社交登入按鈕邊框（grey.shade300）

  // Home
  static const Color summaryGradientStart = Color.fromARGB(255, 255, 218, 125); // 摘要卡片漸層起始色
  static const Color summaryGradientEnd = Color.fromARGB(255, 255, 241, 201); // 摘要卡片漸層結束色

  // Personal
  static const Color personalBackground = Color.fromARGB(255, 255, 243, 199); // 個人頁背景色
  static const Color personalMenuIcon = Color(0xFF2196F3); // 個人選單圖示背景色

  // Forum
  static const Color forumLike = Color(0xFFE91E63); // 論壇按讚顏色

  // Analyze
  static const Color analyzeHistoryBackground = Color(0xFFF2F2F0);
  static const Color analyzeInputBackground = Color(0xFFF2F2F0);

  // Neubrutalism (TCO Analyze)
  static const Color neuBackground = Color(0xFFFFFFFF);
  static const Color neuCardTax = Color(0xFF3BB273);
  static const Color neuCardInsurance = Color(0xFF00C1FF);
  static const Color neuCardFuel = Color(0xFFFF5C00);
  static const Color neuCardMaintenance = Color(0xFFFFD100);
  static const Color neuCardTotal = Color(0xFF1D1D1F);
  static const Color neuCardRiskReserve = Color(0xFF9E9E9E);

  // AppBar
  static const Color appbar = Color.fromARGB(255, 255, 208, 90);

  // Onboarding
  static const Color pink = Color(0xFFFFA7BC);
  static const Color yellow = Color(0xFFFDDC70);
  static const Color blue = Color(0xFFA2E7EB);
  static const Color indigo = Color.fromARGB(255, 112, 145, 246);
  static const Color orange = Color(0xFFFF763C);

  // Common
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
}
