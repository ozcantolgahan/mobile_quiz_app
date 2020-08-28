import 'package:quiz_app/model/category_model.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/model/user_model.dart';

abstract class CloudFirestoreBase {
  Future<bool> saveUser(UserModel user);

  Future<UserModel> readUser(String userId);

  Future<List<UserModel>> readAllUsersForLeaderBoard();

  Future<List<CategoryModel>> readCategories();

  Future<List<QuizModel>> readQuestions(String category);

  Future<bool> coinsEarned(String userId, int newCoins);

  Future<bool> updateUser(String userId, String imageCode, int cost);
}
