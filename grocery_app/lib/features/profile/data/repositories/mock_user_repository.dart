import '../../domain/entities/user_profile.dart';

class MockUserRepository {
  UserProfile getCurrentUser() {
    return const UserProfile(
      id: '1',
      name: 'Alex Fernandez',
      email: 'alex.fernandez@example.com',
      avatarUrl: '👤',
      phone: '+1 234 567 8900',
      address: 'Pocket 25.NH 254',
    );
  }
}
