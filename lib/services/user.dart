import 'package:flutter/cupertino.dart';

class User {
  final String uid;
  final String email;
  User({this.uid, this.email});
}

class UserData {
  static String _uid;
  static String proPicUrl;
  static String _name;
  static String _branch;
  static String _year;
  static int _regNo;

  UserData(
    String uid,
    String proPicUrl,
    String name,
    String branch,
    String year,
    int regNo,
  ) {
    UserData._uid = uid;
    UserData.proPicUrl = proPicUrl;
    UserData._name = name;
    UserData._branch = branch;
    UserData._regNo = regNo;
    UserData._year = year;
  }

  static String get uid => _uid;
  static String get name => _name;
  static String get branch => _branch;
  static int get regNo => _regNo;
  static String get year => _year;
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
