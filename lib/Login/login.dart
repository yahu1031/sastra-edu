import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Login/mailus.dart';
import '../Services/auth.dart';

import 'forgotpassword.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String _email, _password, _error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

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
                children: <Widget>[
                  /*-----Title 1-----*/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Container(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Hello \n',
                              style: GoogleFonts.montserrat(
                                  fontSize: 80.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'There ',
                              style: GoogleFonts.montserrat(
                                  fontSize: 80.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '.',
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
                  /*-----Container-----*/
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        /*-----Reg Number-----*/
                        TextFormField(
                          validator: (input) =>
                              input.isEmpty ? 'Please Enter Mail' : null,
                          onChanged: (input) => setState(() => _email = input),
                          decoration: InputDecoration(
                            labelText: 'REGISTER NUMBER',
                            labelStyle: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlueAccent,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightBlueAccent),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20.0),
                        /*-----Password-----*/
                        TextFormField(
                          validator: (input) => input.isEmpty
                              ? 'Please Enter Mail'
                              : input.length < 6
                                  ? 'Password must be more than 6 characters.'
                                  : null,
                          onChanged: (input) =>
                              setState(() => _password = input),
                          decoration: InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlueAccent,
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightBlueAccent),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 15.0),
                        /*-----Forgot Password-----*/
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: InkWell(
                            onTap: forgotpassword,
                            child: Text(
                              'Forgot Password',
                              style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w700,
                                color: Colors.lightBlueAccent,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
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
//                  signIn;
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(_email, _password);
                          print(_email);
                          print(_password);
                          if (result == null) {
                            setState(() {
                              _error = 'Could not match the credentials.';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(25.0),
                        shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
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
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      _error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  /*-----MailUs Account-----*/
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Can't you find your Account ?",
                          style:
                              GoogleFonts.notoSans(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 10.0),
                        InkWell(
                          onTap: () => mailUs(),
                          child: Text(
                            'MailUs',
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

  /*-----Forgot Password Func-----*/
  void forgotpassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPassword()),
    );
  }

  void mailUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MailUs()),
    );
  }
}
