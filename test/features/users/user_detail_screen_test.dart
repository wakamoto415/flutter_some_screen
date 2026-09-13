import 'package:flutter/material.dart';
import 'package:flutter_some_screen/features/users/user_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets('shows the matching user after loading', (tester) async {
    await pumpApp(tester, const UserDetailScreen(userId: '1'));

    await tester.pumpAndSettle();

    expect(find.text('佐藤 太郎'), findsOneWidget);
    expect(find.text('更新日: 2026/08/20'), findsOneWidget);
    expect(find.widgetWithText(Chip, 'オンライン'), findsOneWidget);
  });

  testWidgets('shows a not-found message for an unknown id', (tester) async {
    await pumpApp(tester, const UserDetailScreen(userId: 'unknown'));

    await tester.pumpAndSettle();

    expect(find.text('ユーザーが見つかりません'), findsOneWidget);
  });
}
