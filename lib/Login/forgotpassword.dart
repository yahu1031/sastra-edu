import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            /*-----Form-----*/
            body: Form(
              key: _formKey,
              /*-----Column-----*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*-----Title 1-----*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Lost \n',
                              style: GoogleFonts.montserrat(
                                  fontSize: 50.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Password ',
                              style: GoogleFonts.montserrat(
                                  fontSize: 50.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '?',
                              style: GoogleFonts.montserrat(
                                  fontSize: 50.0,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /*-----Container-----*/
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        /*-----Email-----*/
                        TextFormField(
                          validator: (input) =>
                              input.isEmpty ? 'Please Enter Mail' : null,
                          onChanged: (input) => setState(() => _email = input),
                          decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlueAccent,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightBlueAccent),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  /*-----Login Button-----*/
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () async {
                        print(_email);
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(25.0),
                        shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
                        color: Colors.lightBlueAccent,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'Reset Password',
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
                  SizedBox(height: 50.0),
                  /*-----MailUs Account-----*/
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "You know your Credentials ?",
                          style:
                              GoogleFonts.notoSans(fontWeight: FontWeight.w600),
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
