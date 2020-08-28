import 'package:flutter/material.dart';
import 'package:quiz_app/constant/locator.dart';
import 'package:quiz_app/model/category_model.dart';
import 'package:quiz_app/model/quiz_model.dart';

import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/services/cloud_firestore_base.dart';

class DataViewModel with ChangeNotifier implements CloudFirestoreBase {
  Repository _repository = locator<Repository>();
  UserModel user;

  List<CategoryModel> categories;
  List<QuizModel> questions;
  List<UserModel> allUsers;

  @override
  Future<UserModel> readUser(String userId) async {
    user = await _repository.readUser(userId);
    notifyListeners();
    return user;
  }

  @override
  Future<bool> saveUser(UserModel user) async {
    return await _repository.saveUser(user);
  }

  @override
  Future<List<CategoryModel>> readCategories() async {
    categories = await _repository.readCategories();

    return categories;
  }

  @override
  Future<List<QuizModel>> readQuestions(String category) async {
    questions = await _repository.readQuestions(category);

    return questions;
  }

  @override
  Future<bool> coinsEarned(String userId, int newCoins) async {
    return await _repository.coinsEarned(userId, newCoins);
  }

  @override
  Future<bool> updateUser(String userId, String imageCode, int cost) async {
    return await _repository.updateUser(userId, imageCode, cost);
  }

  @override
  Future<List<UserModel>> readAllUsersForLeaderBoard() async {
    allUsers = [];
    allUsers = await _repository.readAllUsersForLeaderBoard();

    return allUsers;
  }
}
