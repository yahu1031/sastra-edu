class User {
  final String uid;
  final String email;
  User({this.uid, this.email});
}

class UserData {
  final String uid;
  final String name;
  final String regNo;
  final String year;

  UserData({
    this.uid,
    this.name,
    this.regNo,
    this.year,
  });
}

class Helpers{
  String helperName;
  String helperCountry;
  String picPath;
  String level;

  Helpers({this.helperName, this.helperCountry, this.picPath, this.level});

}
