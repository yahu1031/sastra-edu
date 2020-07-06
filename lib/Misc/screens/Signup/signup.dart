import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/textFields.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/screens/Signup/signupDetails.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import 'package:sastra_ebooks/Services/model.dart';

class SignUp extends StatefulWidget {
  static const id = '/signupScreen';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  String _regNum, _password, _rePassword;
  bool loading = false;
  bool tappedYes = false;
  final _formKey = GlobalKey<FormState>();

  Model model = Model();
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
            backgroundColor: Colors.white,
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
                                padding: EdgeInsets.symmetric(
                                  vertical: 10 * SizeConfig.heightMultiplier,
                                  horizontal: 2 * SizeConfig.heightMultiplier,
                                ),
                                child: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
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
                                            CustomTextFormField(
                                              hintText: 'Register Number',
                                              isReg: true,
                                              onChanged: (String _input) =>
                                                  _regNum = _input,
                                            ),
                                            SizedBox(
                                                height: 3 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                            /*-----Password-----*/
                                            CustomTextFormField(
                                              onChanged: (String _input) =>
                                                  _password = _input,
                                              hintText: 'Password',
                                              isPassword: true,
                                            ),
                                            SizedBox(
                                                height: 3 *
                                                    SizeConfig
                                                        .heightMultiplier),

                                            /*-----Confirm Password-----*/
                                            CustomTextFormField(
                                              onChanged: (String _input) =>
                                                  _rePassword = _input,
                                              hintText: 'Confirm Password',
                                              isPassword: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              5 * SizeConfig.heightMultiplier),
                                      /*-----SignUp Button-----*/
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Next',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black26,
                                                  fontSize: 40),
                                            ),
                                            GestureDetector(
                                              onTap: signupDetails,
                                              child: Container(
                                                height: 50.0,
                                                width: 70.0,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  shadowColor: Colors.grey
                                                      .withOpacity(0.2),
                                                  color: Colors.lightBlueAccent,
                                                  elevation: 5.0,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      size: 35,
                                                      color: Colors.white,
                                                    ),
                                                  ),
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
                              SizedBox(height: 5 * SizeConfig.heightMultiplier),
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

  void signup() async {
    if (_formKey.currentState.validate()) {
      dynamic result =
          await _auth.registerWithEmailAndPassword(_regNum, _password);
      setState(() {
        loading = true;
      });

      if (_regNum == null && _password == null) {
        Dialogs.yesAbortDialog(context, kSorryString, kEmptyCredString);
        loading = false;
      } else if (_regNum == null) {
        Dialogs.yesAbortDialog(context, kRegNumString, kEmptyRegString);
        loading = false;
      } else if (_regNum.length < 9) {
        Dialogs.yesAbortDialog(context, kRegNumString, kRegLenString);
        loading = false;
      } else if (_password == null) {
        Dialogs.yesAbortDialog(
            context, kPasswordString, kPasswordMissingString);
        loading = false;
      } else if (_password.length < 6) {
        Dialogs.yesAbortDialog(context, kPasswordString, kPasswordLenString);
        loading = false;
      } else if (_password != _rePassword) {
        Dialogs.yesAbortDialog(context, kSorryString, kPasswordMismatch);
        loading = false;
      } else if (result == null) {
        Dialogs.yesAbortDialog(context, kSorryString, kCredMismatchString);
        loading = false;
      } else {
        print(_regNum);
        print(_password);
      }
    }
  }

  void login() {
    Navigator.pop(context);
  }

  void signupDetails() => Navigator.popAndPushNamed(
        context,
        SignupDetails.id,
      );
}
