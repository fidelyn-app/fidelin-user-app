import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? phone;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.phone,
  });

  @override
  List<Object> get props => [
        id,
        name,
        email,
      ];

  get firstName => name.split(' ').first.toString();
}
