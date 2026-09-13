import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';

enum UserSortOption {
  nameAsc('名前（昇順）'),
  nameDesc('名前（降順）'),
  updatedDesc('更新日（新しい順）'),
  updatedAsc('更新日（古い順）');

  const UserSortOption(this.label);

  final String label;
}

final usersProvider = FutureProvider<List<User>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));
  return _mockUsers;
});

class SearchQueryController extends Notifier<String> {
  @override
  String build() => '';

  void set(String query) => state = query;
}

final searchQueryProvider = NotifierProvider<SearchQueryController, String>(
  SearchQueryController.new,
);

class SortOptionController extends Notifier<UserSortOption> {
  @override
  UserSortOption build() => UserSortOption.nameAsc;

  void set(UserSortOption option) => state = option;
}

final sortOptionProvider =
    NotifierProvider<SortOptionController, UserSortOption>(
      SortOptionController.new,
    );

class StatusFilterController extends Notifier<UserStatus?> {
  @override
  UserStatus? build() => null;

  void set(UserStatus? status) => state = status;
}

final statusFilterProvider =
    NotifierProvider<StatusFilterController, UserStatus?>(
      StatusFilterController.new,
    );

final filteredSortedUsersProvider = Provider<AsyncValue<List<User>>>((ref) {
  final usersAsync = ref.watch(usersProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final sortOption = ref.watch(sortOptionProvider);
  final statusFilter = ref.watch(statusFilterProvider);

  return usersAsync.whenData((users) {
    var filtered = query.isEmpty
        ? users
        : users
              .where((user) => user.name.toLowerCase().contains(query))
              .toList();
    if (statusFilter != null) {
      filtered = filtered.where((user) => user.status == statusFilter).toList();
    }

    final sorted = [...filtered];
    switch (sortOption) {
      case UserSortOption.nameAsc:
        sorted.sort((a, b) => a.name.compareTo(b.name));
      case UserSortOption.nameDesc:
        sorted.sort((a, b) => b.name.compareTo(a.name));
      case UserSortOption.updatedDesc:
        sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      case UserSortOption.updatedAsc:
        sorted.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
    }
    return sorted;
  });
});

final _mockUsers = [
  User(
    id: '1',
    name: '佐藤 太郎',
    updatedAt: DateTime(2026, 8, 20),
    status: UserStatus.online,
  ),
  User(
    id: '2',
    name: '鈴木 花子',
    updatedAt: DateTime(2026, 9, 1),
    status: UserStatus.offline,
  ),
  User(
    id: '3',
    name: '高橋 一郎',
    updatedAt: DateTime(2026, 7, 15),
    status: UserStatus.offline,
  ),
  User(
    id: '4',
    name: '田中 美咲',
    updatedAt: DateTime(2026, 8, 30),
    status: UserStatus.online,
  ),
  User(
    id: '5',
    name: '伊藤 健太',
    updatedAt: DateTime(2026, 6, 10),
    status: UserStatus.withdrawn,
  ),
  User(
    id: '6',
    name: '渡辺 由美',
    updatedAt: DateTime(2026, 9, 5),
    status: UserStatus.offline,
  ),
  User(
    id: '7',
    name: '山本 直樹',
    updatedAt: DateTime(2026, 5, 22),
    status: UserStatus.offline,
  ),
  User(
    id: '8',
    name: '中村 麻衣',
    updatedAt: DateTime(2026, 8, 12),
    status: UserStatus.online,
  ),
  User(
    id: '9',
    name: '小林 大輔',
    updatedAt: DateTime(2026, 7, 2),
    status: UserStatus.offline,
  ),
  User(
    id: '10',
    name: '加藤 舞',
    updatedAt: DateTime(2026, 9, 8),
    status: UserStatus.offline,
  ),
  User(
    id: '11',
    name: '吉田 拓也',
    updatedAt: DateTime(2026, 4, 18),
    status: UserStatus.offline,
  ),
  User(
    id: '12',
    name: '山田 陽菜',
    updatedAt: DateTime(2026, 8, 25),
    status: UserStatus.online,
  ),
  User(
    id: '13',
    name: '佐々木 誠',
    updatedAt: DateTime(2026, 6, 30),
    status: UserStatus.offline,
  ),
  User(
    id: '14',
    name: '松本 恵子',
    updatedAt: DateTime(2026, 7, 28),
    status: UserStatus.offline,
  ),
  User(
    id: '15',
    name: '井上 涼太',
    updatedAt: DateTime(2026, 3, 14),
    status: UserStatus.withdrawn,
  ),
  User(
    id: '16',
    name: '木村 咲',
    updatedAt: DateTime(2026, 8, 3),
    status: UserStatus.offline,
  ),
  User(
    id: '17',
    name: '林 隆',
    updatedAt: DateTime(2026, 5, 9),
    status: UserStatus.offline,
  ),
  User(
    id: '18',
    name: '清水 香織',
    updatedAt: DateTime(2026, 9, 3),
    status: UserStatus.online,
  ),
  User(
    id: '19',
    name: '斎藤 悠斗',
    updatedAt: DateTime(2026, 2, 27),
    status: UserStatus.offline,
  ),
  User(
    id: '20',
    name: '山口 優子',
    updatedAt: DateTime(2026, 7, 19),
    status: UserStatus.offline,
  ),
  User(
    id: '21',
    name: '森 隼人',
    updatedAt: DateTime(2026, 6, 5),
    status: UserStatus.offline,
  ),
  User(
    id: '22',
    name: '池田 美穂',
    updatedAt: DateTime(2026, 8, 8),
    status: UserStatus.online,
  ),
  User(
    id: '23',
    name: '橋本 翔太',
    updatedAt: DateTime(2026, 1, 30),
    status: UserStatus.offline,
  ),
  User(
    id: '24',
    name: '阿部 千尋',
    updatedAt: DateTime(2026, 9, 6),
    status: UserStatus.offline,
  ),
  User(
    id: '25',
    name: '石川 大和',
    updatedAt: DateTime(2026, 4, 3),
    status: UserStatus.withdrawn,
  ),
  User(
    id: '26',
    name: '山下 綾香',
    updatedAt: DateTime(2026, 7, 11),
    status: UserStatus.offline,
  ),
  User(
    id: '27',
    name: '中島 康平',
    updatedAt: DateTime(2026, 3, 22),
    status: UserStatus.offline,
  ),
  User(
    id: '28',
    name: '前田 沙織',
    updatedAt: DateTime(2026, 8, 17),
    status: UserStatus.offline,
  ),
  User(
    id: '29',
    name: '藤田 蓮',
    updatedAt: DateTime(2026, 5, 27),
    status: UserStatus.online,
  ),
  User(
    id: '30',
    name: '後藤 光',
    updatedAt: DateTime(2026, 9, 2),
    status: UserStatus.offline,
  ),
];
