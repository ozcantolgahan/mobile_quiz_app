import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/services/authentication_base.dart';

class FirebaseAuthenticationService implements AuthenticationBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> currentUser() async {
    try {
      var user = await _firebaseAuth.currentUser;
      return changeToUserModel(user);
    } catch (e) {
      return null;
    }
  }

  UserModel changeToUserModel(User user) {
    try {
      var userNameLength = user.email.indexOf("@");
      var userName = user.email.substring(0, userNameLength);
      return UserModel(userId: user.uid, userName: userName);
    } catch (e) {
      return UserModel(userId: user.uid, userName: user.displayName);
    }
  }

  @override
  Future<UserModel> createWithEmail(String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return changeToUserModel(user.user);
  }

  @override
  Future<UserModel> signWithEmail(String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return changeToUserModel(user.user);
  }

  @override
  Future<bool> signOut() async {
    await _firebaseAuth.signOut();
    return true;
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  @override
  Future<UserModel> signInAsGuest() async {
    var userModel = await _firebaseAuth.signInAnonymously();
    return changeToUserModel(userModel.user);
  }
}
