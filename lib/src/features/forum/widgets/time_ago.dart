import 'package:flutter/material.dart';
import '../../../config/app_text_styles.dart';

class TimeAgo extends StatelessWidget {
  final DateTime date;

  const TimeAgo({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final diff = DateTime.now().difference(date);
    String text;

    if (diff.inMinutes < 60) {
      text = '${diff.inMinutes} 分鐘前';
    } else if (diff.inHours < 24) {
      text = '${diff.inHours} 小時前';
    } else {
      text = '${diff.inDays} 天前';
    }

    return Text(text, style: AppTextStyles.caption);
  }
}

