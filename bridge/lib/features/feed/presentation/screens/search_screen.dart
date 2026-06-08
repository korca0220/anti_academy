import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_providers.dart';
import '../widgets/feed_item.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  // TODO: 검색어 상태를 관리할 변수를 선언하세요. (예: String _query = '')
  // 힌트: _controller에 addListener를 달거나 onChanged를 활용하세요.

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 아래 구조로 화면을 구성하세요.
    // Scaffold
    //   appBar: AppBar with SearchBar (TextField)
    //   body: _query가 비어있으면 안내 문구, 아니면 searchPostsProvider(_query).when(...)
    throw UnimplementedError();
  }
}
