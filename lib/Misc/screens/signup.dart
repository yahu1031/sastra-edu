import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';

class SignUp extends StatefulWidget {
  static const id = '/signupScreen';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  String _email, _password, _rePassword;
  bool loading = false;
  bool tappedYes = false;

  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

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
              child: SingleChildScrollView(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*-----Title 1-----*/
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 2 * SizeConfig.heightMultiplier,
                                    top: 2 * SizeConfig.heightMultiplier,
                                    left: 1 * SizeConfig.widthMultiplier),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Hey ',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15 *
                                                  SizeConfig.widthMultiplier,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: ', \n',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15 *
                                                  SizeConfig.widthMultiplier,
                                              color: Colors.lightBlueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: 'New User ',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15 *
                                                  SizeConfig.widthMultiplier,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: '?',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15 *
                                                  SizeConfig.widthMultiplier,
                                              color: Colors.lightBlueAccent,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Form(
                                  key: _formKey,
                                  /*-----Column-----*/
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /*-----Container-----*/
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                1 * SizeConfig.widthMultiplier,
                                            vertical: 1 *
                                                SizeConfig.heightMultiplier),
                                        child: Column(
                                          children: <Widget>[
                                            /*-----Reg Number-----*/
                                            TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    9),
                                              ],
                                              onChanged: (input) => setState(
                                                  () => _email = input),
                                              decoration: InputDecoration(
                                                labelText: kRegNumString,
                                                labelStyle:
                                                    GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .lightBlueAccent),
                                                ),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            SizedBox(
                                                height: 5 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                            /*-----Password-----*/
                                            TextFormField(
                                              onChanged: (input) => setState(
                                                  () => _password = input),
                                              decoration: InputDecoration(
                                                labelText: kPasswordString,
                                                labelStyle:
                                                    GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .lightBlueAccent),
                                                ),
                                              ),
                                              obscureText: true,
                                            ),
                                            SizedBox(
                                                height: 5 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                            /*-----Confirm Password-----*/
                                            TextFormField(
                                              onChanged: (input) => setState(
                                                  () => _rePassword = input),
                                              decoration: InputDecoration(
                                                labelText: kConfirmPassword,
                                                labelStyle:
                                                    GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.lightBlueAccent,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .lightBlueAccent),
                                                ),
                                              ),
                                              obscureText: true,
                                            ),
                                            SizedBox(
                                                height: 5 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 15 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  child: TextFormField(
//                                                    onChanged: (input) =>
//                                                        setState(() =>
//                                                            _password = input),
                                                    decoration: InputDecoration(
                                                      labelText: kBranchString,
                                                      labelStyle:
                                                          GoogleFonts.notoSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .lightBlueAccent),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                ),
                                                Container(
                                                  width: 15 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
//                                                    onChanged: (input) =>
//                                                        setState(() =>
//                                                            _password = input),
                                                    decoration: InputDecoration(
                                                      labelText: kYearString,
                                                      labelStyle:
                                                          GoogleFonts.notoSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .lightBlueAccent),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              5 * SizeConfig.heightMultiplier),
                                      /*-----SignUp Button-----*/
                                      Center(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          height: 50.0,
                                          width:
                                              50 * SizeConfig.widthMultiplier,
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                dynamic result = await _auth
                                                    .registerWithEmailAndPassword(
                                                        _email, _password);
                                                setState(() {
                                                  loading = true;
                                                });

                                                if (_email == null &&
                                                    _password == null) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kSorryString,
                                                      kEmptyCredString);
                                                  loading = false;
                                                } else if (_email == null) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kRegNumString,
                                                      kEmptyRegString);
                                                  loading = false;
                                                } else if (_email.length < 9) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kRegNumString,
                                                      kRegLenString);
                                                  loading = false;
                                                } else if (_password == null) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kPasswordString,
                                                      kPasswordMissingString);
                                                  loading = false;
                                                } else if (_password.length <
                                                    6) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kPasswordString,
                                                      kPasswordLenString);
                                                  loading = false;
                                                } else if (_password !=
                                                    _rePassword) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kSorryString,
                                                      kPasswordMismatch);
                                                  loading = false;
                                                } else if (result == null) {
                                                  Dialogs.yesAbortDialog(
                                                      context,
                                                      kSorryString,
                                                      kCredMismatchString);
                                                  loading = false;
                                                } else {
                                                  print(_email);
                                                  print(_password);
                                                }
                                              }
                                            },
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              shadowColor: Colors
                                                  .lightBlueAccent
                                                  .withOpacity(0.2),
                                              color: Colors.lightBlueAccent,
                                              elevation: 7.0,
                                              child: Center(
                                                child: Text(
                                                  kSignup,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /*-----Login Account-----*/
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 3 * SizeConfig.heightMultiplier),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      kHaveAccString,
                                      style: GoogleFonts.notoSans(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 10.0),
                                    InkWell(
                                      onTap: () => login(),
                                      child: Text(
                                        kLoginString,
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
            ),
          );
  }

  void login() {
    Navigator.pop(context);
  }
}
