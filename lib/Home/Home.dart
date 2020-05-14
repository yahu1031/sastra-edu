import 'package:flutter_svg/flutter_svg.dart';

import '../Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/Responsive/size_config.dart';
import '../Services/paths.dart';
import '../Services/auth.dart';
import 'package:shimmer/shimmer.dart';

import 'Books/all.dart';
import 'Books/cyber.dart';
import 'Books/lab.dart';
import 'Books/software.dart';

final Color backgroundColor = Colors.white;

class Home extends StatefulWidget {
  final data;
  Home(this.data);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  final AuthServices _auth = AuthServices();
  List<Tab> tab = [];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.data["Tabs"].length; i++) {
      tab.add(
        Tab(child: Text(widget.data["Tabs"][i])),
      );
    }
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);

    tabController =
        new TabController(length: widget.data["Tabs"].length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Shimmer.fromColors(
            baseColor: Colors.blue[500],
            highlightColor: Colors.lightBlueAccent,
            child: Container(
              child: new Text(
                'M-Book Edu',
                style: GoogleFonts.pacifico(
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              setState(() {
                if (isCollapsed) {
                  _controller.forward();
                  print('Menu');
                } else {
                  _controller.reverse();
                  print('Home');
                }
                isCollapsed = !isCollapsed;
              });
            },
            icon: Icon(
              Icons.menu,
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            dashboard(context),
            menu(context),
          ],
        ));
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 230.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                      print('Profile');
                    },
                    child: new CircleAvatar(
                      radius: 8 * SizeConfig.widthMultiplier,
                      backgroundImage: AssetImage(Images.profile),
                    ),
                  ),
                  padding: const EdgeInsets.all(2.0),
                  decoration: new BoxDecoration(
                    color: Colors.lightBlueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 5 * SizeConfig.heightMultiplier),
                Padding(
                  padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                  child: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      print('Home');
                    },
                  ),
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                Padding(
                  padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      print('Favorite');
                    },
                  ),
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                Padding(
                  padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                  child: IconButton(
                    icon: Icon(Icons.book),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      print('Bookmarks');
                    },
                  ),
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                Padding(
                  padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                  child: IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      print('Class');
                    },
                  ),
                ),
                SizedBox(height: 3 * SizeConfig.heightMultiplier),
                Padding(
                  padding: EdgeInsets.all(1 * SizeConfig.heightMultiplier),
                  child: IconButton(
                    icon: Icon(Icons.power_settings_new),
                    color: Colors.lightBlueAccent,
                    onPressed: () async {
                      await _auth.signOut();
                      setState(() {
                        print('Logged out');
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.15 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                // Container(
                //   padding: EdgeInsets.only(
                //       left: 16,
                //       right: 16,
                //       top: 1 * SizeConfig.heightMultiplier),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           Material(
                //             color: Colors.transparent,
                //             child: InkWell(
                //               splashColor: Colors.white,
                //               child: SizedBox(
                //                 width: 7 * SizeConfig.widthMultiplier,
                //                 height: 7 * SizeConfig.widthMultiplier,
                //                 child: SvgPicture.asset(
                //                   'assets/icons/menu.svg',
                //                   color: Colors.lightBlueAccent,
                //                 ),
                //               ),
                //               onTap: () {
                //                 setState(() {
                //                   if (isCollapsed) {
                //                     _controller.forward();
                //                     print('Menu');
                //                   } else {
                //                     _controller.reverse();
                //                     print('Home');
                //                   }
                //                   isCollapsed = !isCollapsed;
                //                 });
                //               },
                //             ),
                //           ),
                //           Shimmer.fromColors(
                //             baseColor: Colors.blue[500],
                //             highlightColor: Colors.lightBlueAccent,
                //             child: Container(
                //               margin: EdgeInsets.symmetric(
                //                   horizontal:
                //                       1 * SizeConfig.heightMultiplier),
                //               child: new Text(
                //                 'M-Book Edu',
                //                 style: GoogleFonts.pacifico(
                //                   fontSize: 30.0,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           ClipOval(
                //             child: Material(
                //               color: Colors.grey[100],
                //               child: SizedBox(
                //                 width: 5 * SizeConfig.heightMultiplier,
                //                 height: 5 * SizeConfig.heightMultiplier,
                //                 child: IconButton(
                //                   icon: Icon(
                //                     Icons.search,
                //                     size: 5 * SizeConfig.heightMultiplier,
                //                   ),
                //                   color: Colors.lightBlueAccent,
                //                   onPressed: () {
                //                     print('Search');
                //                   },
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Text(
                          'Your',
                          style: GoogleFonts.notoSans(
                              color: Colors.black, fontSize: 40.0),
                        ),
                        Text(
                          'Bookshelf.',
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: 150.0,
                              maxWidth: 700.0,
                              minWidth: 250.0,
                              // minHeight: 100.0,
                            ),
                            padding: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                alignment: Alignment.centerRight,
                                image: AssetImage(
                                  Images.read,
                                ),
                              ),
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                )
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Study time today',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'minutes',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flex(direction: Axis.horizontal, children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Center(
                            child: TabBar(
                              controller: tabController,
                              isScrollable: true,
                              indicatorColor: Colors.transparent,
                              labelColor: Colors.lightBlueAccent,
                              unselectedLabelColor:
                                  Colors.grey.withOpacity(0.5),
                              labelStyle: GoogleFonts.notoSans(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                              unselectedLabelStyle: GoogleFonts.notoSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                              tabs: tab,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          height: MediaQuery.of(context).size.height - 500.0,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              All(),
                              Software(),
                              Cyber(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
