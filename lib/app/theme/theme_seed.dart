import 'package:flutter/material.dart';

enum ThemeSeed {
  blue('ブルー', Colors.blue),
  green('グリーン', Colors.green),
  purple('パープル', Colors.deepPurple),
  orange('オレンジ', Colors.orange),
  red('レッド', Colors.red),
  teal('ティール', Colors.teal);

  const ThemeSeed(this.label, this.color);

  final String label;
  final Color color;
}

ThemeSeed themeSeedFromName(String? name) {
  return ThemeSeed.values.firstWhere(
    (seed) => seed.name == name,
    orElse: () => ThemeSeed.blue,
  );
}
