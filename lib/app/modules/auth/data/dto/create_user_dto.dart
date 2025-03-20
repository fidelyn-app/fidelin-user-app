class CreateUserDTO {
  final String name;
  final String email;
  final String password;

  const CreateUserDTO({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
