import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/textFields.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import 'package:sastra_ebooks/Services/model.dart';

class SignupDetails extends StatefulWidget {
  static const id = '/SignupDetailsScreen';

  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails>
    with SingleTickerProviderStateMixin {
  String _name, _year, _branch;
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: FlatButton(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        onPressed: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            backgroundColor: Colors.white,
            resizeToAvoidBottomPadding: false,
            /*-----Form-----*/
            body: SingleChildScrollView(
              child: Center(
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
                                          text: 'Who are you ',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10 *
                                                  SizeConfig.widthMultiplier,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: '?',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10 *
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
                                              hintText: 'Full Name',
                                              isReg: true,
                                              onChanged: (String _input) =>
                                                  _name = _input,
                                            ),
                                            SizedBox(
                                                height: 3 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                            /*-----Password-----*/
                                            CustomTextFormField(
                                              onChanged: (String _input) =>
                                                  _year = _input,
                                              hintText: 'Year',
                                              isPassword: true,
                                            ),
                                            SizedBox(
                                                height: 3 *
                                                    SizeConfig
                                                        .heightMultiplier),

                                            /*-----Confirm Password-----*/
                                            CustomTextFormField(
                                              onChanged: (String _input) =>
                                                  _branch = _input,
                                              hintText: 'Branch',
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
                                              'SignUp',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black26,
                                                  fontSize: 40),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
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
      dynamic result = await _auth.registerWithEmailAndPassword(_name, _year);
      setState(() {
        loading = true;
      });

      if (_name == null && _year == null) {
        Dialogs.yesAbortDialog(context, kSorryString, kEmptyCredString);
        loading = false;
      } else if (_name == null) {
        Dialogs.yesAbortDialog(context, kRegNumString, kEmptyRegString);
        loading = false;
      } else if (_name.length < 9) {
        Dialogs.yesAbortDialog(context, kRegNumString, kRegLenString);
        loading = false;
      } else if (_year == null) {
        Dialogs.yesAbortDialog(
            context, kPasswordString, kPasswordMissingString);
        loading = false;
      } else if (_year.length < 6) {
        Dialogs.yesAbortDialog(context, kPasswordString, kPasswordLenString);
        loading = false;
      } else if (_year != _branch) {
        Dialogs.yesAbortDialog(context, kSorryString, kPasswordMismatch);
        loading = false;
      } else if (result == null) {
        Dialogs.yesAbortDialog(context, kSorryString, kCredMismatchString);
        loading = false;
      } else {
        print(_name);
        print(_year);
      }
    }
  }

  void login() {
    Navigator.pop(context);
  }
}
