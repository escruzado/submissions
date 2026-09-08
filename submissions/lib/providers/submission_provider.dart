import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissions/models/submission.dart';
import 'package:submissions/models/table_item.dart';

class SubmissionsNotifier extends Notifier<List<TableItem>> {
  List<TableItem> _allItems = [];
  String _query = '';
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

    _allItems = data
        .map(
          (e) =>
              TableItem(data: Submission.fromJson(e as Map<String, dynamic>)),
        )
        .toList();

    state = _allItems;
  }

  void updateQuery(String query) {
    _query = query;
    if (query.isEmpty) {
      state = _allItems;
    }
  }

  void search() {
    if (_query.isEmpty) {
      state = _allItems;
      return;
    }

    final q = _query.toLowerCase().trim();

    state = _allItems.where((item) {
      final sub = item.data;
      return (sub.name?.toLowerCase().contains(q) ?? false) ||
          (sub.email?.toLowerCase().contains(q) ?? false) ||
          (sub.phone?.toLowerCase().contains(q) ?? false) ||
          sub.status.name.toLowerCase().contains(q) ||
          sub.service.name.toLowerCase().contains(q);
    }).toList();
  }

  void markAsReviewed(String id, Status newStatus) {
    final updated = [
      for (final item in state)
        if (item.data.id == id)
          item.copyWith(data: item.data.copyWith(status: newStatus))
        else
          item,
    ];

    state = updated;

    _allItems = [
      for (final item in _allItems)
        if (item.data.id == id)
          item.copyWith(data: item.data.copyWith(status: newStatus))
        else
          item,
    ];
  }
}

final submissionsProvider =
    NotifierProvider<SubmissionsNotifier, List<TableItem>>(
      SubmissionsNotifier.new,
    );
