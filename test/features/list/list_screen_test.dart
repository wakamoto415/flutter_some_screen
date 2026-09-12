import 'package:flutter_some_screen/features/list/list_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets('shows mock list items', (tester) async {
    await pumpApp(tester, const ListScreen());

    expect(find.text('プロジェクトA提案書'), findsOneWidget);
    expect(find.text('週次レポート'), findsOneWidget);
  });
}
