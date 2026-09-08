import 'package:submissions/models/submission.dart';

class TableItem {
  TableItem({required this.data, this.isExpanded = false});

  Submission data;
  bool isExpanded;

  TableItem copyWith({Submission? data, bool? isExpanded}) {
    return TableItem(
      data: data ?? this.data,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
