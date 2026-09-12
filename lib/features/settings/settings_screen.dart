import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/settings/bottom_nav_visibility_provider.dart';
import '../../app/theme/theme_provider.dart';
import '../../app/theme/theme_seed.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final showBottomNav = ref.watch(bottomNavVisibilityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('カラーテーマ', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final seed in ThemeSeed.values)
                _ThemeSwatch(
                  seed: seed,
                  selected: seed == selectedTheme,
                  onTap: () => ref.read(themeProvider.notifier).setTheme(seed),
                ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('ボトムナビゲーションバーを表示'),
            subtitle: const Text('OFFにするとサイドメニューのみで画面を切り替えます'),
            value: showBottomNav,
            onChanged: (value) => ref
                .read(bottomNavVisibilityProvider.notifier)
                .setVisible(value),
          ),
        ],
      ),
    );
  }
}

class _ThemeSwatch extends StatelessWidget {
  const _ThemeSwatch({
    required this.seed,
    required this.selected,
    required this.onTap,
  });

  final ThemeSeed seed;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: seed.color,
                shape: BoxShape.circle,
                border: selected
                    ? Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 3,
                      )
                    : null,
              ),
              child: selected
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 4),
            Text(seed.label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
