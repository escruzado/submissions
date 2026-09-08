import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:submissions/models/submission.dart';
import 'package:submissions/models/table_item.dart';
import 'package:submissions/providers/submission_provider.dart';
import 'package:submissions/ui/widgets/confirmation_modal.dart';
import 'package:submissions/ui/widgets/submission_detail_screen/review_button.dart';
import 'package:submissions/ui/widgets/submission_screen/status_pill.dart';

class SubmissionDetailScreen extends ConsumerStatefulWidget {
  const SubmissionDetailScreen({required this.data, super.key});
  final TableItem data;

  @override
  ConsumerState<SubmissionDetailScreen> createState() =>
      _SubmissionDetailScreenState();
}

class _SubmissionDetailScreenState
    extends ConsumerState<SubmissionDetailScreen> {
  void _reviewButton(BuildContext context, WidgetRef ref, String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmationModal(
        title: 'Mark as Reviewed',
        content: 'Are you sure you want to mark this submission as reviewed?',
      ),
    );

    if (confirmed == true) {
      ref
          .read(submissionsProvider.notifier)
          .markAsReviewed(id, Status.reviewed);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final Submission sub = widget.data.data;
    print(sub);

    return Scaffold(
      appBar: AppBar(title: Text('Submission Summary')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sender:', style: textTheme.bodyMedium),
            Text(
              sub.name == null || sub.name == '' ? 'No name' : sub.name!,
              style: textTheme.titleLarge,
            ),
            Text(
              sub.email == null || sub.email == '' ? 'No email' : sub.email!,
              style: textTheme.bodyLarge,
            ),
            Text(
              sub.phone == null || sub.phone == ''
                  ? 'No phone number'
                  : sub.phone!,
              style: textTheme.bodyLarge,
            ),
            const Divider(),
            const SizedBox(height: 8.0),
            Text('Other Information:', style: textTheme.bodyLarge),
            const SizedBox(height: 8.0),

            Row(
              children: [
                Text('Date Submitted:', style: textTheme.bodyMedium),
                const SizedBox(width: 16),
                Text(
                  sub.submittedAt != null
                      ? DateFormat('dd MMMM yyyy').format(sub.submittedAt!)
                      : 'No date provided',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            Row(
              children: [
                Text('Status:', style: textTheme.bodyMedium),
                const SizedBox(width: 16),
                StatusPill(status: sub.status),
              ],
            ),
            const SizedBox(height: 8.0),

            Row(
              children: [
                Text('Service:', style: textTheme.bodyMedium),
                const SizedBox(width: 16),
                Text(sub.service.name, style: textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 8.0),

            Row(
              children: [
                Text('Form Version:', style: textTheme.bodyMedium),
                const SizedBox(width: 16),
                Text(
                  sub.formVersion == null || sub.formVersion == ''
                      ? 'No Form Version'
                      : sub.formVersion!,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: sub.message ?? 'No message provided',
              enabled: false,
              maxLines: null,
              style: textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: 'Message',
                border: const OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.tertiary.withValues(alpha: 1),
                  ),
                ),
              ),
            ),
            if (sub.internalNotes != null && sub.internalNotes != '') ...[
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: sub.internalNotes ?? 'No message provided',
                enabled: false,
                maxLines: null,
                style: textTheme.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Internal Notes',
                  border: const OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorScheme.tertiary.withValues(alpha: 1),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar:
          sub.status != Status.reviewed && sub.status != Status.closed
          ? ReviewButton(
              onPress: () {
                _reviewButton(context, ref, sub.id);
              },
            )
          : null,
    );
  }
}
