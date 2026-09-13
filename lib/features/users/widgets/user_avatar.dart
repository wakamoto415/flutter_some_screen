import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.name, this.radius = 20});

  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final initial = name.isEmpty ? '?' : name.substring(0, 1);

    return CircleAvatar(
      radius: radius,
      child: Text(initial, style: TextStyle(fontSize: radius * 0.8)),
    );
  }
}
