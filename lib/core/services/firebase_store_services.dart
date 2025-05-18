import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamha/features/authintecation/data/models/user_model.dart';

class FirebaseStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // حفظ بيانات المستخدم في Firestore
  Future<void> saveUserToCollection(UserModel user) async {
    try {
      // إضافة تاريخ التسجيل إلى بيانات المستخدم
      final userDataWithDate = {
        'userid': user.userid,
        'email': user.email,
        'name': user.name,
        'created_at': FieldValue.serverTimestamp(), // تاريخ التسجيل
      };

      await _firestore
          .collection('users')
          .doc(user.userid)
          .set(userDataWithDate);
    } catch (e) {
      print('Error saving user to Firestore: $e');
      throw e;
    }
  }

  // جلب بيانات المستخدم من Firestore
  Future<UserModel?> getUserFromCollection(String userId) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(userId).get();
      
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          return UserModel(
            userid: userId,
            email: data['email'] ?? '',
            name: data['name'] ?? '',
            password: '', // لا نخزن كلمة المرور في Firestore
          );
        }
      }
      return null;
    } catch (e) {
      print('Error getting user from Firestore: $e');
      throw e;
    }
  }

  // تحديث بيانات المستخدم في Firestore
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (e) {
      print('Error updating user data in Firestore: $e');
      throw e;
    }
  }
}