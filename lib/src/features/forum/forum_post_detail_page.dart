import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../shared/models/forum_post.dart';
import 'widgets/time_ago.dart';

class ForumPostDetailPage extends StatefulWidget {
  final ForumPost post;

  const ForumPostDetailPage({super.key, required this.post});

  @override
  State<ForumPostDetailPage> createState() => _ForumPostDetailPageState();
}

class _ForumPostDetailPageState extends State<ForumPostDetailPage> {
  late TextEditingController _commentController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // 點讚功能
  void _toggleLike() {
    // TODO: 連接點讚 API
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
      if (widget.post.isLiked) {
        widget.post.likeCount++;
      } else {
        widget.post.likeCount--;
      }
    });
  }

  // 發送留言
  void _submitComment() {
    if (_commentController.text.trim().isEmpty) return;

    // TODO: 連接發送留言 API
    setState(() {
      widget.post.comments.add(
        ForumComment(
          content: _commentController.text.trim(),
          createdAt: DateTime.now(),
          userName: '我', // TODO: 從後端獲取當前登入使用者
        ),
      );
      widget.post.replyCount++;
      _commentController.clear();
    });

    // 送出後自動捲動到底部
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('文章詳情', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
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
                    ),
                    child: Text(
                      widget.post.tag,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 12,
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

                  Row(
                    children: [
                      _LikeButton(
                        isLiked: widget.post.isLiked,
                        count: widget.post.likeCount,
                        onTap: _toggleLike,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.comment_outlined,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.post.replyCount} 則留言',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  Text('所有留言', style: AppTextStyles.bodyBold),
                  const SizedBox(height: 16),

                  if (widget.post.comments.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          '目前還沒有留言，快來搶頭香！',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ...widget.post.comments.map(
                      (comment) => _CommentItem(comment: comment),
                    ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: '輸入留言...',
                      hintStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _submitComment,
                  icon: const Icon(Icons.send, color: AppColors.secondary),
                ),
              ],
            ),
          ),
        ],
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
                  : AppColors.transparent,
          border: Border.all(
            color: isLiked ? AppColors.forumLike : AppColors.textSecondary,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: isLiked ? AppColors.forumLike : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: TextStyle(
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

class _CommentItem extends StatelessWidget {
  final ForumComment comment;

  const _CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
            child: Text(
              comment.userName[0],
              style: const TextStyle(color: AppColors.secondary, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    TimeAgo(date: comment.createdAt),
                  ],
                ),
                const SizedBox(height: 4),
                Text(comment.content, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
