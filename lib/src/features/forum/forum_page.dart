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

  List<ForumPost> get _sortedPosts {
    final list = List<ForumPost>.from(dummyForumPosts);
    if (_currentSubTab == 0) {
      list.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    } else {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('知識中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
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
                      setState(() {});
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
