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

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserDTO.fromJSON(Map<String, dynamic> map) {
    return UserDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }
}
