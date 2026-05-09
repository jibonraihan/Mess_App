class Mess {
  final String id;
  final String name;
  final DateTime createdAt;
  final String inviteCode;
  final String adminId;
  final List<String> memberIds;

  // NEW
  final String? avatarUrl;
  final String? description;

  const Mess({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.inviteCode,
    required this.adminId,
    required this.memberIds,

    this.avatarUrl,
    this.description,
  });

  Mess copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? inviteCode,
    String? adminId,
    List<String>? memberIds,

    String? avatarUrl,
    String? description,
  }) {
    return Mess(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      inviteCode: inviteCode ?? this.inviteCode,
      adminId: adminId ?? this.adminId,
      memberIds: memberIds ?? this.memberIds,

      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
    );
  }
}