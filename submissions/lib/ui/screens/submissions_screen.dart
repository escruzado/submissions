import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissions/providers/submission_provider.dart';
import 'package:submissions/ui/widgets/submission_screen/search_bar.dart';
import 'package:submissions/ui/widgets/submission_screen/submissions_list.dart';

class SubmissionsScreen extends ConsumerStatefulWidget {
  const SubmissionsScreen({super.key});

  @override
  ConsumerState<SubmissionsScreen> createState() => _SubmissionsScreenState();
}

class _SubmissionsScreenState extends ConsumerState<SubmissionsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    // final colorScheme = theme.colorScheme;
    final submissionsList = ref.watch(submissionsProvider);
    // print(submissionsList[0].data.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Submissions', style: textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchBar(
                onSearch: () {
                  ref.read(submissionsProvider.notifier).search();
                },
                onChanged: (value) {
                  ref.read(submissionsProvider.notifier).updateQuery(value);
                },
              ),
            ),
            if (submissionsList.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('No results found', style: textTheme.bodyLarge),
                ),
              )
            else
              SubmissionsList(submissionsList: submissionsList),
          ],
        ),
      ),
    );
  }
}
