import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissions/models/submission.dart';

class SubmissionsNotifier extends AsyncNotifier<List<Submission>> {
  @override
  Future<List<Submission>> build() async {
    return await _loadSubmissions();
  }

  Future<List<Submission>> _loadSubmissions() async {
    final String response = await rootBundle.loadString(
      'lib/data/submissions.json',
    );

    final data = jsonDecode(response) as List<dynamic>;

    return data.map((e) => Submission.fromJson(e)).toList();
  }

  void markAsReviewed(String id, Status newStatus) {
    state = AsyncData([
      for (final sub in state.value ?? [])
        if (sub.id == id) sub.copyWith(status: newStatus) else sub,
    ]);
  }
}

final submissionsProvider =
    AsyncNotifierProvider<SubmissionsNotifier, List<Submission>>(
      SubmissionsNotifier.new,
    );
