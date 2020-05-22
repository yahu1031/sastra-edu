import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import '../Services/Responsive/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class MailUs extends StatefulWidget {
  final Function toggleView;
  MailUs({this.toggleView});

  @override
  _MailUsState createState() => _MailUsState();
}

class _MailUsState extends State<MailUs> with SingleTickerProviderStateMixin {
  String _name, _regNo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      /*-----Form-----*/
      body: Form(
        key: _formKey,
        /*-----Column-----*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*-----Title 1-----*/
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 15 * SizeConfig.heightMultiplier, 0.0, 0.0),
              child: Container(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Trouble ',
                        style: GoogleFonts.montserrat(
                            fontSize: 18 * SizeConfig.widthMultiplier,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '?',
                        style: GoogleFonts.montserrat(
                            fontSize: 20 * SizeConfig.widthMultiplier,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 1*SizeConfig.heightMultiplier),
            /*-----Container-----*/
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 10 * SizeConfig.widthMultiplier, 20.0, 0.0),
              child: Column(
                children: <Widget>[
                  /*-----Reg Number-----*/
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty)
                        return 'Please provide your Register Number';
                      return null;
                    },
                    onSaved: (input) => setState(() => _regNo = input),
                    decoration: InputDecoration(
                      labelText: 'Reg Number',
                      labelStyle: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlueAccent,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  /*-----Name-----*/
                  TextFormField(
                    onSaved: (input) => setState(() => _name = input),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlueAccent,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10 * SizeConfig.heightMultiplier),
            /*-----MailUs Button-----*/
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
                color: Colors.lightBlueAccent,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    customLaunch(
                        'mailto:your@email.com?subject=test%20subject&body=$_name%20$_regNo%20body');
                    // print(_name);
                    // print(_regNo);
                  },
                  child: Center(
                    child: Text(
                      'Mail Us',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            /*-----MailUs Account-----*/
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You know your Account ?",
                    style: GoogleFonts.notoSans(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10.0),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600,
                        color: Colors.lightBlueAccent,
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
