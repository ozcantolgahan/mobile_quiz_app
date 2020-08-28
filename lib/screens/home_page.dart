import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/category_model.dart';
import 'package:quiz_app/screens/quiz_page.dart';
import 'package:quiz_app/view_model/data_view_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dataViewModel = Provider.of<DataViewModel>(context);
    try {
      return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            CategoryModel category = _dataViewModel.categories[index];
            return GestureDetector(
              onTap: () {
                _dataViewModel
                    .readQuestions(category.categoryName)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => QuizPage(
                                categoryName: category.categoryName,
                                user: _dataViewModel.user,
                              )));
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.11,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/" +
                        category.categoryName.toLowerCase() +
                        ".png"),
                    Text(
                      category.categoryName,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(""),
                    Text(""),
                    Text("")
                  ],
                ),
              ),
            );
          },
          itemCount: _dataViewModel.categories.length,
        ),
      ));
    } catch (e) {
      return Scaffold(
        body: Center(
          child: Text("Error please try again"),
        ),
      );
    }
  }
}
