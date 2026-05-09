import 'dart:typed_data';

class Mess {
  final String id;
  final String name;
  final DateTime createdAt;
  final String inviteCode;
  final String adminId;
  final List<String> memberIds;

  final String? description;
  final Uint8List? avatarBytes;

  const Mess({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.inviteCode,
    required this.adminId,
    required this.memberIds,

    this.description,
    this.avatarBytes,
  });

  Mess copyWith({
  String? id,
  String? name,
  DateTime? createdAt,
  String? inviteCode,
  String? adminId,
  List<String>? memberIds,
  String? description,

  Uint8List? avatarBytes,
  bool removeAvatar = false,
}) {
  return Mess(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt:
        createdAt ?? this.createdAt,
    inviteCode:
        inviteCode ?? this.inviteCode,
    adminId:
        adminId ?? this.adminId,
    memberIds:
        memberIds ?? this.memberIds,

    description:
        description ?? this.description,

    avatarBytes:
        removeAvatar
            ? null
            : avatarBytes ??
                this.avatarBytes,
  );
}
}