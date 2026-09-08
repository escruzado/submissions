import 'package:flutter/material.dart';
import 'package:submissions/models/submission.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({required this.status, super.key});
  final Status status;

  Color _getBorderColor(ColorScheme colorScheme) {
    return switch (status) {
      Status.newSubmission => colorScheme.primary,
      Status.open => Colors.lightBlueAccent,
      Status.processing => Colors.orange,
      Status.reviewed => Colors.purple,
      Status.closed => colorScheme.error,
    };
  }

  Color _getBackgroundColor(ColorScheme colorScheme) {
    return switch (status) {
      Status.newSubmission => colorScheme.surface,
      Status.open => Colors.lightBlueAccent,
      Status.processing => colorScheme.surface,
      Status.reviewed => Colors.greenAccent,
      Status.closed => colorScheme.surface,
    };
  }

  Color _getFontColor(ColorScheme colorScheme) {
    return switch (status) {
      Status.newSubmission => colorScheme.primary,
      Status.open => colorScheme.onPrimaryContainer,
      Status.processing => colorScheme.onSurface,
      Status.reviewed => colorScheme.onSurface,
      Status.closed => colorScheme.error,
    };
  }

  String get _label {
    return switch (status) {
      Status.newSubmission => 'New',
      Status.open => 'Open',
      Status.processing => 'Processing',
      Status.reviewed => 'Reviewed',
      Status.closed => 'Closed',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(width: 1.5, color: _getBorderColor(colorScheme)),
        color: _getBackgroundColor(colorScheme),
      ),
      child: Text(
        _label,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: textTheme.bodyMedium!.copyWith(
          color: _getFontColor(colorScheme),
        ),
      ),
    );
  }
}
