import 'dart:math';
class UserModel {
  String userId;
  String userName;
  int coins;
  String imageCode;

  UserModel({this.userId, this.userName, this.coins,this.imageCode});

  Map<dynamic, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["userId"] = this.userId;
    map["userName"] = this.userName ?? "Guest" + randomGuest();
    map["coins"] = this.coins ??100;
    map["imageCode"] = this.imageCode ??"1";
    return map;
  }

  UserModel.fromMap(Map<dynamic, dynamic> map) {
    this.userId = map["userId"];
    this.userName = map["userName"];
    this.coins = map["coins"];
    this.imageCode = map["imageCode"];
  }

  String randomGuest() {
    var randomNumber = Random().nextInt(99999);
    return randomNumber.toString();
  }
}
