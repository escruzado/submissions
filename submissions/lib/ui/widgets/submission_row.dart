import 'package:flutter/material.dart';
import 'package:submissions/models/submission.dart';
import 'package:submissions/models/table_item.dart';
import 'package:submissions/ui/widgets/submission_screen/status_pill.dart';

class SubmissionRow extends StatefulWidget {
  const SubmissionRow({required this.item, super.key});

  final TableItem item;

  @override
  State<SubmissionRow> createState() => _SubmissionRowState();
}

class _SubmissionRowState extends State<SubmissionRow> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final Submission sub = widget.item.data;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.tertiary.withValues(alpha: 0.75),
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer.withValues(
                      alpha: 0.15,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    onTap: () {},
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.30,
                          child: Text(
                            sub.name == null || sub.name == ''
                                ? 'No name'
                                : sub.name!,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        StatusPill(status: sub.status),
                        const Spacer(),
                        SizedBox(
                          width: constraints.maxWidth * 0.15,
                          child: Text(
                            sub.service.name,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
