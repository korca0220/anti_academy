import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/widgets/empty_state_widget.dart';
import '../providers/post_providers.dart';
import '../widgets/feed_item.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  String _query = '';

  @override
  void initState() {
    _controller.addListener(_onQueryChanged);

    super.initState();
  }

  void _onQueryChanged() {
    setState(() {
      _query = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onQueryChanged);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search',
          ),
        ),
      ),
      body: _query.isEmpty
          ? const Center(child: Text('Enter a search term'))
          : ref.watch(searchPostsProvider(_query)).when(
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (posts) => posts.isEmpty
                    ? const EmptyStateWidget(
                        title: 'No results found',
                        subtitle: 'Try a different search term',
                        iconData: Icons.search,
                      )
                    : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) =>
                            FeedItem(post: posts[index]),
                      ),
              ),
    );
  }
}
