import 'package:flutter/material.dart';
import 'package:submissions/models/table_item.dart';
import 'package:submissions/ui/widgets/submission_row.dart';

class SubmissionsList extends StatefulWidget {
  const SubmissionsList({required this.submissionsList, super.key});

  final List<TableItem> submissionsList;

  @override
  State<SubmissionsList> createState() => _SubmissionsListState();
}

class _SubmissionsListState extends State<SubmissionsList> {
  @override
  Widget build(BuildContext context) {
    final List<TableItem> data = widget.submissionsList;
    // final theme = Theme.of(context);
    // final textTheme = theme.textTheme;
    // final colorScheme = theme.colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return SubmissionRow(item: data[index]);
      },
    );
  }
}
