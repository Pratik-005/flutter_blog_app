import 'package:blog_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.id, required super.name});

  factory UserModel.fromJson(Map<String,dynamic> user){
    return UserModel(email: user['email'], id: user['id'], name: user[''])
  }
}
