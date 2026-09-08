import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissions/providers/submission_provider.dart';
import 'package:submissions/ui/widgets/submission_screen/submissions_list.dart';

class SubmissionsScreen extends ConsumerStatefulWidget {
  const SubmissionsScreen({super.key});

  @override
  ConsumerState<SubmissionsScreen> createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends ConsumerState<SubmissionsScreen> {
  @override
  Widget build(BuildContext context) {
    final submissionsList = ref.watch(submissionsProvider);
    // print(submissionsList[0].data.toString());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text('SEARCH BAR HERE'),
            // const SizedBox(height: 8),
            // Text('ASC | SORT BY DROPDOWN | FILTER BY DROPDOWN | FILTER BUTTON'),
            // const SizedBox(height: 16),
            SubmissionsList(submissionsList: submissionsList),
          ],
        ),
      ),
    );
  }
}
