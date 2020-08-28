import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/data_view_model.dart';
import 'package:quiz_app/view_model/user_view_model.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController _userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);
    final _dataViewModel = Provider.of<DataViewModel>(context);
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 40,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.scatter_plot,
                          color: Colors.orange,
                        ),
                        Text(
                          _dataViewModel.user.coins.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle),
                          onPressed: () {},
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ),
                  Text(""),
                  RaisedButton(
                    color: Color(0xFF333333),
                    onPressed: () {
                      _userViewModel.signOut();
                    },
                    child: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xFF333333),
                  child: Image.asset("assets/images/stone-" +
                      _dataViewModel.user.imageCode +
                      ".png"),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _userName,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.done),
                    border: OutlineInputBorder(),
                    labelText: _dataViewModel.user.userName),
                validator: (value) {
                  if (value.length < 4) {
                    return "Username must be greater than 4 character";
                  } else
                    return null;
                },
                onSaved: (value) {
                  _userName.text = value;
                },
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xFF333333),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
