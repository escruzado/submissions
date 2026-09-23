import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:submissions/models/submission.dart';

class SubmissionsNotifier extends Notifier<List<Submission>> {
  List<Submission> _allItems = [];
  String _query = '';
  @override
  List<Submission> build() {
    _loadSubmissions();
    return [];
  }

  Future<void> _loadSubmissions() async {
    final String response = await rootBundle.loadString(
      'lib/data/submissions.json',
    );

    final data = jsonDecode(response) as List<dynamic>;

    _allItems = data
        .map((e) => Submission.fromJson(e as Map<String, dynamic>))
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
      final sub = item;
      return (sub.name?.toLowerCase().contains(q) ?? false) ||
          (sub.email?.toLowerCase().contains(q) ?? false) ||
          (sub.phone?.toLowerCase().contains(q) ?? false) ||
          sub.status.name.toLowerCase().contains(q) ||
          sub.service.name.toLowerCase().contains(q);
    }).toList();
  }

  void markAsReviewed(String id, Status newStatus) {
    _allItems = [
      for (final item in _allItems)
        if (item.id == id) item.copyWith(status: newStatus) else item,
    ];

    state = _allItems;
  }
}

final submissionsProvider =
    NotifierProvider<SubmissionsNotifier, List<Submission>>(
      SubmissionsNotifier.new,
    );
