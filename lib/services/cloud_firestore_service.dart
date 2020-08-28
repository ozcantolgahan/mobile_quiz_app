import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/model/category_model.dart';
import 'package:quiz_app/model/quiz_model.dart';

import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/services/cloud_firestore_base.dart';

class CloudFirestoreService implements CloudFirestoreBase {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel user) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(user.userId)
          .set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> readUser(String userId) async {
    var documentSnapshot =
        await _firebaseFirestore.collection("users").doc(userId).get();
    UserModel userModel = UserModel.fromMap(documentSnapshot.data());

    return userModel;
  }

  @override
  Future<List<CategoryModel>> readCategories() async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.collection("categories").get();
    List<CategoryModel> categories = [];
    for (QueryDocumentSnapshot document in snapshot.docs) {
      categories.add(CategoryModel.fromMap(document.data()));
    }

    return categories;
  }

  @override
  Future<List<QuizModel>> readQuestions(String category) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection("questions")
        .where("quizCategory", isEqualTo: category.toLowerCase())
        .limit(25)
        .get();
    List<QuizModel> questions = [];
    for (QueryDocumentSnapshot document in snapshot.docs) {
      questions.add(QuizModel.fromMap(document.data()));
    }
    return questions;
  }

  @override
  Future<bool> coinsEarned(String userId, int newCoins) async {
    await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .update({"coins": FieldValue.increment(newCoins)});
    return true;
  }

  @override
  Future<bool> updateUser(String userId, String imageCode, int cost) async {
    print(cost.toString());
    await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .update({"imageCode": imageCode, "coins": cost});
    return true;
  }

  @override
  Future<List<UserModel>> readAllUsersForLeaderBoard() async{
    List<UserModel> allUsers=[];
    var snapshot=await _firebaseFirestore.collection("users").orderBy("coins",descending: true).limit(10).get();
    for(QueryDocumentSnapshot document in snapshot.docs){
      allUsers.add(UserModel.fromMap(document.data()));
    }
    return allUsers;
  }
}
