import 'package:flutter_some_screen/features/summary/summary_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets('shows summary card titles and values', (tester) async {
    await pumpApp(tester, const SummaryListScreen());

    expect(find.text('サマリー一覧'), findsOneWidget);
    expect(find.text('未読件数'), findsOneWidget);
    expect(find.text('12件'), findsOneWidget);
  });
}
