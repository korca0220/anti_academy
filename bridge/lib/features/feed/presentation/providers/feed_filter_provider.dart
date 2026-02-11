import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/post.dart';

enum FeedFilter {
  all,
  request,
  offer;

  PostType? get toPostType => switch (this) {
        FeedFilter.all => null,
        FeedFilter.request => PostType.request,
        FeedFilter.offer => PostType.offer,
      };
}

final feedFilterProvider = StateProvider<FeedFilter>(
  (ref) => FeedFilter.all,
);
