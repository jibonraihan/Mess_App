// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mess.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Membership {
  String get userId => throw _privateConstructorUsedError;
  String get messId => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MembershipCopyWith<Membership> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembershipCopyWith<$Res> {
  factory $MembershipCopyWith(
    Membership value,
    $Res Function(Membership) then,
  ) = _$MembershipCopyWithImpl<$Res, Membership>;
  @useResult
  $Res call({String userId, String messId, UserRole role, DateTime joinedAt});
}

/// @nodoc
class _$MembershipCopyWithImpl<$Res, $Val extends Membership>
    implements $MembershipCopyWith<$Res> {
  _$MembershipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? messId = null,
    Object? role = null,
    Object? joinedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            messId: null == messId
                ? _value.messId
                : messId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MembershipImplCopyWith<$Res>
    implements $MembershipCopyWith<$Res> {
  factory _$$MembershipImplCopyWith(
    _$MembershipImpl value,
    $Res Function(_$MembershipImpl) then,
  ) = __$$MembershipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String messId, UserRole role, DateTime joinedAt});
}

/// @nodoc
class __$$MembershipImplCopyWithImpl<$Res>
    extends _$MembershipCopyWithImpl<$Res, _$MembershipImpl>
    implements _$$MembershipImplCopyWith<$Res> {
  __$$MembershipImplCopyWithImpl(
    _$MembershipImpl _value,
    $Res Function(_$MembershipImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? messId = null,
    Object? role = null,
    Object? joinedAt = null,
  }) {
    return _then(
      _$MembershipImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        messId: null == messId
            ? _value.messId
            : messId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$MembershipImpl with DiagnosticableTreeMixin implements _Membership {
  const _$MembershipImpl({
    required this.userId,
    required this.messId,
    required this.role,
    required this.joinedAt,
  });

  @override
  final String userId;
  @override
  final String messId;
  @override
  final UserRole role;
  @override
  final DateTime joinedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Membership(userId: $userId, messId: $messId, role: $role, joinedAt: $joinedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Membership'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('messId', messId))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('joinedAt', joinedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembershipImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.messId, messId) || other.messId == messId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, messId, role, joinedAt);

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MembershipImplCopyWith<_$MembershipImpl> get copyWith =>
      __$$MembershipImplCopyWithImpl<_$MembershipImpl>(this, _$identity);
}

abstract class _Membership implements Membership {
  const factory _Membership({
    required final String userId,
    required final String messId,
    required final UserRole role,
    required final DateTime joinedAt,
  }) = _$MembershipImpl;

  @override
  String get userId;
  @override
  String get messId;
  @override
  UserRole get role;
  @override
  DateTime get joinedAt;

  /// Create a copy of Membership
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MembershipImplCopyWith<_$MembershipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Mess {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get inviteCode => throw _privateConstructorUsedError;
  String get adminId =>
      throw _privateConstructorUsedError; // ID of the user who is the primary admin
  List<String> get memberIds =>
      throw _privateConstructorUsedError; // List of user IDs who are members
  String? get avatar => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Mess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessCopyWith<Mess> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessCopyWith<$Res> {
  factory $MessCopyWith(Mess value, $Res Function(Mess) then) =
      _$MessCopyWithImpl<$Res, Mess>;
  @useResult
  $Res call({
    String id,
    String name,
    String inviteCode,
    String adminId,
    List<String> memberIds,
    String? avatar,
    DateTime createdAt,
  });
}

/// @nodoc
class _$MessCopyWithImpl<$Res, $Val extends Mess>
    implements $MessCopyWith<$Res> {
  _$MessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? inviteCode = null,
    Object? adminId = null,
    Object? memberIds = null,
    Object? avatar = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            inviteCode: null == inviteCode
                ? _value.inviteCode
                : inviteCode // ignore: cast_nullable_to_non_nullable
                      as String,
            adminId: null == adminId
                ? _value.adminId
                : adminId // ignore: cast_nullable_to_non_nullable
                      as String,
            memberIds: null == memberIds
                ? _value.memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessImplCopyWith<$Res> implements $MessCopyWith<$Res> {
  factory _$$MessImplCopyWith(
    _$MessImpl value,
    $Res Function(_$MessImpl) then,
  ) = __$$MessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String inviteCode,
    String adminId,
    List<String> memberIds,
    String? avatar,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$MessImplCopyWithImpl<$Res>
    extends _$MessCopyWithImpl<$Res, _$MessImpl>
    implements _$$MessImplCopyWith<$Res> {
  __$$MessImplCopyWithImpl(_$MessImpl _value, $Res Function(_$MessImpl) _then)
    : super(_value, _then);

  /// Create a copy of Mess
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? inviteCode = null,
    Object? adminId = null,
    Object? memberIds = null,
    Object? avatar = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$MessImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        inviteCode: null == inviteCode
            ? _value.inviteCode
            : inviteCode // ignore: cast_nullable_to_non_nullable
                  as String,
        adminId: null == adminId
            ? _value.adminId
            : adminId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberIds: null == memberIds
            ? _value._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$MessImpl with DiagnosticableTreeMixin implements _Mess {
  const _$MessImpl({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.adminId,
    required final List<String> memberIds,
    this.avatar,
    required this.createdAt,
  }) : _memberIds = memberIds;

  @override
  final String id;
  @override
  final String name;
  @override
  final String inviteCode;
  @override
  final String adminId;
  // ID of the user who is the primary admin
  final List<String> _memberIds;
  // ID of the user who is the primary admin
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  // List of user IDs who are members
  @override
  final String? avatar;
  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Mess(id: $id, name: $name, inviteCode: $inviteCode, adminId: $adminId, memberIds: $memberIds, avatar: $avatar, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Mess'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('inviteCode', inviteCode))
      ..add(DiagnosticsProperty('adminId', adminId))
      ..add(DiagnosticsProperty('memberIds', memberIds))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    inviteCode,
    adminId,
    const DeepCollectionEquality().hash(_memberIds),
    avatar,
    createdAt,
  );

  /// Create a copy of Mess
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessImplCopyWith<_$MessImpl> get copyWith =>
      __$$MessImplCopyWithImpl<_$MessImpl>(this, _$identity);
}

abstract class _Mess implements Mess {
  const factory _Mess({
    required final String id,
    required final String name,
    required final String inviteCode,
    required final String adminId,
    required final List<String> memberIds,
    final String? avatar,
    required final DateTime createdAt,
  }) = _$MessImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get inviteCode;
  @override
  String get adminId; // ID of the user who is the primary admin
  @override
  List<String> get memberIds; // List of user IDs who are members
  @override
  String? get avatar;
  @override
  DateTime get createdAt;

  /// Create a copy of Mess
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessImplCopyWith<_$MessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
