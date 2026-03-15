import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../shared/models/forum_post.dart';
import '../../shared/utils/sound.dart';
import 'widgets/time_ago.dart';

class ForumPostDetailPage extends StatefulWidget {
  final ForumPost post;

  const ForumPostDetailPage({super.key, required this.post});

  @override
  State<ForumPostDetailPage> createState() => _ForumPostDetailPageState();
}

class _ForumPostDetailPageState extends State<ForumPostDetailPage> {
  void _toggleLike() {
    Sound.click();
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
      if (widget.post.isLiked) {
        widget.post.likeCount++;
      } else {
        widget.post.likeCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Sound.click();
            Navigator.pop(context);
          },
        ),
        title: Text('文章詳情', style: AppTextStyles.h2),
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.black, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.black,
                    offset: Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Text(
                widget.post.tag,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.post.title,
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 8),
            TimeAgo(date: widget.post.createdAt),
            const SizedBox(height: 24),
            Text(
              widget.post.content,
              style: AppTextStyles.body.copyWith(
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            _LikeButton(
              isLiked: widget.post.isLiked,
              count: widget.post.likeCount,
              onTap: _toggleLike,
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  final bool isLiked;
  final int count;
  final VoidCallback onTap;

  const _LikeButton({
    required this.isLiked,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              isLiked
                  ? AppColors.forumLike.withValues(alpha: 0.1)
                  : AppColors.white,
          border: Border.all(
            color: AppColors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black,
              offset: Offset(3, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: isLiked ? AppColors.forumLike : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: AppTextStyles.caption.copyWith(
                color: isLiked ? AppColors.forumLike : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
