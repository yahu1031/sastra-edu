import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              padding: const EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
              child: Container(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Trouble ',
                        style: GoogleFonts.montserrat(
                            fontSize: 70.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '?',
                        style: GoogleFonts.montserrat(
                            fontSize: 80.0,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            /*-----Container-----*/
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
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
                  SizedBox(height: 20.0),
                  /*-----Name-----*/
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty)
                        return 'Please provide your full name as per ID-Card';
                      return null;
                    },
                    onSaved: (input) => setState(() => _name = input),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlueAccent,
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
            SizedBox(height: 50.0),
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
            SizedBox(height: 30.0),
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
