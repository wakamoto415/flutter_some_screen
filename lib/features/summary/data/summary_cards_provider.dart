import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/summary_card.dart';

final summaryCardsProvider = Provider<List<SummaryCard>>((ref) {
  return const [
    SummaryCard(title: '未読件数', value: '12件', icon: Icons.mark_email_unread),
    SummaryCard(title: '進行中タスク', value: '8件', icon: Icons.pending_actions),
    SummaryCard(title: '完了率', value: '76%', icon: Icons.check_circle),
    SummaryCard(title: '今月の新規登録', value: '34件', icon: Icons.person_add),
    SummaryCard(title: '承認待ち', value: '5件', icon: Icons.hourglass_top),
    SummaryCard(title: 'アクティブユーザー', value: '210人', icon: Icons.groups),
  ];
});
