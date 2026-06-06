import 'package:flutter/material.dart';

class ReviewBottomSheet extends StatefulWidget {
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
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final _commentController = TextEditingController();
  int _rating = 5;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: reviewRepositoryProvider를 통해 createReview 호출
                  // TODO: 중복 리뷰/실패 케이스 UI 처리
                  Navigator.of(context).pop();
                },
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
