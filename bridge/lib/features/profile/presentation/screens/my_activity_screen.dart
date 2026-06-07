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
    // TODO: DefaultTabController로 감싸고 두 개의 탭('내 게시글', '거래 내역')을 구성하세요.
    // 힌트: TabBar는 AppBar의 bottom에, TabBarView는 body에 배치합니다.
    return DefaultTabController(
        length: MyActivityTab.values.length,
        initialIndex: MyActivityTab.values.indexOf(MyActivityTab.posts),
        child: Column(
          children: [
            TabBar(
                tabs: MyActivityTab.values
                    .map((e) => Tab(text: e.label))
                    .toList()),
            const TabBarView(
              children: [
                MyPostsTab(),
                MyTransactionsTab(),
              ],
            ),
          ],
        ));
  }
}
