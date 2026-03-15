import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../../../shared/models/forum_post.dart';
import 'time_ago.dart';

class PostCard extends StatelessWidget {
  final ForumPost post;
  final VoidCallback? onTap;

  const PostCard({super.key, required this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.tag,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              post.title,
              style: AppTextStyles.h4,
            ),
            const SizedBox(height: 6),

            Text(
              post.snippet,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimeAgo(date: post.createdAt),
                Row(
                  children: [
                    Icon(
                      post.isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color:
                          post.isLiked
                              ? AppColors.forumLike
                              : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.likeCount}',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
