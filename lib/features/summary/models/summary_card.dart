import 'package:flutter/material.dart';

class SummaryCard {
  const SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;
}
