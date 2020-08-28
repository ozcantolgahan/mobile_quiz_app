import 'package:quiz_app/model/user_model.dart';

abstract class AuthenticationBase {
  Future<UserModel> currentUser();
  Future<UserModel> signWithEmail(String email,String password);
  Future<UserModel> createWithEmail(String email,String password);
  Future<UserModel> signInAsGuest();
  Future<bool> sendPasswordResetEmail(String email);
  Future<bool> signOut();
}