import 'package:flutter/material.dart';
import 'package:flutter_some_screen/features/login/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets('shows email/password fields and login button', (tester) async {
    await pumpApp(tester, const LoginScreen());

    expect(find.text('メールアドレス'), findsOneWidget);
    expect(find.text('パスワード'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'ログイン'), findsOneWidget);
  });

  testWidgets('shows validation errors for invalid input', (tester) async {
    await pumpApp(tester, const LoginScreen());

    await tester.enterText(find.byType(TextFormField).first, 'not-an-email');
    await tester.enterText(find.byType(TextFormField).last, '123');
    await tester.tap(find.widgetWithText(FilledButton, 'ログイン'));
    await tester.pump();

    expect(find.text('メールアドレスの形式が正しくありません'), findsOneWidget);
    expect(find.text('パスワードは6文字以上で入力してください'), findsOneWidget);
  });
}
