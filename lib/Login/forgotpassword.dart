import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/tappableText.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/constants.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Dialogs/loadingDialog.dart';
import '../Services/auth.dart';
import '../Services/dialogs.dart';
import '../textStyles.dart';

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
    if (_email == null) {
      Dialogs.yesAbortDialog(context, kSorryString, kEmailFieldEmptyString);
    } else if (!_email.contains('@gmail.com')) {
      Dialogs.yesAbortDialog(context, kErrorString, kEmailDomainMissingString);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      /*-----Form-----*/
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///*-----Title-----*///
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Lost\nPassword',
                      style: headline2TextStyle,
                    ),
                    TextSpan(
                      text: ' ?',
                      style: headline2HighlightTextStyle,
                    ),
                  ],
                ),
              ),
            ),

            ///*-----Container-----*///
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
              child: CustomTextFormField(
                onChanged: (input) => setState(() => _email = input),
                labelText: kEmailString,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 50.0),

            ///*-----Submit Button-----*///
            RoundedButton(
              onPressed: forgotPassword,
              labelText: kResetPasswordString,
            ),
            SizedBox(height: 50.0),

            ///*-----MailUs Account-----*///
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    kDoUKnowCredentialsString,
                    style: subtitle1TextStyle,
                  ),
                  SizedBox(width: 10.0),
                  TappableText(
                    kLogInString,
                    onTap: () => Navigator.pop(context),
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
