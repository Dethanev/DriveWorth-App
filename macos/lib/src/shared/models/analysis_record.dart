enum RiskLevel { safe, suspicious, danger }

class AnalysisRecord {
  final String id;
  final String title;
  final String type; // "電話" / "網址" / "文字" / "圖片"
  final RiskLevel riskLevel;
  final DateTime createdAt;

  AnalysisRecord({
    required this.id,
    required this.title,
    required this.type,
    required this.riskLevel,
    required this.createdAt,
  });
}

final List<AnalysisRecord> dummyAnalysisRecords = [
  AnalysisRecord(
    id: '1',
    title: '+886 912 345 678',
    type: '電話',
    riskLevel: RiskLevel.suspicious,
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  AnalysisRecord(
    id: '2',
    title: 'http://claim-your-prize.xyz',
    type: '網址',
    riskLevel: RiskLevel.danger,
    createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
  ),
  AnalysisRecord(
    id: '3',
    title: '親愛的用戶，您的帳戶存在異常...',
    type: '文字',
    riskLevel: RiskLevel.danger,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  AnalysisRecord(
    id: '4',
    title: 'shopee.tw',
    type: '網址',
    riskLevel: RiskLevel.safe,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  AnalysisRecord(
    id: '5',
    title: '02 2345 6789',
    type: '電話',
    riskLevel: RiskLevel.safe,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  AnalysisRecord(
    id: '6',
    title: '投資群組.jpg',
    type: '圖片',
    riskLevel: RiskLevel.suspicious,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
];