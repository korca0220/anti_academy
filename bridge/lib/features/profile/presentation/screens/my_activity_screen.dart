import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/my_posts_tab.dart';
import '../widgets/my_transactions_tab.dart';

enum MyActivityTab {
  posts('내 게시글'),
  transactions('거래 내역');

  const MyActivityTab(this.label);
  final String label;
}

class MyActivityScreen extends ConsumerWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: MyActivityTab.values.length,
        initialIndex: MyActivityTab.values.indexOf(MyActivityTab.posts),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Activity'),
            bottom: TabBar(
              tabs:
                  MyActivityTab.values.map((e) => Tab(text: e.label)).toList(),
            ),
          ),
          body: const TabBarView(
            children: [
              MyPostsTab(),
              MyTransactionsTab(),
            ],
          ),
        ));
  }
}
