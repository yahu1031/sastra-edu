import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/Headings/largeHeading.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/Dialogs/loadingDialog.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';

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
