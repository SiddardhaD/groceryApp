import '../../domain/entities/user_profile.dart';

class MockUserRepository {
  UserProfile getCurrentUser() {
    return const UserProfile(
      id: '1',
      name: 'Alex Fernandez',
      email: 'alex.fernandez@example.com',
      avatarUrl:
          'https://media.licdn.com/dms/image/v2/D4E03AQHMj7LbvuJb0g/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1710959908890?e=2147483647&v=beta&t=dhtYDtqwDpQA77ImXPLwlwXyVgRMlXTvhDKqhN4rPiA',
      phone: '+1 234 567 8900',
      address: 'Pocket 25.NH 254',
    );
  }
}
