import 'package:flutter/material.dart';
import 'package:flutter_some_screen/features/settings/settings_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets('shows theme swatches and bottom nav toggle', (tester) async {
    await pumpApp(tester, const SettingsScreen());

    expect(find.text('カラーテーマ'), findsOneWidget);
    expect(find.text('ブルー'), findsOneWidget);
    expect(find.text('ティール'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
  });

  testWidgets('toggling the switch updates its value', (tester) async {
    await pumpApp(tester, const SettingsScreen());

    final switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(switchFinder);
    await tester.pump();

    expect(tester.widget<Switch>(switchFinder).value, isFalse);
  });
}
