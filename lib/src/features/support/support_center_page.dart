import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_decorations.dart';
import '../../config/app_text_styles.dart';
import 'support_chat_message.dart';

class SupportCenterPage extends StatefulWidget {
  const SupportCenterPage({super.key});

  @override
  State<SupportCenterPage> createState() => _SupportCenterPageState();
}

class _SupportCenterPageState extends State<SupportCenterPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<SupportChatMessage> _messages = [
    SupportChatMessage(
      text: '你好！有任何用車或 App 上的問題都可以跟我說。',
      isUser: false,
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    SupportChatMessage(
      text: '想請問 TCO 分析裡的稅金是怎麼算的？',
      isUser: true,
      createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    SupportChatMessage(
      text: '稅金是依車種與排氣量，用政府公式估算的年度牌照稅＋燃料稅，僅供參考喔。',
      isUser: false,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(SupportChatMessage(text: text, isUser: true, createdAt: DateTime.now()));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _messages.add(SupportChatMessage(
          text: '我們已收到，會盡快回覆。',
          isUser: false,
          createdAt: DateTime.now(),
        ));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('客服中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return _ChatBubble(message: m);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.black, width: AppDecorations.neuBorderWidth)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48, maxHeight: 120),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: AppDecorations.neuCard,
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: '輸入訊息...',
                        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      style: AppTextStyles.body,
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: AppDecorations.neuButton(),
                    child: const Icon(Icons.send_rounded, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final SupportChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.secondary : AppColors.white,
          border: Border.all(color: AppColors.black, width: AppDecorations.neuBorderWidth),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              offset: AppDecorations.neuShadowOffset,
              blurRadius: AppDecorations.neuShadowBlur,
            ),
          ],
        ),
        child: Text(
          message.text,
          style: AppTextStyles.body,
        ),
      ),
    );
  }
}
