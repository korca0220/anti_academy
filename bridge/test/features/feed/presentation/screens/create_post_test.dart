import 'package:bridge/features/auth/presentation/providers/auth_providers.dart';
import 'package:bridge/features/feed/domain/repositories/post_repository.dart';
import 'package:bridge/features/feed/presentation/providers/post_providers.dart';
import 'package:bridge/features/feed/presentation/screens/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([PostRepository])
import 'create_post_test.mocks.dart';

void main() {
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
  });

  testWidgets('Submitting form calls createPost', (WidgetTester tester) async {
    // 1. Arrange: Stub createPost to return success
    when(mockRepository.createPost(any)).thenAnswer((_) async {
      return;
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postRepositoryProvider.overrideWithValue(mockRepository),
          currentUserIdProvider.overrideWithValue('test-user-id'),
        ],
        child: const MaterialApp(home: CreatePostScreen()),
      ),
    );

    // 2. Act: Enter Title & Content
    // (Assuming we use specific keys or labels)
    // But since the UI is empty now, these finders will fail -> RED state.

    // TODO: Enter text into Title field
    await tester.enterText(find.byKey(const Key('titleField')), 'New Request');

    // TODO: Enter text into Content field
    await tester.enterText(find.byKey(const Key('contentField')), 'Need help!');

    // TODO: Tap Submit button
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // 3. Assert
    verify(mockRepository.createPost(any)).called(1);

    // For now, let's just assert that we can FIND the fields, which will fail.
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });
}
