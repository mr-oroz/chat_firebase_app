import 'package:chat_app_firebase/feutures/auth/domain/entities/user_profile.dart';
import 'package:chat_app_firebase/feutures/auth/domain/repositories/i_auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  FirebaseAuthRepository(this.auth, this.firestore);
  @override
  Future<List<UserProfile>> getAllUsers() async {
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection('users').get();
      final List<UserProfile> users = querySnapshot.docs
          .map((doc) {
            final data = doc.data()! as Map<String, dynamic>;
            if (data.containsKey('uid') && data['uid'] != null) {
              return UserProfile.fromJson(data);
            } else {
              return null;
            }
          })
          .where((user) => user != null)
          .cast<UserProfile>()
          .toList();
      return users;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserProfile> getUser({required String uid}) async {
    try {
      final DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      final UserProfile userProfile =
          UserProfile.fromStoreData(userDoc.data()! as Map<String, dynamic>);
      return userProfile;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
        throw Exception('Неверная комбинация электронной почты или пароля');
      } else {
        throw Exception('Произошла ошибка сервера');
      }
    } catch (_) {
      throw Exception('Произошла ошибка сервера');
    }
  }
}
