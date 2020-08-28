import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/view_model/data_view_model.dart';

class LeaderBoardPage extends StatelessWidget {
  List<UserModel> allUsers;

  @override
  Widget build(BuildContext context) {
    final _dataViewModel = Provider.of<DataViewModel>(context, listen: false);
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            allUsers = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                bool areTheyLeaders = false;
                if (index == 0 || index == 1 || index == 2 || index == 3) {
                  areTheyLeaders = true;
                }
                return Card(
                  color: Color(0xFF333333),
                  child: ListTile(
                      title: Text(
                        allUsers[index].userName,
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Image.asset("assets/images/stone-" +
                          allUsers[index].imageCode +
                          ".png"),
                      subtitle: Row(
                        children: [
                          Text(
                            allUsers[index].coins.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.scatter_plot,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          areTheyLeaders == true
                              ? Text(
                                  "+" +
                                      (2000 - (index * 500)).toString() +
                                      " everyday",
                                  style: TextStyle(color: Colors.orange),
                                )
                              : Text(""),
                          Icon(
                            Icons.scatter_plot,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      trailing: Text(
                        (index + 1).toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                );
              },
              itemCount: allUsers.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: _dataViewModel.readAllUsersForLeaderBoard());
  }
}
