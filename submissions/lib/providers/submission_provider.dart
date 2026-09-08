import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissions/models/submission.dart';
import 'package:submissions/models/table_item.dart';

class SubmissionsNotifier extends Notifier<List<TableItem>> {
  @override
  List<TableItem> build() {
    _loadSubmissions();
    return [];
  }

  Future<void> _loadSubmissions() async {
    final String response = await rootBundle.loadString(
      'lib/data/submissions.json',
    );

    final data = jsonDecode(response) as List<dynamic>;

    state = data
        .map(
          (e) =>
              TableItem(data: Submission.fromJson(e as Map<String, dynamic>)),
        )
        .toList();
  }

  void markAsReviewed(String id, Status newStatus) {
    state = [
      for (final item in state)
        if (item.data.id == id)
          item.copyWith(data: item.data.copyWith(status: newStatus))
        else
          item,
    ];
  }

  void toggleExpand(String id) {
    state = [
      for (final item in state)
        if (item.data.id == id)
          item.copyWith(isExpanded: !item.isExpanded)
        else
          item,
    ];
  }
}

final submissionsProvider =
    NotifierProvider<SubmissionsNotifier, List<TableItem>>(
      SubmissionsNotifier.new,
    );
