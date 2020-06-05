import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Home/searchBooks.dart';
import 'package:sastra_ebooks/Login/forgotpassword.dart';
import 'package:sastra_ebooks/Login/login.dart';
import 'package:sastra_ebooks/Login/mailus.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/widgetTests.dart';
import 'Services/Responsive/size_config.dart';
import 'Services/auth.dart';
import 'Services/user.dart';
import 'Services/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

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
                //home: WidgetTests(),
                initialRoute: Wrapper.id,
                routes: {
                  Wrapper.id: (context) => Wrapper(),
                  Login.id: (context) => Login(),
                  ForgotPassword.id: (context) => ForgotPassword(),
                  MailUs.id: (context) => MailUs(),
                  SearchBooks.id: (context) => SearchBooks(),
                  //Splash.id: (context) => Splash(),
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
                    headline1: GoogleFonts.montserrat(
                        fontSize: 20 * SizeConfig.widthMultiplier,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    headline2: GoogleFonts.montserrat(
                        fontSize: 50,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    headline6: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightBlueAccent,
                    ),
                    subtitle2: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.lightBlueAccent,
                    ),
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
