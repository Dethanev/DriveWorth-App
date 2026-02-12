import 'dart:math';
import 'package:flutter/material.dart';
import 'package:drive_worth/src/shared/utils/sound.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../shared/models/analysis_record.dart';
import '../../shared/widgets/segmented_control.dart';
import 'analyze_history_sheet.dart';
import 'widgets/input_section.dart';
import 'widgets/result_panel.dart';

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  late int _tabIndex;
  final List<String> _tabs = ['電話', '網址', '文字', '圖片'];
  final TextEditingController _inputController = TextEditingController();

  bool _isAnalyzing = false;
  RiskLevel? _resultLevel;
  int _resultScore = 0;

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    Sound.click2();
    setState(() {
      _tabIndex = index;
      _resultLevel = null; // 切換分頁時重置結果
      _inputController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialIndex;
  }

  Future<void> _startAnalysis() async {
    if (_inputController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('請先輸入資料')));
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isAnalyzing = true;
      _resultLevel = null;
    });

    // TODO: 連接分析 API
    await Future.delayed(const Duration(seconds: 2)); // 模擬 API 延遲

    if (!mounted) return;

    // TODO: 使用真實 API 回應取代模擬結果
    final random = Random(); // 目前為模擬隨機結果
    final levels = [RiskLevel.safe, RiskLevel.suspicious, RiskLevel.danger];
    final pickedLevel = levels[random.nextInt(levels.length)];
    final score = random.nextInt(100);

    setState(() {
      _isAnalyzing = false;
      _resultLevel = pickedLevel;
      _resultScore = score;
    });
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AnalyzeHistorySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text('分析', style: AppTextStyles.h2),
          actions: [
            IconButton(
              icon: const Icon(Icons.history_rounded),
              color: Colors.black,
              onPressed: _showHistory,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SegmentedControl(
                  tabs: _tabs,
                  currentIndex: _tabIndex,
                  onChanged: _onTabChanged,
                ),
                const SizedBox(height: 24),

                InputSection(
                  tabIndex: _tabIndex,
                  controller: _inputController,
                  isAnalyzing: _isAnalyzing,
                  onStartAnalysis: _startAnalysis,
                ),
                const SizedBox(height: 24),

                Divider(
                  color: AppColors.textSecondary.withValues(alpha: 0.15),
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(height: 24),

                Expanded(
                  child: ResultPanel(
                    isAnalyzing: _isAnalyzing, // 分析中狀態
                    resultLevel: _resultLevel, // 風險等級
                    resultScore: _resultScore, // 可信度分數
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
