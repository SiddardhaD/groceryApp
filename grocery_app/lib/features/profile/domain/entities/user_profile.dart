import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? phone;
  final String? address;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [id, name, email, avatarUrl, phone, address];
}
