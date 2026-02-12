class AppUser {
  final String id;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppUser({required this.id, this.email, required this.createdAt, required this.updatedAt});

  AppUser copyWith({String? id, String? email, DateTime? createdAt, DateTime? updatedAt}) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: (json['id'] ?? '') as String,
      email: json['email'] as String?,
      createdAt: DateTime.tryParse((json['createdAt'] ?? '') as String) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? '') as String) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    );
  }
}
