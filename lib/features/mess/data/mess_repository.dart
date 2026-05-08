import 'package:mess_app/features/mess/domain/mess.dart';

// Mock data for MessRepository

final mockMessData = {
  'mess1': Mess(
    id: 'mess1',
    name: 'Awesome Coders Mess',
    createdAt: DateTime.now(),
    inviteCode: 'AW3S0M3',
    adminId: 'user1',
    memberIds: ['user1', 'user2', 'user3'],
  ),
  'mess2': Mess(
    id: 'mess2',
    name: 'The Foodies',
    createdAt: DateTime.now(),
    inviteCode: 'FOOD123',
    adminId: 'user4',
    memberIds: ['user4', 'user5'],
  ),
};

abstract class MessRepository {
  // Fetch a mess by its ID
  Mess? getMessById(String messId);

  // Fetch a mess by its invite code
  Mess? getMessByInviteCode(String inviteCode);

  // Create a new mess
  Future<void> createMess(Mess mess);

  // Join a mess using invite code
  Future<void> joinMess(String userId, String inviteCode);

  // Leave a mess
  Future<void> leaveMess(String userId, String messId);

  // Get the mess a user belongs to
  Mess? getUserMess(String userId);
}

class InMemoryMessRepository implements MessRepository {
  final Map<String, Mess> _messes = {};

  @override
  Future<void> createMess(Mess mess) async {
    _messes[mess.id] = mess;
  }

  @override
  Mess? getMessByInviteCode(String inviteCode) {
    try {
      return _messes.values.firstWhere(
        (mess) => mess.inviteCode == inviteCode,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Mess? getMessById(String messId) {
    return _messes[messId];
  }

  @override
  Future<void> joinMess(String userId, String inviteCode) async {}

  @override
  Future<void> leaveMess(String userId, String messId) async {}

  @override
  Mess? getUserMess(String userId) {
    return null;
  }
}