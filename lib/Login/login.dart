import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Login/signup.dart';
import '../Services/dialogs.dart';
import '../Services/auth.dart';
import '../Services/Responsive/size_config.dart';
=======
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/Buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/Buttons/tappableText.dart';
import 'package:sastra_ebooks/Components/Headings/largeHeading.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/Dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/screens/signup.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/user.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
>>>>>>> master

import 'forgotpassword.dart';

class Login extends StatefulWidget {
<<<<<<< HEAD
  final Function toggleView;
  final String title;
  Login({Key key, this.title, this.toggleView}) : super(key: key);
=======
  static const id = '/loginScreen';
>>>>>>> master

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
<<<<<<< HEAD
  String _email, _password;
  bool loading = false;
  bool tappedYes = false;
=======
  String _regNum, _password;
>>>>>>> master

  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

<<<<<<< HEAD
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
            resizeToAvoidBottomPadding: false,
            /*-----Form-----*/
            body: Center(
              child: Container(
                color: Colors.white,
                child: SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  child: Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Form(
                                key: _formKey,
                                /*-----Column-----*/
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /*-----Title 1-----*/
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              2 * SizeConfig.heightMultiplier,
                                          top: 2 * SizeConfig.heightMultiplier,
                                          left: 1 * SizeConfig.widthMultiplier),
                                      child: Container(
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Hello \n',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: 'There ',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: '.',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    color:
                                                        Colors.lightBlueAccent,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    /*-----Container-----*/
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              1 * SizeConfig.widthMultiplier,
                                          vertical:
                                              1 * SizeConfig.heightMultiplier),
                                      child: Column(
                                        children: <Widget>[
                                          /*-----Reg Number-----*/
                                          TextFormField(
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  9),
                                            ],
                                            onChanged: (input) =>
                                                setState(() => _email = input),
                                            decoration: InputDecoration(
                                              labelText: 'REGISTER NUMBER',
                                              labelStyle: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.lightBlueAccent),
                                              ),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                          SizedBox(
                                              height: 5 *
                                                  SizeConfig.heightMultiplier),
                                          /*-----Password-----*/
                                          TextFormField(
                                            onChanged: (input) => setState(
                                                () => _password = input),
                                            decoration: InputDecoration(
                                              labelText: 'PASSWORD',
                                              labelStyle: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.lightBlueAccent,
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.lightBlueAccent),
                                              ),
                                            ),
                                            obscureText: true,
                                          ),
                                          SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier),
                                          /*-----Forgot Password-----*/
                                          Container(
                                            alignment: Alignment(1.0, 0.0),
                                            padding: EdgeInsets.only(
                                                top:
                                                    SizeConfig.heightMultiplier,
                                                left:
                                                    SizeConfig.widthMultiplier),
                                            child: InkWell(
                                              onTap: forgotpassword,
                                              child: Text(
                                                'Forgot Password',
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.lightBlueAccent,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            5 * SizeConfig.heightMultiplier),
                                    /*-----Login Button-----*/
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      height: 50.0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            dynamic result = await _auth
                                                .signInWithEmailAndPassword(
                                                    _email, _password);
                                            setState(() {
                                              loading = true;
                                            });

                                            if (_email == null &&
                                                _password == null) {
                                              Dialogs.yesAbortDialog(
                                                  context,
                                                  'Sorry 😞',
                                                  "Please fill the credentials. Credentials must not be empty.");
                                              loading = false;
                                            } else if (_email == null) {
                                              Dialogs.yesAbortDialog(
                                                  context,
                                                  'Register Number',
                                                  "You are missing your Register number. please enter it.");
                                              loading = false;
                                            } else if (_email.length < 9) {
                                              Dialogs.yesAbortDialog(
                                                  context,
                                                  'Register Number',
                                                  'Your register number must be 9 characters.');
                                              loading = false;
                                            } else if (_password == null) {
                                              Dialogs.yesAbortDialog(
                                                  context,
                                                  'Password',
                                                  "You are missing your password. please enter it.");
                                              loading = false;
                                            } else if (_password.length < 6) {
                                              Dialogs.yesAbortDialog(
                                                  context,
                                                  'Password',
                                                  'Your password must be more than 6 characters.');
                                              loading = false;
                                            } else if (result == null) {
                                              Dialogs.yesAbortDialog(
                                                  context,
                                                  'Sorry 😞',
                                                  "Your credentials did not match. Please try with Correct credentials.");
                                              loading = false;
                                            } else {
                                              print(_email);
                                              print(_password);
                                            }
//                                        _messaging.getToken().then((token) => print(token));
                                          }
                                        },
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          shadowColor: Colors.lightBlueAccent
                                              .withOpacity(0.2),
                                          color: Colors.lightBlueAccent,
                                          elevation: 7.0,
                                          child: Center(
                                            child: Text(
                                              'LOGIN',
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
                                    SizedBox(
                                        height:
                                            3 * SizeConfig.heightMultiplier),
                                  ],
                                ),
                              ),
                            ),
                            /*-----Signup Account-----*/
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 3 * SizeConfig.heightMultiplier),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Don't you have an Account ?",
                                    style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 10.0),
                                  InkWell(
                                    onTap: () => signUp(),
                                    child: Text(
                                      'Sign Up',
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
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  /*-----Forgot Password Func-----*/
  void forgotpassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPassword()),
    );
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
=======
  void logIn() async {
    if (_formKey.currentState.validate()) {
      dialogs.showLoadingDialog(context);
      final User user = await _auth.signInWithEmailAndPassword(
        _regNum,
        _password,
      );
      Navigator.pop(context, true);
      if (_regNum.length < 9) {
        dialogs.yesAbortDialog(
            context, kRegNumTooShortString, kRegNumTooShortExplainString);
      } else if (_password.length < 6) {
        dialogs.yesAbortDialog(
            context, kPasswordTooShortString, kPasswordTooShortExplainString);
      } else if (user == null) {
        dialogs.yesAbortDialog(
            context, kSorryString, kInvalidCredentialsExplainString);
      } else {
        Navigator.pushReplacementNamed(context, LoadingScreen.id,
            arguments: user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomPadding: true,

      ///*-----Login-Form-----*///
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///*-----Title -----*///
                  LargeHeading(
                    text: 'Hello\nThere',
                    highlightText: ' .',
                    size: HeadingSize.extraLarge,
                  ),

                  SizedBox(height: 40),

                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ///*-----TextFormFields-----*///
                        RegNumTextFormField(
                          onChanged: (String _input) => _regNum = _input,
                        ),

                        SizedBox(height: 20),

                        ///*-----Password-----*///
                        PasswordTextFormField(
                          onChanged: (String _input) => _password = _input,
                        ),

                        ///*-----Forgot Password-----*///
                        Align(
                          alignment: Alignment.topRight,
                          child: TappableText(
                            kForgotPasswordString,
                            onTap: () => Navigator.pushNamed(
                              context,
                              ForgotPassword.id,
                            ),
                          ),
                        ),

                        SizedBox(height: 60),

                        ///*-----Login Button-----*///
                        RoundedButton(
                          onPressed: logIn,
                          labelText: kLoginString,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 60),

                  ///*-----MailUs Account-----*///
                  TappableSubtitle(
                    descriptionText: kNoAccString,
                    actionText: kSignUpString,
                    onActionTap: () => Navigator.pushNamed(
                      context,
                      SignUp.id,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
>>>>>>> master
    );
  }
}
