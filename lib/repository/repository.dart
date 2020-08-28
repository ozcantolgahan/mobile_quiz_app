import 'package:quiz_app/constant/locator.dart';
import 'package:quiz_app/model/category_model.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/services/authentication_base.dart';
import 'package:quiz_app/services/cloud_firestore_service.dart';
import 'package:quiz_app/services/firebase_auth_service.dart';

class Repository implements AuthenticationBase, CloudFirestoreService {
  FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();
  CloudFirestoreService _cloudFirestoreService =
      locator<CloudFirestoreService>();

  @override
  Future<UserModel> currentUser() async {
    // TODO: implement currentUser
    return await _firebaseAuthenticationService.currentUser();
  }

  @override
  Future<UserModel> createWithEmail(String email, String password) async {
    UserModel userModel =
        await _firebaseAuthenticationService.createWithEmail(email, password);
    await _cloudFirestoreService.saveUser(userModel);

    return userModel;
  }

  @override
  Future<UserModel> signWithEmail(String email, String password) async {
    return await _firebaseAuthenticationService.signWithEmail(email, password);
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthenticationService.signOut();
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    return await _firebaseAuthenticationService.sendPasswordResetEmail(email);
  }

  @override
  Future<UserModel> signInAsGuest() async {
    UserModel userModel = await _firebaseAuthenticationService.signInAsGuest();
    await _cloudFirestoreService.saveUser(userModel);
    return userModel;
  }

  @override
  Future<UserModel> readUser(String userId) async {
    return await _cloudFirestoreService.readUser(userId);
  }

  @override
  Future<bool> saveUser(UserModel user) async {
    return await _cloudFirestoreService.saveUser(user);
  }

  @override
  Future<List<CategoryModel>> readCategories() async {
    return await _cloudFirestoreService.readCategories();
  }

  @override
  Future<List<QuizModel>> readQuestions(String category) async {
    return await _cloudFirestoreService.readQuestions(category);
  }

  @override
  Future<bool> coinsEarned(String userId, int newCoins) async {
    return await _cloudFirestoreService.coinsEarned(userId, newCoins);
  }

  @override
  Future<bool> updateUser(String userId, String imageCode,int cost) async {
    return await _cloudFirestoreService.updateUser(userId, imageCode,cost);
  }

  @override
  Future<List<UserModel>> readAllUsersForLeaderBoard() async{
    return await _cloudFirestoreService.readAllUsersForLeaderBoard();
  }
}
