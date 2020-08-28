import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/view_model/data_view_model.dart';

class MarcetPage extends StatefulWidget {
  @override
  _MarcetPageState createState() => _MarcetPageState();
}

class _MarcetPageState extends State<MarcetPage> {
  @override
  Widget build(BuildContext context) {
    final _dataViewModel = Provider.of<DataViewModel>(context);
    UserModel user = _dataViewModel.user;
    return GridView.count(
      // crossAxisCount is the number of columns
      crossAxisCount: 2,
      // This creates two columns with two items in each column
      children: List.generate(13, (index) {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(12),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                margin: EdgeInsets.only(top: 18),
                child: Image.asset(
                  "assets/images/stone-" + (index + 1).toString() + ".png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text("Profile Image-" + (index + 1).toString(),
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 12,
              ),
              user.imageCode == (index + 1).toString()
                  ? Center(
                      child: Text(
                        "You already have it",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                (index * 8500).toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.scatter_plot,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                if (_dataViewModel.user.coins > index * 8500) {
                                  var result = _dataViewModel.user.coins -
                                      (index * 8500);
                                  print(result.toString());
                                  _dataViewModel.updateUser(
                                      _dataViewModel.user.userId,
                                      (index + 1).toString(),
                                      result);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            backgroundColor: Color(0xFF333333),
                                            title: Text(
                                              "Not enough money",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            actions: [
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.red,
                                              )
                                            ],
                                          ));
                                }
                              })
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
