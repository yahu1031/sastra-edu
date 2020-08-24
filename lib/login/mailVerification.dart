import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/components/textFields/otpTextField.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/dialogs.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';

class EmailVerification extends StatefulWidget {
  static const id = '/mailVerification';
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  String pin;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Lottie.asset(
                        Jsons.kMailVerificationJson,
                        height: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 2 * SizeConfig.heightMultiplier),
                  Text(
                    Strings.kOtpSent,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lexendDeca(
                      fontSize: 4.5 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4 * SizeConfig.heightMultiplier),
                  Form(
                    autovalidate: true,
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: OTPTextField(
                            onChanged: (String _input) {
                              pin = _input;
                            },
                            onCompleted: (pin) {
                              print("onCompleted Completed: " + pin);
                            },
                          ),
                        ),
                        SizedBox(height: 5 * SizeConfig.heightMultiplier),
                        CustomButton(
                          text: 'Verify',
                          textColor: Colors.white,
                          fontSize: 4.5 * SizeConfig.widthMultiplier,
                          buttonColor: Colors.lightBlueAccent,
                          onPressed: () {
                            print(pin);
                            Dialogs.yesAbortDialog(context, 'Success',
                                'Account has been verified Successfully');
                          },
                        ),
                        SizedBox(height: 5 * SizeConfig.heightMultiplier),
                        TappableSubtitle(
                          descriptionText: 'Your E-mail isn\'t correct ?',
                          actionText: 'Cancel',
                          onActionTap: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
