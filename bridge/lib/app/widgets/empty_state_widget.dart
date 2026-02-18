import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.iconData = Icons.inbox,
    this.onActionPressed,
    this.actionLabel,
  });

  final String title;
  final String? subtitle;
  final IconData iconData;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement Empty State UI
    // 1. Center content
    // 2. Large Icon (color: disabled/grey)
    // 3. Title (bold)
    // 4. Subtitle (optional)
    // 5. Action Button (optional)

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 80.0,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 8),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
          if (onActionPressed != null) ...[
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onActionPressed,
              child: Text(actionLabel ?? 'Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
