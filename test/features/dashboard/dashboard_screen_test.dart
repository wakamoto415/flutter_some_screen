import 'package:flutter_some_screen/features/dashboard/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets(
    'shows welcome message, summary section, and latest list preview',
    (tester) async {
      await pumpApp(tester, const DashboardScreen());

      expect(find.text('ようこそ'), findsOneWidget);
      expect(find.text('サマリー'), findsOneWidget);
      expect(find.text('一覧の最新情報'), findsOneWidget);
      expect(find.text('すべて見る'), findsNWidgets(2));
    },
  );
}
