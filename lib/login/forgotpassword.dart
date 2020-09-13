/*
 Name: forgotPassword
 Use:
 Todo:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/headings/largeHeading.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/dialogs/loadingDialog.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;

import '../services/auth.dart';
import '../services/dialogs.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = '/forgotPassword';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _regNum;

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardVisible;

  void forgotPassword() async {
    if (_formKey.currentState.validate()) {
      if (_regNum.length < 9) {
        dialogs.yesAbortDialog(context, Strings.regNumTooShortString,
            Strings.regNumTooShortExplainString);
      } else {
        showLoadingDialog(context);
        try {
          await _auth.resetPassword(_regNum);
        } catch (e) {}
        Navigator.pop(context);
        Dialogs.yesAbortDialog(context, Strings.successString,
            Strings.passwordResetSuccessfulString);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _keyboardVisible = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
        });
      },
    );
  }

  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomPadding: true,
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      /*-----Form-----*/
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.padding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ///*-----Title-----*///
              Container(
                child: (SizeConfig.heightMultiplier < 7 && !_keyboardVisible) ||
                        SizeConfig.heightMultiplier >= 7
                    ? Expanded(
                        flex: 10,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: LargeHeading(
                            text: 'Lost\nPassword',
                            highlightText: ' ?',
                            size: HeadingSize.large,
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 5,
                        child: Container(),
                      ),
              ),

              ///*-----Container-----*///
              RegNumTextFormField(
                onChanged: (input) => setState(() => _regNum = input),
              ),

              ///*-----Submit Button-----*///
              Expanded(
                flex: 10,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    child: RoundedButton(
                      onPressed: forgotPassword,
                      labelText: Strings.resetPasswordString,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
