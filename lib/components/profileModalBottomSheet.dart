import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:sastra_ebooks/components/customInkWell.dart';
import 'package:sastra_ebooks/login/login.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/screens/downloads.dart';
import 'package:sastra_ebooks/misc/screens/mailUs.dart';
import 'package:sastra_ebooks/profile/settingScreens/about.dart';
import 'package:sastra_ebooks/services/images.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'customAboutDialog.dart';

class ProfileModalBottomSheet extends StatefulWidget {
  final UserData user;

  const ProfileModalBottomSheet({Key key, this.user}) : super(key: key);

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

  String _getNumberWrittenOut(int number) {
    if (number == 1)
      return 'First';
    else if (number == 2)
      return 'Second';
    else if (number == 3)
      return 'Third';
    else if (number == 4)
      return 'Fourth';
    else if (number == 5) return 'Fith';

    return 'Best';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColors.lightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.borderRadiusDouble),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.smallPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: Dimensions.smallPadding),
              decoration: BoxDecoration(borderRadius: Dimensions.borderRadius),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.padding,
                      vertical: Dimensions.largePadding,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.transparent,
                      radius: 50,
                      backgroundImage: AssetImage(Images.kLoginPic),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.user.name,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${widget.user.regNo} - ${_getNumberWrittenOut(widget.user.year)} Year',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.user.branch,
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, MailUs.id);
                }),
            SettingsContent(
              content: "About Us",
              icon: Icons.person,
              backgroundColor: Color(0xFF3a9efc),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutUs.id);
              },
            ),
            SettingsContent(
              content: "Downlaods",
              icon: Icons.cloud_download,
              backgroundColor: Color(0xFF0076e3),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Downloads.id);
              },
            ),
            SettingsContent(
              content: "Log Out",
              icon: Icons.exit_to_app,
              backgroundColor: Color(0xFF114DA9),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, Login.id, (route) => false);
              },
            ),
            Container(
              height: 35,
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.padding),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomInkWell(
                      onPressed: () async {
                        PackageInfo packageInfo =
                            await PackageInfo.fromPlatform();
                        showDialog(
                          context: context,
                          child: CustomAboutDialog(
                            applicationIcon: Image.asset(
                              Images.appIcon,
                              fit: BoxFit.fitWidth,
                              width: 100,
                            ),
                            applicationName: packageInfo.appName,
                            applicationVersion: packageInfo.version,
                            applicationLegalese: 'IMPLEMENT',
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          Images.info,
                          color: CustomColors.highlightColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Alpha - $_projectVersion',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.padding, horizontal: Dimensions.padding),
      child: CustomInkWell(
        onPressed: widget.onPressed,
        child: Padding(
          padding: EdgeInsets.all(5),
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
