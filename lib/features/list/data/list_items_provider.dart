import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/list_item.dart';

final listItemsProvider = Provider<List<ListItem>>((ref) {
  return const [
    ListItem(
      title: 'プロジェクトA提案書',
      description: '来週の定例会議で共有する提案資料です。',
      icon: Icons.description,
    ),
    ListItem(
      title: '週次レポート',
      description: '今週の進捗と課題をまとめたレポート。',
      icon: Icons.summarize,
    ),
    ListItem(
      title: 'デザインレビュー依頼',
      description: '新しい画面デザインのレビューをお願いします。',
      icon: Icons.palette,
    ),
    ListItem(
      title: 'サーバーメンテナンス通知',
      description: '今週末にメンテナンスを予定しています。',
      icon: Icons.dns,
    ),
    ListItem(
      title: '新メンバー歓迎会',
      description: 'チームに新しく加わったメンバーの歓迎会です。',
      icon: Icons.celebration,
    ),
    ListItem(
      title: 'コードレビュー依頼',
      description: 'プルリクエストのレビューをお願いします。',
      icon: Icons.rate_review,
    ),
    ListItem(
      title: 'リリースノート',
      description: '最新バージョンの変更点をまとめました。',
      icon: Icons.new_releases,
    ),
    ListItem(
      title: '顧客フィードバック',
      description: '先日の顧客ヒアリングで得た意見の共有。',
      icon: Icons.feedback,
    ),
  ];
});
