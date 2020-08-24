import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/components/buttons/tappableText.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/dialogs/loadingDialog.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/auth.dart';
import 'package:sastra_ebooks/services/dialogs.dart';
import 'package:sastra_ebooks/services/images.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/dialogs/loadingDialog.dart' as dialogs;
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;

class Login extends StatefulWidget {
  static const id = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _regNum, _password;
  bool onSignup = false;
  bool onForgotPassword = false;
  final formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  void logIn() async {
    if (formKey.currentState.validate()) {
      dialogs.showLoadingDialog(context);
      final FirebaseUser _firebaseUser = await _auth.signInWithEmailAndPassword(
        _regNum,
        _password,
      );
      Navigator.pop(context, true);
      if (_regNum == null ||
          _password == null ||
          _regNum == null && _password == null) {
        dialogs.yesAbortDialog(
            context, Strings.sorryString, Strings.credentialsMissingString);
      }
//      Navigator.pop(context, true);
      if (_regNum.length < 9) {
        print(1);
        dialogs.yesAbortDialog(context, Strings.regNumTooShortString,
            Strings.regNumTooShortExplainString);
      } else if (_password.length < 6) {
        print(2);

        dialogs.yesAbortDialog(context, Strings.passwordTooShortString,
            Strings.passwordTooShortExplainString);

        //        dialogs.yesAbortDialog(context, Strings.sorryString,
//            Strings.invalidCredentialsExplainString);
      } else if (_firebaseUser == null) {
        print(4);
      } else {
        print(5);

        Navigator.pushNamedAndRemoveUntil(
            context, LoadingScreen.id, (route) => false,
            arguments: _firebaseUser);
      }
    }
  }

  void forgotPassword() async {
    if (formKey.currentState.validate()) {
      if (_regNum.length == 0) {
        Dialogs.yesAbortDialog(
            context, Strings.kRegNumTooShort, Strings.regNumFieldEmptyString);
      } else if (_regNum.length != 9) {
        Dialogs.yesAbortDialog(
            context, Strings.kRegNumTooShort, Strings.kRegNumTooShortExplain);
      } else {
        showLoadingDialog(context);
        try {
          await _auth.resetPassword(_regNum);
        } catch (e) {
          print(e);
        }
        Navigator.pop(context);
        Dialogs.yesAbortDialog(
            context, Strings.kResetPassword, Strings.kResetMessage);
        setState(() {
          onForgotPassword = !onForgotPassword;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE1F5FE),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 100,
                    width: 100,
                    child: Center(
                      child: Image.asset(
                        onSignup
                            ? Images.kSignupPic
                            : onForgotPassword
                                ? Images.kForgotpassPic
                                : Images.kLoginPic,
                      ),
                    ),
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Text(
                    onSignup
                        ? Strings.kNewHere
                        : onForgotPassword
                            ? Strings.kForgotPassword
                            : Strings.kHelloThere,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4 * SizeConfig.heightMultiplier),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RegNumTextFormField(
                          onChanged: (String _input) => _regNum = _input,
                        ),
                        onForgotPassword
                            ? SizedBox()
                            : onSignup
                                ? SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier)
                                : SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier),
                        onSignup
                            ? CustomTextField(
                                hint: Strings.kName,
                                isPassword: false,
                                onChanged: (value) {},
                              )
                            : SizedBox(height: 0),
                        onForgotPassword
                            ? SizedBox()
                            : onSignup
                                ? SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier)
                                : SizedBox(),
                        onForgotPassword
                            ? SizedBox()
                            : PasswordTextFormField(
                                onChanged: (String _input) =>
                                    _password = _input,
                              ),
                        onSignup
                            ? SizedBox()
                            : onForgotPassword
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: TappableText(
                                          Strings.forgotPasswordString,
                                          onTap: () {
                                            setState(() {
                                              onForgotPassword =
                                                  !onForgotPassword;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                        onForgotPassword
                            ? SizedBox()
                            : onSignup
                                ? SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier)
                                : SizedBox(
                                    height: 5 * SizeConfig.heightMultiplier),
                        onSignup
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40 * SizeConfig.widthMultiplier,
                                    child: CustomTextField(
                                      hint: Strings.kYear,
                                      isPassword: false,
                                      onDigit: true,
                                      textLimit: 1,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    width: 40 * SizeConfig.widthMultiplier,
                                    child: CustomTextField(
                                      hint: Strings.kBranch,
                                      isPassword: false,
                                      onDigit: false,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(height: 0),
                        (onSignup || onForgotPassword)
                            ? SizedBox(height: 5 * SizeConfig.heightMultiplier)
                            : SizedBox(
                                height: 0,
                                width: 0,
                              ),
                        CustomButton(
                          text: onSignup
                              ? Strings.kSignup
                              : onForgotPassword
                                  ? Strings.kResetPassword
                                  : Strings.kLogin,
                          textColor: Colors.white,
                          fontSize: onForgotPassword
                              ? 3.5 * SizeConfig.widthMultiplier
                              : 4.5 * SizeConfig.widthMultiplier,
                          buttonColor: Colors.lightBlueAccent,
                          onPressed: () {
                            if (onForgotPassword) {
                              forgotPassword();
                            } else {
                              onSignup ? signup() : logIn();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5 * SizeConfig.heightMultiplier),
                  Container(
                    child: Container(
                      child: TappableSubtitle(
                        descriptionText: !onSignup
                            ? Strings.kNewAcc
                            : onForgotPassword
                                ? Strings.kNewAcc
                                : Strings.kOldAcc,
                        actionText: !onSignup
                            ? Strings.kSignup
                            : onForgotPassword
                                ? Strings.kSignup
                                : Strings.kLogin,
                        onActionTap: () {
                          print(onForgotPassword);
                          if (onForgotPassword = true) {
                            print(onSignup);
                            setState(() {
                              onForgotPassword = !onForgotPassword;
                              onSignup = !onSignup;
                            });
                          } else
                            setState(() {
                              onSignup = !onSignup;
                            });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signup() {
    print('Signup');
    // Navigator.pushNamed(context, EmailVerification.id);
  }
}
