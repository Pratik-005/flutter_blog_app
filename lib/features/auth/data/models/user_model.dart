import 'package:blog_app/core/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.id, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(email: user['email'], id: user['id'], name: user['name']);
  }

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
