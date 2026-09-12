import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../list/data/list_items_provider.dart';
import '../summary/data/summary_cards_provider.dart';
import 'widgets/latest_list_preview.dart';
import 'widgets/summary_card_carousel.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryCards = ref.watch(summaryCardsProvider);
    final listItems = ref.watch(listItemsProvider);
    final latestItems = listItems.take(3).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        Text('ようこそ', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _SectionHeader(
          title: 'サマリー',
          onViewAll: () => context.push('/summary'),
        ),
        const SizedBox(height: 8),
        SummaryCardCarousel(cards: summaryCards),
        const SizedBox(height: 24),
        _SectionHeader(title: '一覧の最新情報', onViewAll: () => context.go('/list')),
        const SizedBox(height: 8),
        LatestListPreview(items: latestItems),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onViewAll});

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onViewAll, child: const Text('すべて見る')),
      ],
    );
  }
}
