import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import 'forum_post_detail_page.dart';
import 'widgets/tab_item.dart';
import 'widgets/post_card.dart';
import '../../shared/models/forum_post.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  int _currentSubTab = 0;

  // 取得排序後的貼文列表
  List<ForumPost> get _sortedPosts {
    // TODO: 從後端獲取貼文列表
    final list = List<ForumPost>.from(dummyForumPosts);
    if (_currentSubTab == 0) {
      list.sort((a, b) => b.replyCount.compareTo(a.replyCount)); // 熱門：依留言數排序
    } else {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // 最新：依時間排序
    }
    return list;
  }

  // 發文按鈕
  void _onFabPressed() {
    // TODO: 實作發文功能
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('提示'),
            content: const Text('發文功能尚未實作'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('確定'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('論壇', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: AppColors.secondary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                TabItem(
                  label: '熱門',
                  index: 0,
                  isSelected: _currentSubTab == 0,
                  onTap: () => setState(() => _currentSubTab = 0),
                ),
                TabItem(
                  label: '最新',
                  index: 1,
                  isSelected: _currentSubTab == 1,
                  onTap: () => setState(() => _currentSubTab = 1),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _sortedPosts.length,
                itemBuilder: (context, index) {
                  final post = _sortedPosts[index];
                  return PostCard(
                    post: post,
                    onTap: () async {
                      // 導航到詳情頁，返回時刷新數據
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumPostDetailPage(post: post),
                        ),
                      );
                      setState(() {}); // 更新點讚數/留言數
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
