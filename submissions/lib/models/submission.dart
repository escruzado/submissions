import 'package:uuid/uuid.dart';

enum Status { newSubmission, open, processing, reviewed, closed }

enum Service { web, mobile, other }

class Submission {
  const Submission({
    required this.id,
    this.name,
    this.email,
    this.phone,
    required this.service,
    required this.status,
    this.message,
    this.submittedAt,
    this.formVersion,
    this.internalNotes,
  });

  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final Service service;
  final Status status;
  final String? message;
  final DateTime? submittedAt;
  final String? formVersion;
  final String? internalNotes;

  Submission copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    Service? service,
    Status? status,
    String? message,
    DateTime? submittedAt,
    String? formVersion,
    String? internalNotes,
  }) {
    return Submission(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      service: service ?? this.service,
      message: message ?? this.message,
      submittedAt: submittedAt ?? this.submittedAt,
      formVersion: formVersion ?? this.formVersion,
      internalNotes: internalNotes ?? this.internalNotes,
    );
  }

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id']?.toString() ?? const Uuid().v4(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone']?.toString(),
      status: _parseStatus(json['status']),
      service: _parseService(json['service']),
      message: json['message'] as String?,
      submittedAt: json['submittedAt'] != null
          ? DateTime.tryParse(json['submittedAt'].toString())
          : null,
      formVersion: json['formVersion'] as String?,
      internalNotes: json['internalNotes'] as String?,
    );
  }
  static Service _parseService(dynamic value) {
    final raw = value?.toString().trim().toLowerCase() ?? '';

    if (raw.contains('web')) return Service.web;
    if (raw.contains('mobile')) return Service.mobile;

    return Service.other;
  }

  static Status _parseStatus(dynamic value) {
    final raw = value?.toString().trim().toLowerCase() ?? '';

    const List<String> newKeywords = ['new'];
    const List<String> openKeywords = ['open', 'in review', 'in_review'];
    const List<String> processingKeywords = ['pending', 'process'];
    const List<String> reviewedKeywords = ['reviewed', 'finish'];
    const List<String> closedKeywords = ['close'];

    if (newKeywords.any((e) => raw.contains(e))) {
      return Status.newSubmission;
    }
    if (openKeywords.any((e) => raw.contains(e))) {
      return Status.open;
    }
    if (processingKeywords.any((e) => raw.contains(e))) {
      return Status.processing;
    }
    if (reviewedKeywords.any((e) => raw.contains(e))) {
      return Status.reviewed;
    }
    if (closedKeywords.any((e) => raw.contains(e))) {
      return Status.closed;
    }

    return Status.processing;
  }
}
