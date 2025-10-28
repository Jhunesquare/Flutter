class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> m) {
    return UserModel(
      name: m['name'] ?? m['nombre'] ?? '',
      email: m['email'] ?? m['correo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'email': email};
}
