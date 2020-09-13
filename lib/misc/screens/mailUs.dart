/*
 Name: mailUs
 Use:
 Todo:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/headings/largeHeading.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dimensions.dart';
import '../strings.dart';

/* Todo:  - Add real support email
          - Add error message if no email app can be opened
*/
class MailUs extends StatefulWidget {
  static const String id = '/mailUs';
  final Function toggleView;
  MailUs({this.toggleView});

  @override
  _MailUsState createState() => _MailUsState();
}

class _MailUsState extends State<MailUs> with SingleTickerProviderStateMixin {
  String _name, _regNum;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const supportEmail = 'example@email.com';

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardVisible;

  void sendEmail() async {
    if (_formKey.currentState.validate()) {
      final String mailtoUrl =
          'mailto:$supportEmail?subject=$_name%20-%20$_regNum';

      if (await canLaunch(mailtoUrl)) {
        await launch(mailtoUrl);
      } else {
        print('Couldn\'t open an email app');
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
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),

      ///*-----Form-----*///
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
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
                          text: 'Got\nTrouble',
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

            ///*-----MailUs Form-----*///
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ///*-----RegNum Input-----*///
                  RegNumTextFormField(
                    onChanged: (String _input) => _regNum = _input,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  ///*-----Name Input-----*///
                  CustomTextFormField(
                    onChanged: (String _input) => _name = _input,
                    labelText: Strings.nameString,
                    autovalidate: true,
                    validator: (String _input) {
                      if (_input.isEmpty) {
                        return Strings.nameFieldEmptyString;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            ///*-----MailUs Button-----*///
            Expanded(
              flex: 7,
              child: Center(
                child: Container(
                  width: double.infinity,
                  child: RoundedButton(
                    onPressed: sendEmail,
                    labelText: Strings.mailUsString,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
