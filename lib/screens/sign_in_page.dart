import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/user_view_model.dart';
import 'package:quiz_app/widgets/clip_oval_widget.dart';

enum SignMethod { Login, Register }

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignMethod signMethod = SignMethod.Login;
  var _formKey = GlobalKey<FormState>();
  var _formKeyReset = GlobalKey<FormState>();

  TextEditingController _email;
  TextEditingController _password;
  String securityCode;
  String securityCodeWrited;
  String resetPasswordEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        signMethod == SignMethod.Login ? "Login" : "Register",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                          hintText: "Email", labelText: "Email"),
                      validator: (value) {
                        if (!value.contains("@")) {
                          return "Wrong email";
                        } else
                          return null;
                      },
                      onSaved: (value) => _email.text = value,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      decoration: InputDecoration(
                          hintText: "Password", labelText: "Password"),
                      validator: (value) {
                        if (value.length < 6) {
                          return "Password must be greater than 6 character";
                        } else
                          return null;
                      },
                      onSaved: (value) => _password.text = value,
                    ),
                    signMethod == SignMethod.Login
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(),
                              FlatButton(
                                onPressed: () {
                                  passwordResetDialog(context, _userViewModel);
                                },
                                child: Text("Forget Password?"),
                                padding: EdgeInsets.only(right: 0),
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: signMethod == SignMethod.Login ? 8 : 16,
                    ),
                    signMethod == SignMethod.Register
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 50,
                                color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  bringRandomSecurityCode(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )),
                              ),
                              Container(
                                width: 200,
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Security Code",
                                      border: OutlineInputBorder()),
                                  onSaved: (value) =>
                                      securityCodeWrited = value,
                                  validator: (value) {
                                    if (value.length == 0) {
                                      return "Wrong Security Code";
                                    } else
                                      return null;
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    signMethod == SignMethod.Register
                        ? SizedBox(
                            height: 12,
                          )
                        : Container(),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        gradient: new LinearGradient(
                          colors: [Color(0xFF5086FF), Color(0xFF1749FF)],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: FlatButton(
                        child: Text(
                          signMethod == SignMethod.Login ? 'Login' : "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (signMethod == SignMethod.Login) {
                              await _userViewModel.signWithEmail(
                                  _email.text, _password.text);
                            } else {
                              if (securityCodeWrited == securityCode) {
                                await _userViewModel.createWithEmail(
                                    _email.text, _password.text);
                              }
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Text("Or sign up with"),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipOvalWidget(
                          iconSign: Icon(
                            signMethod == SignMethod.Login
                                ? Icons.email
                                : Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              if (signMethod == SignMethod.Register) {
                                signMethod = SignMethod.Login;
                              } else {
                                signMethod = SignMethod.Register;
                              }
                            });
                          },
                        ),
                        ClipOvalWidget(
                          iconSign: Icon(
                            Icons.face,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _userViewModel.signInAsGuest();
                          },
                        ),
                        ClipOvalWidget(
                          iconSign: Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          onTap: () {
                            showDialogMethod(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void passwordResetDialog(BuildContext context, UserViewModel _userViewModel) {
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Forget Password?"),
              content: Container(
                width: 400,
                height: 110,
                child: Form(
                  key: _formKeyReset,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .stretch,
                    children: [
                      Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              border:
                                  OutlineInputBorder(),
                              labelText: "Email"),
                          onSaved: (value) =>
                              resetPasswordEmail =
                                  value,
                          validator: (value) {
                            if (!value
                                .contains("@")) {
                              return "Wrong email";
                            } else
                              return null;
                          },
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKeyReset
                              .currentState
                              .validate()) {
                            _formKeyReset
                                .currentState
                                .save();
                            _userViewModel
                                .sendPasswordResetEmail(
                                    resetPasswordEmail);
                            Navigator.pop(
                                context);
                          }
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                              color:
                                  Colors.white),
                        ),
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                  color: Colors.red,
                )
              ],
            ));
  }

  void showDialogMethod(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Information",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFF333333),
              content: Container(
                height: 500,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          "If you have no account,you can register in this panel",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.face,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          "If you have no account,you can visit the game as a guest",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          "You have two rights to pass question",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          "This bonus will show answer",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.do_not_disturb_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          "You will take your stones and left the game",
                          style: TextStyle(color: Colors.white),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                )
              ],
            ));
  }

  String bringRandomSecurityCode() {
    var randomNumber = new Random().nextInt(999);
    securityCode = randomNumber.toString();
    return securityCode;
  }
}
