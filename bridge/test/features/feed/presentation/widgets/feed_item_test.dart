import 'package:bridge/features/feed/domain/entities/post.dart';
import 'package:bridge/features/feed/presentation/widgets/feed_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FeedItem displays post details correctly',
      (WidgetTester tester) async {
    // 1. Arrange: Create a sample post
    final post = Post(
      id: '1',
      authorId: 'abc',
      type: PostType.request, // Request Type
      title: 'Need Help Moving',
      content: 'Can someone help me move a sofa?',
      status: PostStatus.open,
      imageUrls: [],
      createdAt: DateTime.now(),
    );

    // 2. Act: Pump the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeedItem(post: post),
        ),
      ),
    );

    // 3. Assert (Should fail initially)
    expect(find.text('Need Help Moving'), findsOneWidget); // Title check
    expect(find.text('Can someone help me move a sofa?'),
        findsOneWidget); // Content check

    // Type Badge Check (New Requirement!)
    // We expect 'Request' text to be present for PostType.request
    expect(find.text('Request'), findsOneWidget);
  });
}
