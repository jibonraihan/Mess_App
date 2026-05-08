abstract class AdminRepository {
  Future<void> updateRole({
    required String userId,
    required String role,
  });
}
