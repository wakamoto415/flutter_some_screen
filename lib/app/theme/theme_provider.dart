import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/shared_preferences_provider.dart';
import 'theme_seed.dart';

const _themeSeedKey = 'theme.seed';

class ThemeController extends Notifier<ThemeSeed> {
  @override
  ThemeSeed build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return themeSeedFromName(prefs.getString(_themeSeedKey));
  }

  Future<void> setTheme(ThemeSeed seed) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_themeSeedKey, seed.name);
    state = seed;
  }
}

final themeProvider = NotifierProvider<ThemeController, ThemeSeed>(
  ThemeController.new,
);
