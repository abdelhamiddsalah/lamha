import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.email, required super.password, required super.name, required super.userid});

  factory UserModel.fromFirestore( json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      userid: json['userid'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'userid': userid,
    };
  }
}