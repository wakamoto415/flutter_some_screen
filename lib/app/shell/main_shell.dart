import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../settings/bottom_nav_visibility_provider.dart';
import 'app_drawer.dart';
import 'floating_bottom_nav_bar.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _tabPaths = ['/dashboard', '/list'];
  static const _tabTitles = ['トップ', '一覧'];

  int _indexForLocation(String location) {
    final index = _tabPaths.indexWhere(location.startsWith);
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _indexForLocation(location);
    final showBottomNav = ref.watch(bottomNavVisibilityProvider);

    return Scaffold(
      appBar: AppBar(title: Text(_tabTitles[selectedIndex])),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Positioned.fill(child: child),
          if (showBottomNav)
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingBottomNavBar(
                selectedIndex: selectedIndex,
                onSelect: (index) => context.go(_tabPaths[index]),
              ),
            ),
        ],
      ),
    );
  }
}
