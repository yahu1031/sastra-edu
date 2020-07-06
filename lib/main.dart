import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Home/HomeHandler.dart';
import 'package:sastra_ebooks/Home/screens/searchBooks.dart';
import 'package:sastra_ebooks/Login/forgotpassword.dart';
import 'package:sastra_ebooks/Login/login.dart';
import 'package:sastra_ebooks/Misc/screens/Signup/signup.dart';
import 'package:sastra_ebooks/Misc/screens/Signup/signupDetails.dart';
import 'package:sastra_ebooks/Misc/screens/mailUs.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';
import 'package:sastra_ebooks/Profile/Settings/about.dart';
import 'package:sastra_ebooks/Profile/Settings/buyacoke.dart';
import 'package:sastra_ebooks/Profile/Settings/unused/support.dart';
import 'package:sastra_ebooks/Profile/profile.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/user.dart';
import 'package:sastra_ebooks/Services/wrapper.dart';
import 'package:sastra_ebooks/loadingScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return StreamProvider<User>.value(
              value: AuthServices().user,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: Wrapper.id,
                routes: {
                  Wrapper.id: (context) => Wrapper(),
                  Login.id: (context) => Login(),
                  ForgotPassword.id: (context) => ForgotPassword(),
                  MailUs.id: (context) => MailUs(),
                  HomeHandler.id: (context) => HomeHandler(),
                  SearchBooks.id: (context) => SearchBooks(),
                  Profile.id: (context) => Profile(),
                  Support.id: (context) => Support(),
                  About.id: (context) => About(),
                  BuyACoke.id: (context) => BuyACoke(),
                  SignUp.id: (context) => SignUp(),
                  SignupDetails.id: (context) => SignupDetails(),
                },
                onGenerateRoute: (settings) {
                  if (settings.name == LoadingScreen.id) {
                    final User user = settings.arguments;
                    return MaterialPageRoute(
                      builder: (context) => LoadingScreen(user),
                    );
                  }
                  return null;
                },
                theme: ThemeData(
                  textTheme: TextTheme(
                    bodyText1: body1TextStyle,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
