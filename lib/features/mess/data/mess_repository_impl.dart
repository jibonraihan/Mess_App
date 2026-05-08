import 'package:flutter/material.dart';
import 'package:mess_app/features/mess/presentation/screens/join_mess_screen.dart';
import 'package:mess_app/features/mess/presentation/screens/create_mess_screen.dart';

// Mock user data and mess data for now

// Mock user ID - this would come from an authentication service
const String currentUserId = 'user1';

// Mock data for MessRepository
// In a real app, this would be fetched from a backend or database
final Map<String, Mess> _mockMessDatabase = {
  'mess1': Mess(
    id: 'mess1',
    name: 'Awesome Coders Mess',
    inviteCode: 'AW3S0M3',
    adminId: 'user1',
    memberIds: ['user1', 'user2', 'user3'],
  ),
  'mess2': Mess(
    id: 'mess2',
    name: 'The Foodies',
    inviteCode: 'FOOD123',
    adminId: 'user4',
    memberIds: ['user4', 'user5'],
  ),
};

// Mock repository implementation
class MessRepositoryImpl implements MessRepository {
  @override
  Mess? getMessById(String messId) {
    return _mockMessDatabase[messId];
  }

  @override
  Mess? getMessByInviteCode(String inviteCode) {
    return _mockMessDatabase.values.firstWhere(
      (mess) => mess.inviteCode == inviteCode.toUpperCase(),
      orElse: () => null,
    );
  }

  @override
  Future<void> createMess(Mess mess) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _mockMessDatabase[mess.id] = mess;
    print('Mess created: ${mess.name} (ID: ${mess.id})');
  }

  @override
  Future<void> joinMess(String userId, String inviteCode) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    final mess = getMessByInviteCode(inviteCode);
    if (mess == null) {
      throw Exception('Invalid invite code.');
    }
    if (mess.memberIds.contains(userId)) {
      throw Exception('User already in this mess.');
    }
    // Update the mess data in the mock database
    final updatedMess = mess.copyWith(
      memberIds: [...mess.memberIds, userId],
    );
    _mockMessDatabase[mess.id] = updatedMess;
    print('User $userId joined mess: ${mess.name}');
  }

  @override
  Future<void> leaveMess(String userId, String messId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    final mess = _mockMessDatabase[messId];
    if (mess == null) {
      throw Exception('Mess not found.');
    }
    // Remove user from memberIds
    final updatedMemberIds = List<String>.from(mess.memberIds)..remove(userId);
    // If the user was the admin, promote the first member or clear adminId
    String? newAdminId = mess.adminId;
    if (mess.adminId == userId && updatedMemberIds.isNotEmpty) {
      newAdminId = updatedMemberIds.first;
      print('User $userId left mess $messId. Promoting ${newAdminId} as new admin.');
    } else if (mess.adminId == userId && updatedMemberIds.isEmpty) {
      newAdminId = null; // No members left, no admin
      print('User $userId left mess $messId. Mess is now empty.');
    } else {
       print('User $userId left mess $messId.');
    }

    final updatedMess = mess.copyWith(
      adminId: newAdminId,
      memberIds: updatedMemberIds,
    );
    _mockMessDatabase[messId] = updatedMess;
  }

  @override
  Mess? getUserMess(String userId) {
    // Find the first mess where the userId is in memberIds
    return _mockMessDatabase.values.firstWhereOrNull(
      (mess) => mess.memberIds.contains(userId),
    );
  }
}

extension on Iterable<Mess> {
  T? firstWhereOrNull<T extends Mess>(bool Function(T element) test) {
    for (final element in this) {
      if (element is T && test(element)) {
        return element;
      }
    }
    return null;
  }
}
