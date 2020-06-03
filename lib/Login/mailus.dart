import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/regNumbTextFormField.dart';
import 'package:sastra_ebooks/Components/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/textStyles.dart';
import '../Services/Responsive/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sastra_ebooks/constants.dart';

// Todo: - Add real support email

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

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  void sendEmail() async {
    if (_regNum != null && _name != null) {
      final String mailtoUrl =
          'mailto:$supportEmail?subject=$_name%20-%20$_regNum';

      if (await canLaunch(mailtoUrl)) {
        await launch(mailtoUrl);
      } else {
        print(' could not launch $mailtoUrl');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      /*-----Form-----*/
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: _formKey,
          /*-----Column-----*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*-----Title 1-----*/
              Padding(
                padding: EdgeInsets.fromLTRB(
                    15.0, 15 * SizeConfig.heightMultiplier, 0.0, 0.0),
                child: Container(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Got\nTrouble',
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
              ),
              SizedBox(height: 1 * SizeConfig.heightMultiplier),
              /*-----Container-----*/
              Container(
                padding: EdgeInsets.fromLTRB(
                    20.0, 10 * SizeConfig.widthMultiplier, 20.0, 0.0),
                child: Column(
                  children: <Widget>[
                    ///*-----Reg Number-----*///
                    RegNumTextFormField(
                      onChanged: (String _input) => _regNum = _input,
                    ),
//                    TextFormField(
//                      validator: (input) {
//                        if (input.isEmpty)
//                          return 'Please provide your Register Number';
//                        return null;
//                      },
//                      onSaved: (input) => setState(() => _regNum = input),
//                    ),
                    SizedBox(height: 2 * SizeConfig.heightMultiplier),

                    ///*-----Name-----*///
                    CustomTextFormField(
                      onChanged: (String _input) => _name = _input,
                      labelText: kNameString,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10 * SizeConfig.heightMultiplier),

              /*-----MailUs Button-----*/
              RoundedButton(
                onPressed: sendEmail,
                labelText: kMailUsString,
              ),
              SizedBox(height: 5 * SizeConfig.heightMultiplier),

              ///*-----MailUs Account-----*///
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "All good?",
                      style: subtitle1TextStyle,
                    ),
                    SizedBox(width: 10.0),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: subtitle1HighlightTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
