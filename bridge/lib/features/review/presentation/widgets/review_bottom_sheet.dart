import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/review_providers.dart';

class ReviewBottomSheet extends ConsumerStatefulWidget {
  const ReviewBottomSheet({
    super.key,
    required this.transactionId,
    required this.roomId,
    required this.reviewerId,
    required this.revieweeId,
  });

  final String transactionId;
  final String roomId;
  final String reviewerId;
  final String revieweeId;

  @override
  ConsumerState<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends ConsumerState<ReviewBottomSheet> {
  final _commentController = TextEditingController();
  int _rating = 5;
  String? _errorMessage;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(reviewSubmitControllerProvider,
        (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (!mounted) return;
          final messenger = ScaffoldMessenger.of(context);
          Navigator.of(context).pop();
          messenger.showSnackBar(
            const SnackBar(content: Text('리뷰가 저장되었습니다.')),
          );
        },
        error: (error, _) {
          if (!mounted) return;
          final message = error.toString().contains('23505')
              ? '이미 이 거래에 리뷰를 작성했습니다.'
              : '리뷰 저장에 실패했습니다.';
          setState(() => _errorMessage = message);
        },
      );
    });

    final submitState = ref.watch(reviewSubmitControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '리뷰 남기기',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _rating,
              decoration: const InputDecoration(labelText: '별점'),
              items: const [
                DropdownMenuItem(value: 1, child: Text('1점')),
                DropdownMenuItem(value: 2, child: Text('2점')),
                DropdownMenuItem(value: 3, child: Text('3점')),
                DropdownMenuItem(value: 4, child: Text('4점')),
                DropdownMenuItem(value: 5, child: Text('5점')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _rating = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: '코멘트',
                hintText: '거래 경험을 간단히 남겨주세요.',
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.red,
                    ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitState.isLoading
                    ? null
                    : () {
                        setState(() => _errorMessage = null);
                        ref
                            .read(reviewSubmitControllerProvider.notifier)
                            .submit(
                              transactionId: widget.transactionId,
                              roomId: widget.roomId,
                              reviewerId: widget.reviewerId,
                              revieweeId: widget.revieweeId,
                              rating: _rating,
                              comment: _commentController.text.trim(),
                            );
                      },
                child: submitState.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
