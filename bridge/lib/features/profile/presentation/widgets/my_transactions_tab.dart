import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/widgets/empty_state_widget.dart';
import '../providers/my_activity_providers.dart';

class MyTransactionsTab extends ConsumerWidget {
  const MyTransactionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(myTransactionsProvider);

    return transactionsAsync.when(
      error: (err, __) => Center(child: Text('Error: $err')),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (transactions) {
        if (transactions.isEmpty) {
          return const EmptyStateWidget(
              title: '거래 내역이 없어요',
              subtitle: '첫 번째 거래를 시작해보세요!',
              iconData: Icons.shopping_bag_outlined);
        }
        return ListView.separated(
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            return ListTile(
              title: Text(transaction.status.name),
              subtitle: Text(transaction.roomId),
              leading: Badge(label: Text(transaction.status.name)),
            );
          },
        );
      },
    );
  }
}
