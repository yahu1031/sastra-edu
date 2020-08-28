import 'package:flutter/cupertino.dart';

//class User {
//  final String uid;
//  final String email;
//  User({this.uid, this.email});
//}

class UserData {
  final String _uid;
  final String _email;
  final String _name;
  final String _branch;
  final int _semester;
  final String _regNo;

  UserData(
    this._uid,
    this._email,
    this._name,
    this._branch,
    this._semester,
    this._regNo,
  );

  String get uid => _uid;
  String get email => _email;
  String get name => _name;
  String get branch => _branch;
  String get regNo => _regNo;
  int get semester => _semester;
}

class Developer {
  String name;
  String country;
  String picPath;
  String level;

  Developer(
      {@required this.name,
      @required this.country,
      @required this.picPath,
      @required this.level});
}
