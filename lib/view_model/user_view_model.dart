import 'package:flutter/foundation.dart';
import 'package:quiz_app/constant/locator.dart';

import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/repository/repository.dart';
import 'package:quiz_app/services/authentication_base.dart';

enum UserProgress { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthenticationBase {
  Repository _repository = locator<Repository>();
  UserProgress _userProgress = UserProgress.Idle;
  UserModel _user;


  UserModel get user => _user;

  UserProgress get userProgress => _userProgress;

  set userProgress(UserProgress value) {
    _userProgress = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      userProgress = UserProgress.Busy;
      _user = null;
      _user = await _repository.currentUser();
      return _user;
    } finally {
      userProgress = UserProgress.Idle;
    }
  }

  @override
  Future<UserModel> createWithEmail(String email, String password) async {
    try {
      userProgress = UserProgress.Busy;
      _user = await _repository.createWithEmail(email, password);
      return _user;
    } finally {
      userProgress = UserProgress.Idle;
    }
  }

  @override
  Future<UserModel> signWithEmail(String email, String password) async {
    try {
      userProgress = UserProgress.Busy;
      _user = await _repository.signWithEmail(email, password);
      return _user;
    } finally {
      userProgress = UserProgress.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      userProgress = UserProgress.Busy;
      _user = null;
      return await _repository.signOut();
    } finally {
      userProgress = UserProgress.Idle;
    }
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    return await _repository.sendPasswordResetEmail(email);
  }

  @override
  Future<UserModel> signInAsGuest() async{
    try {
      userProgress = UserProgress.Busy;
      _user = await _repository.signInAsGuest();
      return _user;
    } finally {
      userProgress = UserProgress.Idle;
    }
  }
}
