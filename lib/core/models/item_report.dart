enum ReportType { lost, found }

class ItemReport {
  final String id;
  final ReportType type;
  final String title;
  final String description;
  final String category;
  final String locationText;
  final String? challengeQuestion;
  final String? photoUrl;
  final String? reporterId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ItemReport({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
    required this.locationText,
    this.challengeQuestion,
    this.photoUrl,
    this.reporterId,
    required this.createdAt,
    required this.updatedAt,
  });

  ItemReport copyWith({
    String? id,
    ReportType? type,
    String? title,
    String? description,
    String? category,
    String? locationText,
    String? challengeQuestion,
    String? photoUrl,
    String? reporterId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ItemReport(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      locationText: locationText ?? this.locationText,
      challengeQuestion: challengeQuestion ?? this.challengeQuestion,
      photoUrl: photoUrl ?? this.photoUrl,
      reporterId: reporterId ?? this.reporterId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'category': category,
      'locationText': locationText,
      'challengeQuestion': challengeQuestion,
      'photoUrl': photoUrl,
      'reporterId': reporterId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ItemReport.fromJson(Map<String, dynamic> json) {
    final typeStr = (json['type'] ?? 'lost') as String;
    final parsedType = ReportType.values.where((e) => e.name == typeStr).cast<ReportType?>().firstOrNull ?? ReportType.lost;
    return ItemReport(
      id: (json['id'] ?? '') as String,
      type: parsedType,
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      category: (json['category'] ?? '') as String,
      locationText: (json['locationText'] ?? '') as String,
      challengeQuestion: json['challengeQuestion'] as String?,
      photoUrl: json['photoUrl'] as String?,
      reporterId: json['reporterId'] as String?,
      createdAt: DateTime.tryParse((json['createdAt'] ?? '') as String) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? '') as String) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    );
  }
}

extension FirstOrNullExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
