import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    required super.email, 
    required super.password, 
    required super.name, 
    required super.userid
  });

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      userid: json['userid'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'userid': userid,
      // لا نخزن كلمة المرور في Firestore
      // تلاحظ أننا لا نضيف 'password' هنا
    };
  }
}