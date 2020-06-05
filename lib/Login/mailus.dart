import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/Components/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/Components/largeHeading.dart';
import 'package:sastra_ebooks/Components/tappableSubtitle.dart';
import '../Misc/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      /*-----Form-----*/
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ///*-----Title-----*///
              LargeHeading(
                text: 'Got\nTrouble',
                highlightText: ' ?',
                size: Heading.large,
              ),

              SizedBox(height: 40),

              ///*-----MailUs Form-----*///
              Form(
                key: _formKey,
                /*-----Column-----*/
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ///*-----RegNum Input-----*///
                    RegNumTextFormField(
                      onChanged: (String _input) => _regNum = _input,
                    ),

                    SizedBox(height: 20),

                    ///*-----Name Input-----*///
                    CustomTextFormField(
                      onChanged: (String _input) => _name = _input,
                      labelText: kNameString,
                      autovalidate: true,
                      validator: (String _input) {
                        if (_input.isEmpty) {
                          return kNameFieldEmptyString;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 60),

                    ///*-----MailUs Button-----*///
                    RoundedButton(
                      onPressed: sendEmail,
                      labelText: kMailUsString,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60),

              ///*-----GoTo Login-----*///
              TappableSubtitle(
                descriptionText: kAllGoodQString,
                actionText: kLoginString,
                onActionTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
