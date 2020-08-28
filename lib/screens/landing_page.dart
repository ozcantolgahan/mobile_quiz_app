import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/screens/drawer_page.dart';
import 'package:quiz_app/screens/sign_in_page.dart';
import 'package:quiz_app/view_model/data_view_model.dart';
import 'package:quiz_app/view_model/user_view_model.dart';

class LandingPage extends StatelessWidget {
  UserModel user;

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);
    final _dataViewModel = Provider.of<DataViewModel>(context);

    try {
      if (_userViewModel.userProgress == UserProgress.Idle) {
        if (_userViewModel.user == null) {
          return SignInPage();
        } else {
          _dataViewModel.readUser(_userViewModel.user.userId);
          _dataViewModel.readCategories();

          return DrawerPages();
        }
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
