import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/services/user.dart';

/* Todo:  - Add image cropper
          - prevent user from leaving app during up and download or continue process in the background
 */

class ProfileInfoCard extends StatefulWidget {
  final UserData user;

  const ProfileInfoCard(this.user);
  @override
  _ProfileInfoCardState createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: Dimensions.borderRadius,
        color: CustomColors.lightHighlightColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    InkWell(
                      borderRadius: Dimensions.borderRadius,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 20 * SizeConfig.heightMultiplier,
                        height: 20 * SizeConfig.heightMultiplier,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(
                            20 * SizeConfig.heightMultiplier,
                          ),
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: CustomColors.highlightColor,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: CustomColors.lightColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  widget.user.name,
                  style: GoogleFonts.notoSans(
                    fontSize: 3 * SizeConfig.textMultiplier,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1 * SizeConfig.heightMultiplier),
                Text(
                  widget.user.semester.toString(),
                  style: GoogleFonts.notoSans(
                      fontSize: 18,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier,
                ),
                Text(
                  widget.user.branch,
                  style:
                      GoogleFonts.notoSans(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 1 * SizeConfig.heightMultiplier),
                Text(
                  widget.user.regNo.toString(),
                  style:
                      GoogleFonts.notoSans(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
