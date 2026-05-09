import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/local_storage_service.dart';
import '../../auth/application/auth_controller.dart';
import '../data/mess_repository.dart';
import '../domain/mess.dart';
import 'mess_state.dart';

final messRepositoryProvider =
    Provider<MessRepository>((ref) {
  return InMemoryMessRepository();
});

final messControllerProvider =
    StateNotifierProvider<
      MessController,
      MessState
    >((ref) {
      final repository =
          ref.watch(
            messRepositoryProvider,
          );

      return MessController(
        ref,
        repository,
      );
    });

class MessController
    extends StateNotifier<MessState> {
  final Ref ref;
  final MessRepository _repository;

  final String _userId =
      'mock-user-id';

  Mess? _currentMess;

  MessController(
    this.ref,
    this._repository,
  ) : super(
         const MessState.loading(),
       ) {
    loadUserMess();
  }

  // LOAD MESS
  Future<void> loadUserMess() async {
    try {
      final savedName =
          await LocalStorageService
              .getMessName();

      final savedDescription =
          await LocalStorageService
              .getDescription();

      final savedAvatar =
          await LocalStorageService
              .getAvatar();

      // IF SAVED DATA EXISTS
      // RESTORE DIRECTLY
      if (savedName != null) {
        _currentMess = Mess(
          id: 'saved-mess',

          name: savedName,

          createdAt:
              DateTime.now(),

          inviteCode: 'LOCAL01',

          adminId: _userId,

          memberIds: [_userId],

          description:
              savedDescription,

          avatarBytes:
              savedAvatar,
        );

        state = MessState.loaded(
          mess: _currentMess!,
        );

        return;
      }

      // NO SAVED DATA
      final mess =
          _repository.getUserMess(
        _userId,
      );

      if (mess != null) {
        _currentMess = mess;

        state = MessState.loaded(
          mess: mess,
        );
      } else {
        state =
            const MessState.notInMess();
      }
    } catch (e) {
      state = MessState.error(
        message:
            'Failed to load mess: ${e.toString()}',
      );
    }
  }

  // CREATE MESS
  Future<void> createMess(
    String messName,
  ) async {
    state = const MessState.loading();

    try {
      final inviteCode =
          _generateInviteCode();

      final newMess = Mess(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),

        name: messName,

        createdAt: DateTime.now(),

        inviteCode: inviteCode,

        adminId: _userId,

        memberIds: [_userId],
      );

      _currentMess = newMess;

      // SAVE LOCALLY
      await LocalStorageService
          .saveMessName(
        messName,
      );

      await LocalStorageService
          .saveDescription('');

      ref
          .read(
            authControllerProvider
                .notifier,
          )
          .completeOnboarding();

      state = MessState.loaded(
        mess: newMess,
      );
    } catch (e) {
      state = MessState.error(
        message:
            'Failed to create mess: ${e.toString()}',
      );
    }
  }

  // JOIN MESS
  Future<void> joinMess(
    String inviteCode,
  ) async {
    state = const MessState.loading();

    try {
      final joinedMess = Mess(
        id: 'joined-mess',

        name: 'Joined Mess',

        createdAt: DateTime.now(),

        inviteCode: inviteCode,

        adminId: _userId,

        memberIds: [_userId],
      );

      _currentMess = joinedMess;

      await LocalStorageService
          .saveMessName(
        joinedMess.name,
      );

      state = MessState.loaded(
        mess: joinedMess,
      );
    } catch (e) {
      state = MessState.error(
        message:
            'Failed to join mess: ${e.toString()}',
      );
    }
  }

  // UPDATE PROFILE
  Future<void> updateMessProfile({
    required String name,
    String? description,
    Uint8List? avatarBytes,
    bool removeAvatar = false,
  }) async {
    if (_currentMess == null) {
      _currentMess = Mess(
        id: 'saved-mess',

        name: name,

        createdAt: DateTime.now(),

        inviteCode: 'LOCAL01',

        adminId: _userId,

        memberIds: [_userId],
      );
    }

    _currentMess = _currentMess!.copyWith(
      name: name.trim(),

      description:
          description?.trim(),

      avatarBytes:
          removeAvatar
              ? null
              : avatarBytes,
    );

    // SAVE LOCALLY
    await LocalStorageService
        .saveMessName(
      _currentMess!.name,
    );

    await LocalStorageService
        .saveDescription(
      _currentMess!.description ?? '',
    );

    if (removeAvatar) {
      await LocalStorageService
          .removeAvatar();
    } else if (avatarBytes != null) {
      await LocalStorageService
          .saveAvatar(
        avatarBytes,
      );
    }

    state = MessState.loaded(
      mess: _currentMess!,
    );
  }

  // LEAVE MESS
  Future<void> leaveMess() async {
    _currentMess = null;

    state =
        const MessState.notInMess();
  }

  // INVITE CODE
  String _generateInviteCode() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    final random = Random();

    return List.generate(
      6,
      (index) => chars[
          random.nextInt(
            chars.length,
          )],
    ).join();
  }
}