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

ForumComment _cm(String user, String text, Duration ago) => ForumComment(
      userName: user,
      content: text,
      createdAt: DateTime.now().subtract(ago),
    );

final List<ForumPost> dummyForumPosts = [
  ForumPost(
    tag: '置頂',
    title: '【必看】一張圖看懂「假投資」完整劇本：從加LINE到誘導入金（附對話截圖描述）',
    snippet: '從「交朋友」到「出金建立信任」的完整流程拆給你看，附每一步紅旗警訊與反制句。',
    content: '''
我把近期最常見的「假投資」詐騙流程整理成一個可視化劇本（你可以想像成劇本分鏡）。

【詐騙流程（高機率版本）】
1) 陌生私訊：IG/FB/交友軟體 → 先聊天建立信任（不談錢）
2) 曬獲利：丟幾張截圖、對帳單、假新聞 → 讓你覺得「很多人都在賺」
3) 拉群：進「投資老師群」→ 群裡大量假學員演戲：感謝、晒獲利、催你跟單
4) 小額入金：先叫你投 3000~5000 → 再讓你「出金成功」一次建立信任
5) 大額加碼：用時間壓力 + 限時名額 + 保證獲利 → 逼你壓更大
6) 卡出金：出金要「保證金/稅金/驗證費」→ 一直拖、一直要你付更多

【紅旗警訊（看到 2 個以上 = 直接高風險）】
- 保證獲利、穩賺不賠、內線、名額有限、今天一定要上車
- 要你改用私訊/加LINE、要你下載不明App、要你匯到私人帳戶
- 出金要先付費（這句幾乎是鐵證）

【反制句（給自己 & 給家人）】
- 「我先掛掉，我會用官方管道查證。」
- 「我不會提供 OTP、帳密、信用卡安全碼。」
- 「要匯款/下載App/遠端協助的一律拒絕。」

大家如果願意，把你遇到的話術貼出來，我可以幫你標記是哪一段劇本、對應哪個紅旗。
''',
    createdAt: DateTime.now().subtract(const Duration(minutes: 6)),
    replyCount: 12,
    likeCount: 184,
    comments: [
      _cm('阿哲', '這篇太神…完全就是我朋友遇到的流程，連「出金成功一次」都一樣。', const Duration(minutes: 50)),
      _cm('小安', '紅旗清單很實用，我直接截圖傳家人。', const Duration(minutes: 35)),
      _cm('熱心網友', '可以補一條：叫你加入「助理」私訊回報倉位，也是常見套路。', const Duration(minutes: 18)),
      _cm('我', '收到！我等等把「助理/回報倉位」加進去。', const Duration(minutes: 10)),
      _cm('小美', '老師群裡那種「恭喜又賺」真的很洗腦…', const Duration(minutes: 8)),
      _cm('阿明', '請問遇到已匯款的，第一步是打165嗎？', const Duration(minutes: 6)),
      _cm('熱心網友', '是，先停損：銀行止付/凍結 + 165 + 留存證據。', const Duration(minutes: 4)),
      _cm('我', '對，先止付/凍結再談追回，速度最重要。', const Duration(minutes: 2)),
      _cm('小宇', '這篇根本可以當教材。', const Duration(minutes: 1)),
      _cm('貓貓', '我看完才知道之前差點中招…', const Duration(minutes: 1)),
      _cm('路人甲', '能不能做成圖卡？更好分享。', const Duration(minutes: 1)),
      _cm('我', '可以，我之後會做成圖卡版放在「分享」標籤。', const Duration(minutes: 0)),
    ],
  ),

  ForumPost(
    tag: '案例',
    title: '【最新手法】「iCloud/Apple ID 登入異常」釣魚信超逼真，連寄件網域都在玩障眼法',
    snippet: '假信用「30 分鐘內驗證」逼你慌，短網址轉跳 + 偽裝官網頁面蒐集帳密。',
    content: '''
今天收到一封「Apple ID 登入異常」的信，版面、字體、Logo 都做得很像官方。

【我觀察到的可疑點】
- 內容用時間壓力：「30 分鐘內驗證，否則停用」
- 連結是短網址（會轉跳多次）
- 登入頁要求輸入帳密後，還要你輸入信用卡資訊（這很不合理）

【我怎麼確認】
1) 不點信內連結
2) 直接打開官方 App/官方網站登入檢查
3) 把連結丟到鷹眼守護分析：命中「短網址 + 可疑跳轉鏈 + 表單蒐集」

【結論】
只要它逼你「立刻做」、還要你「輸入一堆敏感資料」，就算看起來很像真的，也要先當成高風險處理。
''',
    createdAt: DateTime.now().subtract(const Duration(minutes: 18)),
    replyCount: 4,
    likeCount: 76,
    comments: [
      _cm('Kiki', '我也收到過類似的，但是假的是「Apple Pay 設定異常」。', const Duration(minutes: 30)),
      _cm('熱心網友', '短網址真的要小心，通常就是要躲避檢測。', const Duration(minutes: 22)),
      _cm('我', '對，而且轉跳鏈很長的那種更可疑。', const Duration(minutes: 15)),
      _cm('阿偉', '請問你怎麼看寄件者真假？', const Duration(minutes: 10)),
    ],
  ),

  ForumPost(
    tag: '求助',
    title: '我可能已經輸入 OTP 了…現在該做什麼？（已做哪些動作、下一步求建議）',
    snippet: '對方自稱銀行客服說交易異常，我緊張就把 OTP 念出去了…已改密碼但不確定夠不夠。',
    content: '''
剛剛接到自稱銀行客服來電，說我帳戶「交易異常」，要我配合「取消可疑交易」。
我一緊張就把簡訊 OTP 念出去了…掛掉才覺得不對。

【目前我已做】
- 已改網銀/信用卡相關密碼（能改的都改了）
- 已截圖簡訊、保留來電號碼與通話時間

【我不確定接下來】
- 要不要立刻凍結帳戶/信用卡？
- 要不要報警或打 165？
- 如果詐團已經登入，我要檢查哪些地方？

【請大家給我一個「現在立刻做」的清單】
我希望先止損，之後再處理追查。
''',
    createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
    replyCount: 6,
    likeCount: 93,
    comments: [
      _cm('熱心網友', '先打銀行客服「官方電話」：停止網銀/停卡/設高風險警示。', const Duration(minutes: 25)),
      _cm('小安', '165 也要打，讓你知道怎麼留證據。', const Duration(minutes: 22)),
      _cm('阿哲', '檢查有沒有新增約定帳戶、登入裝置、交易紀錄。', const Duration(minutes: 18)),
      _cm('我', '收到，我先去打銀行官方電話。', const Duration(minutes: 15)),
      _cm('路人甲', 'OTP 幾乎等於把門禁卡交出去…越快越好。', const Duration(minutes: 10)),
      _cm('熱心網友', '對，時間很重要：先止損再討論。', const Duration(minutes: 7)),
    ],
  ),

  ForumPost(
    tag: '公告',
    title: '🔒 鷹眼守護：新增「短網址展開」與「可疑跳轉鏈」提示，分析結果更像真安全工具',
    snippet: '短網址展開、跳轉鏈可視化、風險原因更清楚（社工/釣魚/資料蒐集）。',
    content: '''
本次更新重點：

【新增】
- 短網址展開：顯示最終落地網址（避免被短網址騙過）
- 可疑跳轉鏈：列出「從哪跳到哪」，越多層越可疑
- 風險原因文字化：不只給分數，還會告訴你「為什麼」

【接下來預告】
- 圖片偵測：針對釣魚頁截圖、假對帳單、假獲利圖做輔助判斷
- 常見詐騙話術庫：偵測「時間壓力 / 恐嚇 / 保證獲利」語意

歡迎把你遇到的網址或簡訊情境（去個資後）貼上來當測試案例。
''',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    replyCount: 3,
    likeCount: 41,
    comments: [
      _cm('小美', '風險原因超重要，長輩看到原因才會信。', const Duration(minutes: 40)),
      _cm('阿明', '跳轉鏈可以做成小圖嗎？一眼看懂那種。', const Duration(minutes: 25)),
      _cm('我', '有打算做成小圖示版，讓 UI 更直覺。', const Duration(minutes: 15)),
    ],
  ),

  ForumPost(
    tag: '心得',
    title: '第一次遇到「假物流」：說我包裹卡關要補運費，連介面都像真的',
    snippet: '簡訊叫我點連結付款 29 元，但頁面卻要信用卡＋簡訊驗證碼。',
    content: '''
今天收到「包裹配送異常」簡訊，叫我補運費 29 元。

【可疑點】
- 明明是補 29 元，卻要我輸入完整信用卡資料 + 簡訊驗證碼
- 網址不是物流官方網域
- 內文一直催我「24 小時內完成」

【我的做法】
1) 直接到官方 App 查包裹（真的有的話官方一定查得到）
2) 不點短網址
3) 丟到鷹眼守護分析：命中「釣魚表單/資料蒐集」

差一點就被「小額付款」騙過，這招真的很賊。
''',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    replyCount: 2,
    likeCount: 28,
    comments: [
      _cm('阿哲', '小額付款就是陷阱，重點是偷你卡資料。', const Duration(minutes: 80)),
      _cm('熱心網友', '對，29 元只是誘餌，後面才是大刀。', const Duration(minutes: 65)),
    ],
  ),

  ForumPost(
    tag: '疑問',
    title: '「法院通知/傳票」電話是真的假的？對方叫我不要跟任何人說',
    snippet: '恐嚇口吻 + 要你加LINE收公文，這到底是不是標準詐騙？',
    content: '''
我接到一通電話說我涉及案件，要我配合「偵查」，還說「偵查不公開，不要跟家人說」。
接著要我加 LINE 收「公文」和「案件編號」。

這整套很像詐騙，但他講得很像真的…
有人遇過這種嗎？通常正規流程會怎麼做？
''',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    replyCount: 3,
    likeCount: 17,
    comments: [
      _cm('熱心網友', '標準詐騙：偵查不公開 + 加LINE 收公文，99% 假的。', const Duration(minutes: 130)),
      _cm('小安', '真的法院/警局不會用LINE發公文，直接掛掉。', const Duration(minutes: 120)),
      _cm('我', '收到，我已封鎖號碼並保留通話紀錄。', const Duration(minutes: 110)),
    ],
  ),

  ForumPost(
    tag: '分享',
    title: '我整理了 10 個「一聽就該掛電話」的關鍵字（給長輩超有用）',
    snippet: '偵查不公開、不要告訴家人、ATM解除分期、保證獲利…做成 A4 版。',
    content: '''
這份是我給爸媽的「掛電話關鍵字」清單，主打簡單好記。

【出現就掛的關鍵字】
1) 偵查不公開 / 不要告訴家人
2) ATM 解除分期 / 轉帳驗證 / 金流清查
3) 保證獲利 / 內線 / 限時名額
4) 你的帳戶被監管 / 涉嫌洗錢
5) 需要遠端協助 / 下載App / 加LINE處理
6) 立刻處理不然停權/停用/出事

【加一句超好用反制句】
「我會掛掉後用官方電話回撥確認。」

需要我把它做成更像「圖卡」的版本也可以。
''',
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    replyCount: 1,
    likeCount: 64,
    comments: [
      _cm('小美', '這個我真的要印出來貼冰箱。', const Duration(minutes: 210)),
    ],
  ),

  ForumPost(
    tag: '討論',
    title: '詐騙集團為什麼都愛用「時間壓力」？心理戰真的有效嗎',
    snippet: '「現在不處理就停權/被扣款」這種話術怎麼破？',
    content: '''
我觀察到詐騙話術有一個共通點：製造時間壓力，讓你沒時間查證。

想問大家：
- 你們遇到時間壓力時，怎麼讓自己冷靜？
- 你覺得 App 應該要怎麼提示用戶「先停下來」？

我在想要不要在高風險結果頁加一句「先停 10 秒」+ 行動清單。
''',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    replyCount: 2,
    likeCount: 21,
    comments: [
      _cm('熱心網友', '有效，因為人緊張就會走捷徑。你那個「先停10秒」很棒。', const Duration(minutes: 260)),
      _cm('阿明', '建議加「官方回撥」按鈕文字引導，直接降低操作成本。', const Duration(minutes: 245)),
    ],
  ),

  ForumPost(
    tag: '求助',
    title: '有人遇過「假客服遠端協助」嗎？對方叫我安裝 TeamViewer/AnyDesk',
    snippet: '說幫我取消訂閱扣款，但一直要我下載遠端軟體。',
    content: '''
對方說我「訂閱要扣款」，可以幫我取消，但需要我安裝遠端軟體協助操作。
我覺得怪就沒裝，但家人差點下載。

想問：
- 有沒有「正規客服」會要求遠端？
- 如果不小心裝了遠端軟體，第一步該做什麼？
''',
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    replyCount: 2,
    likeCount: 34,
    comments: [
      _cm('熱心網友', '正規客服幾乎不會要求你裝這類遠端工具，裝了就先斷網+移除+掃毒。', const Duration(minutes: 310)),
      _cm('我', '收到，我會把「遠端協助」設成高風險特徵。', const Duration(minutes: 290)),
    ],
  ),

];
