import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../shared/utils/sound.dart';
import '../../shared/models/forum_post.dart';
import 'forum_post_detail_page.dart';
import 'widgets/post_card.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<ForumPost> get _posts {
    final list = List<ForumPost>.from(dummyForumPosts);
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
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
        title: Text('知識中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            final post = _posts[index];
            return PostCard(
              post: post,
              onTap: () async {
                Sound.click();
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
    );
  }
}
