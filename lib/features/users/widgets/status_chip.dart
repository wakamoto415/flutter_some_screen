import 'package:flutter/material.dart';

import '../models/user.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final UserStatus status;

  Color get _color => switch (status) {
    UserStatus.online => Colors.green,
    UserStatus.offline => Colors.grey,
    UserStatus.withdrawn => Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(status.label),
      labelStyle: TextStyle(color: _color, fontSize: 12),
      backgroundColor: _color.withValues(alpha: 0.12),
      side: BorderSide(color: _color.withValues(alpha: 0.4)),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
