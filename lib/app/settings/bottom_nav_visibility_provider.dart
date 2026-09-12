import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/shared_preferences_provider.dart';

const _bottomNavVisibleKey = 'settings.bottomNavVisible';

class BottomNavVisibilityController extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_bottomNavVisibleKey) ?? true;
  }

  Future<void> setVisible(bool visible) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_bottomNavVisibleKey, visible);
    state = visible;
  }
}

final bottomNavVisibilityProvider =
    NotifierProvider<BottomNavVisibilityController, bool>(
      BottomNavVisibilityController.new,
    );
