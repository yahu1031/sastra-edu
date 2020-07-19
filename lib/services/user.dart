import 'package:flutter/cupertino.dart';

//class User {
//  final String uid;
//  final String email;
//  User({this.uid, this.email});
//}

class User {
  final String _uid;
  final String _email;
  String _proPicUrl;
  final String _name;
  final String _branch;
  final String _year;
  final int _regNo;

  User(
    this._uid,
    this._email,
    this._proPicUrl,
    this._name,
    this._branch,
    this._year,
    this._regNo,
  );

  String get uid => _uid;
  String get email => _email;
  String get proPicUrl => _proPicUrl;
  String get name => _name;
  String get branch => _branch;
  int get regNo => _regNo;
  String get year => _year;

  set proPicUrl(proPicUrl) => _proPicUrl = proPicUrl;
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
