import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:sastra_ebooks/login/login.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/images.dart';

class ProfileModalBottomSheet extends StatefulWidget {
  @override
  _ProfileModalBottomSheetState createState() =>
      _ProfileModalBottomSheetState();
}

class _ProfileModalBottomSheetState extends State<ProfileModalBottomSheet> {
  String _projectVersion = '';
  void initState() {
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    String projectVersion;
    try {
      projectVersion = await PackageInfo.fromPlatform()
          .then((packageInfo) => packageInfo.version);
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }
    setState(() {
      _projectVersion = projectVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.smallPadding),
            decoration: BoxDecoration(borderRadius: Dimensions.borderRadius),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Hero(
                    tag: 'profilePic',
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 100,
                      child: Center(
                        child: Image.asset(Images.kLoginPic),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'R Yaswanth Kumar',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fourth Year',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '121003219',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Computer Science',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SettingsContent(
            content: "Support",
            icon: Icons.help,
            backgroundColor: Color(0xFF13CBFE),
            onPressed: () {},
          ),
          SettingsContent(
            content: "About Us",
            icon: Icons.person,
            backgroundColor: Color(0xFF0084FF),
            onPressed: () {},
          ),
          SettingsContent(
            content: "Logout",
            icon: Icons.exit_to_app,
            backgroundColor: Color(0xFF114DA9),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, Login.id, (route) => false);
            },
          ),
          Center(
            child: Text(
              'App version $_projectVersion',
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsContent extends StatefulWidget {
  final IconData icon;
  final String content;
  final Color backgroundColor;
  final Function onPressed;
  const SettingsContent({
    Key key,
    @required this.icon,
    @required this.content,
    @required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _SettingsContentState createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: widget.backgroundColor,
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 15,
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.largePadding),
              Text(
                widget.content,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
