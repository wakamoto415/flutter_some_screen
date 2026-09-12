import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/summary_cards_provider.dart';

class SummaryListScreen extends ConsumerWidget {
  const SummaryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(summaryCardsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('サマリー一覧')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cards.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final card = cards[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(card.icon)),
              title: Text(card.title),
              trailing: Text(
                card.value,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
