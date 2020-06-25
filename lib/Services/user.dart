class User {
  final String uid;
  final String email;
  User({this.uid, this.email});
}

class UserData {
  static String _uid;
  static String _name;
  static String _branch;
  static String _year;
  static int _regNo;

  UserData(
    String uid,
    String name,
    String branch,
    String year,
    int regNo,
  ) {
    UserData._uid = uid;
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

class Helpers {
  String helperName;
  String helperCountry;
  String picPath;
  String level;

  Helpers({this.helperName, this.helperCountry, this.picPath, this.level});
}
