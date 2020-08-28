import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/screens/home_page.dart';
import 'package:quiz_app/screens/leader_board_page.dart';
import 'package:quiz_app/screens/marcet_page.dart';
import 'package:quiz_app/screens/settings_page.dart';
import 'package:quiz_app/view_model/data_view_model.dart';

class DrawerPages extends StatefulWidget {
  @override
  _DrawerPages createState() => _DrawerPages();
}

class _DrawerPages extends State<DrawerPages> {
  int currentPage = 0;
  List allPage = [HomePage(), MarcetPage(), LeaderBoardPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    final _dataViewModel = Provider.of<DataViewModel>(context);
    UserModel user = _dataViewModel.user;

    try {
      return Scaffold(
        appBar: AppBar(
          title: Text("WiseStone"),
          centerTitle: true,
          backgroundColor: Color(0xFF333333),
          actions: [
            Row(
              children: [
                Text(user.coins.toString()),
                IconButton(
                    icon: Icon(
                      Icons.scatter_plot,
                      color: Colors.orange,
                    ),
                    onPressed: () {})
              ],
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF333333),
                    radius: 40,
                    child: Image.asset(
                      "assets/images/stone-" + user.imageCode + ".png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Text(
                    user.userName,
                    style: TextStyle(fontSize: 20),
                  )),
                ],
              )),
              Expanded(
                  child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      user.coins.toString(),
                      style: TextStyle(fontSize: 18,color: Colors.orange),
                    ),
                    leading: Icon(Icons.scatter_plot,color: Colors.orange,),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.orange,),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Home",
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.home),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        currentPage = 0;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Marcet",
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.shopping_cart),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        currentPage = 1;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      "LeaderBoard",
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.home),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        currentPage = 2;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 18),
                    ),
                    leading: Icon(Icons.settings),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        currentPage = 3;
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              ))
            ],
          ),
        ),
        body: allPage[currentPage],
      );
    } catch (e) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
