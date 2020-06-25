<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/auth.dart';
import '../Services/dialogs.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  bool loading = false;
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
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
                  /*-----Submit Button-----*/
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () async {
                        if (_email == null) {
                          Dialogs.yesAbortDialog(context, 'Sorry 😞',
                              "Please fill the Mail address. Email must not be empty.");
                        } else if (!_email.contains('@gmail.com')) {
                          Dialogs.yesAbortDialog(context, 'Error 😞',
                              "Please enter correct Email address, (@example.com - domain is missing.)");
                        }
                        print(_email);
                        await _auth.resetPassword(_email);
                        Dialogs.yesAbortDialog(context, 'Success 😉',
                            "You will receive a mail in short time to reset password.");
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
=======
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/Buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/Headings/largeHeading.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/Dialogs/loadingDialog.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

import '../Services/auth.dart';
import '../Services/dialogs.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = '/forgotPassword';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  void forgotPassword() async {
    if (_formKey.currentState.validate()) {
      if (!_email.contains('@gmail.com')) {
        Dialogs.yesAbortDialog(
            context, kErrorString, kEmailDomainMissingString);
      } else {
        showLoadingDialog(context);
        try {
          await _auth.resetPassword(_email);
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);

        Dialogs.yesAbortDialog(
            context, kSuccessString, kPasswordResetSuccessfulString);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      /*-----Form-----*/
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///*-----Title-----*///
              LargeHeading(
                text: 'Lost\nPassword',
                highlightText: ' ?',
                size: HeadingSize.large,
              ),

              SizedBox(
                height: 40,
              ),

              ///*-----Container-----*///
              CustomTextFormField(
                onChanged: (input) => setState(() => _email = input),
                labelText: kEmailString,
                keyboardType: TextInputType.emailAddress,
                autovalidate: true,
                validator: (String _input) {
                  if (_input.isEmpty) {
                    return kEmailFieldEmptyString;
                  }
                  return null;
                },
              ),

              SizedBox(height: 60.0),

              ///*-----Submit Button-----*///
              RoundedButton(
                onPressed: forgotPassword,
                labelText: kResetPasswordString,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> master
