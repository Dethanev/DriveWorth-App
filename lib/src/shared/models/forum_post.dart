class ForumComment {
  final String content;
  final DateTime createdAt;
  final String userName;

  ForumComment({
    required this.content,
    required this.createdAt,
    this.userName = '熱心網友',
  });
}

class ForumPost {
  final String tag;
  final String title;
  final String snippet;
  final String content;
  final DateTime createdAt;

  int replyCount;
  int likeCount;
  bool isLiked;

  final List<ForumComment> comments;

  ForumPost({
    required this.tag,
    required this.title,
    required this.snippet,
    required this.content,
    required this.createdAt,
    required this.replyCount,
    this.likeCount = 0,
    this.isLiked = false,
    List<ForumComment>? comments,
  }) : comments = comments ?? [];
}

final List<ForumPost> dummyForumPosts = [
  ForumPost(
    tag: '保養',
    title: '機油多久換一次？原廠與手冊說法整理',
    snippet: '依用車習慣與里程，建議 5,000～10,000 公里或每半年檢查一次。',
    content: '''多數車主手冊會寫 5,000 或 10,000 公里更換，視機油等級與用車環境而定。常跑市區、短程多，可考慮提早；全合成油搭配高速居多，可拉長間隔。記得依原廠規範與實際駕駛習慣做取捨。''',
    createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
    replyCount: 0,
    likeCount: 89,
  ),
  ForumPost(
    tag: '省錢',
    title: '加油省錢小技巧：善用信用卡與自助加油',
    snippet: '自助加油每公升可省 1～2 元，再搭配現金回饋卡更划算。',
    content: '''自助加油通常比人工每公升便宜 1～2 元，長期累積很有感。再選一張有加油回饋的信用卡，或配合加油站會員日，可以再省一點。記得避開尖峰時段，油槍也比較不會排隊。''',
    createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
    replyCount: 0,
    likeCount: 156,
  ),
  ForumPost(
    tag: '稅務',
    title: '牌照稅、燃料稅什麼時候繳？一次搞懂',
    snippet: '牌照稅 4 月開徵，燃料稅 7 月；自用車依排氣量與燃料類型計費。',
    content: '''牌照稅每年 4 月開徵，燃料稅 7 月。金額依排氣量（汽油車）或重量（柴油車）計算，可在監理服務網或超商查詢繳納。逾期會加徵滯納金，記得按時繳。''',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    replyCount: 0,
    likeCount: 72,
  ),
  ForumPost(
    tag: '小知識',
    title: '輪胎胎壓多少才對？冷胎壓與熱胎壓差異',
    snippet: '依車門或手冊標示的冷胎壓為準，約 32～36 psi 較常見。',
    content: '''胎壓請以「冷胎」為準，即停車至少 3 小時未行駛後量測。駕駛座車門框或手冊會標示建議值，常見約 32～36 psi。胎壓過低耗油、過高影響抓地，每月檢查一次即可。''',
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    replyCount: 0,
    likeCount: 43,
  ),
  ForumPost(
    tag: '省油',
    title: '市區開車怎樣比較省油？',
    snippet: '輕踩油門、少急煞、冷氣適度、減少怠速，習慣差很多。',
    content: '''起步輕踩、預判紅燈提早收油、少重踩煞車，油耗會好很多。冷氣別開到最冷，怠速超過 1 分鐘可考慮熄火。定期保養、胎壓正確也有幫助。''',
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    replyCount: 0,
    likeCount: 61,
  ),
];
