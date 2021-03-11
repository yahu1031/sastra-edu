/*
  Name: main
  Use:
  Todo:    - Add Use of this file
            - cleanup
            - add splash screen
            - add reaction to onAuthStateChanged
            - dd timeouts
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/pdf.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/login/forgotpassword.dart';
import 'package:sastra_ebooks/login/login.dart';
import 'package:sastra_ebooks/login/signup.dart';
import 'package:sastra_ebooks/misc/screens/downloads.dart';
import 'package:sastra_ebooks/misc/secret.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/profile/profile.dart';
import 'package:sastra_ebooks/profile/settingScreens/about.dart';
import 'package:sastra_ebooks/profile/settingScreens/buyACoke.dart';
import 'package:sastra_ebooks/profile/settingScreens/credits.dart';
import 'package:sastra_ebooks/profile/settingScreens/downloadsPayment.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/services/user.dart';
import 'package:sastra_ebooks/splashScreen.dart';
import 'package:wiredash/wiredash.dart';

import 'home/homeHandler.dart';
import 'home/screens/searchBooks.dart';
import 'login/mailVerification.dart';
import 'misc/screens/mailUs.dart';

main() {
  runApp(MyApp());
}

// This is the root file of the app
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
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
            print(SizeConfig.heightMultiplier);
            return Wiredash(
              projectId: Secret.projectID,
              secret: Secret.secretKey,
              navigatorKey: _navigatorKey,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                initialRoute: SplashScreen.id,
                routes: {
                  SplashScreen.id: (context) => SplashScreen(),
                  Login.id: (context) => Login(),
                  SignUp.id: (context) => SignUp(),
                  EmailVerification.id: (context) => EmailVerification(),
                  ForgotPassword.id: (context) => ForgotPassword(),
                  MailUs.id: (context) => MailUs(),
                  SearchBooks.id: (context) => SearchBooks(),
                  AboutUs.id: (context) => AboutUs(),
                  BuyACoke.id: (context) => BuyACoke(),
                  DownloadPayment.id: (context) => DownloadPayment(),
                  Credits.id: (context) => Credits(),
                  Downloads.id: (context) => Downloads(),
                },
                onGenerateRoute: (args) {
                  if (args.name == LoadingScreen.id) {
                    final User firebaseUser = args.arguments;
                    return MaterialPageRoute(
                      builder: (context) => LoadingScreen(firebaseUser),
                    );
                  } else if (args.name == HomeHandler.id) {
                    final UserData user = args.arguments;
                    return MaterialPageRoute(
                      builder: (context) => HomeHandler(user),
                    );
                  } else if (args.name == Profile.id) {
                    final UserData user = args.arguments;
                    return MaterialPageRoute(
                      builder: (context) => Profile(user),
                    );
                  } else if (args.name == PdfViewerPage.id) {
                    final Map arguments = args.arguments;
                    final Book book = arguments['book'];
                    final int page = arguments['page'] ?? 0;
                    return MaterialPageRoute(
                      builder: (context) => PdfViewerPage(
                        book: book,
                        page: page,
                      ),
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
