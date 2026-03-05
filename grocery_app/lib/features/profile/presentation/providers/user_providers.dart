import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_user_repository.dart';
import '../../domain/entities/user_profile.dart';

// Repository Provider
final userRepositoryProvider = Provider<MockUserRepository>((ref) {
  return MockUserRepository();
});

// User Profile Provider
final userProfileProvider = Provider<UserProfile>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getCurrentUser();
});
