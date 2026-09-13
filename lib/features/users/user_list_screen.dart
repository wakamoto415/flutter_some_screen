import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'data/users_provider.dart';
import 'models/user.dart';
import 'widgets/status_chip.dart';
import 'widgets/user_avatar.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch() {
    ref.read(searchQueryProvider.notifier).set(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(filteredSortedUsersProvider);
    final sortOption = ref.watch(sortOptionProvider);
    final statusFilter = ref.watch(statusFilterProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: _FloatingHeader(
              searchController: _searchController,
              onSearch: _submitSearch,
              statusFilter: statusFilter,
              onStatusFilterSelected: (status) =>
                  ref.read(statusFilterProvider.notifier).set(status),
              sortOption: sortOption,
              onSortSelected: (option) =>
                  ref.read(sortOptionProvider.notifier).set(option),
            ),
          ),
          Expanded(
            child: usersAsync.when(
              data: (users) => _UserList(users: users),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  _ErrorView(onRetry: () => ref.invalidate(usersProvider)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingHeader extends StatelessWidget {
  const _FloatingHeader({
    required this.searchController,
    required this.onSearch,
    required this.statusFilter,
    required this.onStatusFilterSelected,
    required this.sortOption,
    required this.onSortSelected,
  });

  final TextEditingController searchController;
  final VoidCallback onSearch;
  final UserStatus? statusFilter;
  final ValueChanged<UserStatus?> onStatusFilterSelected;
  final UserSortOption sortOption;
  final ValueChanged<UserSortOption> onSortSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 4,
      shadowColor: Colors.black45,
      borderRadius: BorderRadius.circular(28),
      color: colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'ユーザー名で検索',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: onSearch,
                  ),
                ),
                onSubmitted: (_) => onSearch(),
              ),
            ),
            PopupMenuButton<UserStatus?>(
              icon: const Icon(Icons.filter_list),
              initialValue: statusFilter,
              onSelected: onStatusFilterSelected,
              itemBuilder: (context) => [
                const PopupMenuItem(value: null, child: Text('すべて')),
                for (final status in UserStatus.values)
                  PopupMenuItem(value: status, child: Text(status.label)),
              ],
            ),
            PopupMenuButton<UserSortOption>(
              icon: const Icon(Icons.sort),
              initialValue: sortOption,
              onSelected: onSortSelected,
              itemBuilder: (context) => [
                for (final option in UserSortOption.values)
                  PopupMenuItem(value: option, child: Text(option.label)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  const _UserList({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(child: Text('該当するユーザーが見つかりません'));
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
      itemCount: users.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            leading: UserAvatar(name: user.name),
            title: Text(user.name),
            subtitle: Text('更新日: ${formatUserDate(user.updatedAt)}'),
            trailing: StatusChip(status: user.status),
            onTap: () => context.push('/users/${user.id}'),
          ),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('読み込みに失敗しました'),
          const SizedBox(height: 12),
          FilledButton(onPressed: onRetry, child: const Text('再読み込み')),
        ],
      ),
    );
  }
}
