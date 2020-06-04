import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/Components/largeHeading.dart';
import 'package:sastra_ebooks/Components/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/tappableText.dart';
import 'package:sastra_ebooks/Dialogs/loadingDialog.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

import '../Services/auth.dart';
import '../Services/dialogs.dart';
import '../misc/textStyles.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      /*-----Form-----*/
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  size: Heading.large,
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

                SizedBox(height: 50.0),

                ///*-----Submit Button-----*///
                RoundedButton(
                  onPressed: forgotPassword,
                  labelText: kResetPasswordString,
                ),

                SizedBox(height: 50.0),

                ///*-----GoTo Login-----*///
                TappableSubtitle(
                  descriptionText: kDoUKnowCredentialsString,
                  actionText: kLoginString,
                  onActionTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
