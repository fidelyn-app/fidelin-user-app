import 'dart:convert';

class UserDTO {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;

  const UserDTO({
    this.id = "",
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
  });

  String toJSON() {
    return jsonEncode({
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
    });
  }

  factory UserDTO.fromJSON(String json) {
    final data = jsonDecode(json) as Map<String, dynamic>;
    return UserDTO(
      id: data['id'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
      phone: data['phone'] as String?,
      avatarUrl: data['avatarUrl'] as String?,
    );
  }

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }
}
