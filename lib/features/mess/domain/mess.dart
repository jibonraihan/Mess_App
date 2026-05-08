import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'mess.freezed.dart';

// Enum for user roles within a mess
enum UserRole {
  @JsonValue('admin')
  admin,
  @JsonValue('coAdmin')
  coAdmin,
  @JsonValue('member')
  member,
}

// Represents a user's membership in a mess
@freezed
class Membership with _$Membership {
  const factory Membership({
    required String userId,
    required String messId,
    required UserRole role,
    required DateTime joinedAt,
  }) = _Membership;
}

// Represents a single mess
@freezed
class Mess with _$Mess {
  const factory Mess({
    required String id,
    required String name,
    required String inviteCode,
    required String adminId, // ID of the user who is the primary admin
    required List<String> memberIds, // List of user IDs who are members
    String? avatar,
    required DateTime createdAt,
  }) = _Mess;
}
