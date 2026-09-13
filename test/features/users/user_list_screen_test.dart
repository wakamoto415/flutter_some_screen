import 'package:flutter/material.dart';
import 'package:flutter_some_screen/features/users/models/user.dart';
import 'package:flutter_some_screen/features/users/user_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils/pump_app.dart';

void main() {
  testWidgets('shows mock users after loading', (tester) async {
    await pumpApp(tester, const UserListScreen());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('佐藤 太郎'), findsOneWidget);
  });

  testWidgets('filters the list by search query', (tester) async {
    await pumpApp(tester, const UserListScreen());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '佐藤');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.text('佐藤 太郎'), findsOneWidget);
    expect(find.text('鈴木 花子'), findsNothing);
  });

  testWidgets('changes order when a sort option is selected', (tester) async {
    await pumpApp(tester, const UserListScreen());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    await tester.tap(find.text('更新日（新しい順）'));
    await tester.pumpAndSettle();

    final firstTile = tester.widgetList<ListTile>(find.byType(ListTile)).first;
    expect((firstTile.title as Text).data, '加藤 舞');
  });

  testWidgets('shows a status chip per user', (tester) async {
    await pumpApp(tester, const UserListScreen());
    await tester.pumpAndSettle();

    expect(find.widgetWithText(Chip, 'オンライン'), findsWidgets);
    expect(find.widgetWithText(Chip, 'オフライン'), findsWidgets);
    expect(find.widgetWithText(Chip, '退会済み'), findsWidgets);
  });

  testWidgets('narrows the list when a status filter is selected', (
    tester,
  ) async {
    await pumpApp(tester, const UserListScreen());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(PopupMenuItem<UserStatus?>, 'オンライン'));
    await tester.pumpAndSettle();

    expect(find.text('佐藤 太郎'), findsOneWidget);
    expect(find.text('鈴木 花子'), findsNothing);
    expect(find.text('伊藤 健太'), findsNothing);
  });
}
