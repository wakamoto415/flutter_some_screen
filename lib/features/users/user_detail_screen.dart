import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/users_provider.dart';
import 'models/user.dart';
import 'widgets/status_chip.dart';
import 'widgets/user_avatar.dart';

class UserDetailScreen extends ConsumerWidget {
  const UserDetailScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ユーザー詳細')),
      body: usersAsync.when(
        data: (users) {
          final matches = users.where((u) => u.id == userId);
          final user = matches.isEmpty ? null : matches.first;
          if (user == null) {
            return const Center(child: Text('ユーザーが見つかりません'));
          }
          return _UserDetailBody(user: user);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('読み込みに失敗しました'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(usersProvider),
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserDetailBody extends StatelessWidget {
  const _UserDetailBody({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(name: user.name, radius: 48),
          const SizedBox(height: 16),
          Text(user.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          StatusChip(status: user.status),
          const SizedBox(height: 8),
          Text(
            '更新日: ${formatUserDate(user.updatedAt)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
