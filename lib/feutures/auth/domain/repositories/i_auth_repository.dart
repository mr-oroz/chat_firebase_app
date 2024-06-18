import 'package:chat_app_firebase/feutures/auth/domain/entities/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<List<UserProfile>> getAllUsers();
  Future<UserProfile> getUser({required String uid});
  Future<UserCredential> signIn({required String email, required String password,});

}