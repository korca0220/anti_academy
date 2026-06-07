import 'package:flutter/material.dart';

class NoReviewsYet extends StatelessWidget {
  const NoReviewsYet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: Text('No reviews yet')),
    );
  }
}
