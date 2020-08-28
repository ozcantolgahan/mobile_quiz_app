import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/constant/locator.dart';
import 'package:quiz_app/screens/landing_page.dart';
import 'package:quiz_app/view_model/data_view_model.dart';
import 'package:quiz_app/view_model/user_view_model.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create: (context) => UserViewModel(),
      child: ChangeNotifierProvider<DataViewModel>(
        create: (context) => DataViewModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
        ),
      ),
    );
  }
}
