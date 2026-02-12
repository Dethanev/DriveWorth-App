import 'package:flutter/material.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../../analyze/analyze_page.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.phone_rounded, 'label': '電話分析', 'index': 0},
      {'icon': Icons.public_rounded, 'label': '網址分析', 'index': 1},
      {'icon': Icons.article_rounded, 'label': '文字分析', 'index': 2},
      {'icon': Icons.image_rounded, 'label': '圖片分析', 'index': 3},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: menuItems.map((item) {
        return Card(
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Sound.click1();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyzePage(
                    initialIndex: item['index'] as int,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    size: 28,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  item['label'] as String,
                  style: AppTextStyles.bodyBold,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

