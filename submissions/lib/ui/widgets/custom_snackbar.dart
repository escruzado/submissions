import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  // final theme = Theme.of(context);
  // final textTheme = theme.textTheme;
  // final colorScheme = theme.colorScheme;

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
