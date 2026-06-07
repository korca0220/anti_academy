import 'package:flutter/material.dart';

class ProfileViewError extends StatelessWidget {
  const ProfileViewError({
    super.key,
    required this.error,
  });

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: $error'));
  }
}
