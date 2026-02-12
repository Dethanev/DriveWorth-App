import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../../../shared/models/analysis_record.dart';
import '../../../shared/widgets/status_badge.dart';

class ResultPanel extends StatelessWidget {
  final bool isAnalyzing;
  final RiskLevel? resultLevel;
  final int resultScore;

  const ResultPanel({
    super.key,
    required this.isAnalyzing,
    required this.resultLevel,
    required this.resultScore,
  });

  @override
  Widget build(BuildContext context) {
    if (isAnalyzing) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.secondary),
            SizedBox(height: 16),
            Text('正在比對資料庫…', style: AppTextStyles.body),
          ],
        ),
      );
    }

    if (resultLevel == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shield_outlined,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '請輸入資料並點選『開始分析』',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatusBadge(level: resultLevel!),
              const SizedBox(height: 24),
              Text(
                '可信度 $resultScore%',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text('分析完成', style: AppTextStyles.caption),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _getAdvice(resultLevel!),
                        style: AppTextStyles.body.copyWith(height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (resultLevel != RiskLevel.safe)
                TextButton.icon(
                  onPressed: () {
                    // TODO: 實作封鎖/檢舉功能
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('封鎖並回報'),
                            content: const Text('此功能開發中，將於後續版本提供。'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('確定'),
                              ),
                            ],
                          ),
                    );
                  },
                  icon: const Icon(Icons.block),
                  label: const Text('封鎖並回報'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.statusDanger,
                  ),
                )
              else
                TextButton.icon(
                  onPressed: () {
                    final resultText =
                        StringBuffer()
                          ..writeln('分析結果：安全')
                          ..writeln('可信度：$resultScore%')
                          ..writeln(_getAdvice(resultLevel!));

                    Clipboard.setData(
                      ClipboardData(text: resultText.toString()),
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('分析結果已複製')));
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('複製結果'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAdvice(RiskLevel level) {
    switch (level) {
      case RiskLevel.danger:
        return '【高風險】此號碼/連結具多項詐騙特徵（例如：催促、恐嚇、要求轉帳/提供OTP或帳密）。請立刻停止通話/關閉頁面，勿點擊任何連結、勿提供個資與驗證碼、勿匯款。若已操作，建議立即凍結帳戶/更改密碼，並撥打165反詐騙專線或銀行客服處理。';

      case RiskLevel.suspicious:
        return '【可疑】偵測到異常跡象（例如：陌生來電要求加LINE、提供短網址、聲稱中獎/欠費/包裹問題、要求遠端操作或下載App）。建議先不要照做，改用「官方網站/帳單上的電話」回撥確認；若對方要求提供OTP、帳密、信用卡資訊或轉帳，請直接視為高風險。';

      case RiskLevel.safe:
        return '【低風險】目前未發現明顯異常紀錄，但仍不能保證 100% 安全。遇到「要求立即處理、私下轉帳、提供驗證碼/個資、下載不明App或點短網址」等情境，請保持警覺；建議優先使用官方管道核對，並保留對話/轉帳紀錄以便後續查證。';
    }
  }
}
