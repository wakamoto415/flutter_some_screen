import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../settings/bottom_nav_visibility_provider.dart';
import 'app_drawer.dart';
import 'floating_bottom_nav_bar.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabTitles = ['トップ', '一覧', 'ユーザー一覧'];
  static const _usersTabIndex = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = navigationShell.currentIndex;
    final showBottomNav = ref.watch(bottomNavVisibilityProvider);
    final isUsersTab = selectedIndex == _usersTabIndex;

    return Scaffold(
      appBar: isUsersTab
          ? null
          : AppBar(title: Text(_tabTitles[selectedIndex])),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Positioned.fill(child: navigationShell),
          if (showBottomNav)
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingBottomNavBar(
                selectedIndex: selectedIndex,
                onSelect: (index) => navigationShell.goBranch(
                  index,
                  initialLocation: index == selectedIndex,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
