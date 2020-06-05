import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Components/bookListItem.dart';
import 'package:sastra_ebooks/Components/bookSearchTextField.dart';
import 'package:sastra_ebooks/Components/searchTextField.dart';
import 'package:sastra_ebooks/Home/Books/bookCategory.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../Home/searchBooks.dart';
import '../Profile/profilePicture.dart';
import '../Services/user.dart';
import '../Services/dialogs.dart';
import '../Profile/profile.dart';
import '../Services/paths.dart';
import '../Services/auth.dart';
import 'Books/book.dart';

/* Todo: - add indicator in the menu which shows on which screen you are currently one. e.g. a colored background behind the home icon
         - only enable overscroll glow if the listview is actually big enough to be scrollable.
 */

final Color backgroundColor = Colors.white;

// ignore: must_be_immutable
class Home extends StatefulWidget {
  final BuildContext context;
  final data;
  Home(this.data, this.context);
  User user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool isCollapsed = true;
  TextEditingController _textEditingController = TextEditingController();

  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  final AuthServices _auth = AuthServices();
  final List<Tab> tabs = [];
  final List<Widget> tabItems = [];
  TabController tabController;

  void loadBookTabs() {
    for (BookCategory bookCategory in BookCategory.bookCategoryInstancesList) {
      final List<BookListItem> bookListItems = [];

      tabs.add(
        Tab(
          child: Text(bookCategory.name),
        ),
      );

      for (Book book in bookCategory.books) {
        bookListItems.add(
          BookListItem(
            book: book,
          ),
        );
      }
      tabItems.add(
        ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: bookListItems,
          ),
        ),
      );
    }

    tabController = new TabController(
        length: BookCategory.bookCategoryInstancesList.length, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    widget.user = Provider.of<User>(widget.context);

    loadBookTabs();

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    tabController.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: new AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
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
              if (isCollapsed) {
                setState(() {
                  isCollapsed = false;
                });
                _controller.forward();
              } else {
                setState(() {
                  isCollapsed = true;
                });
                _controller.reverse();
              }
            },
            icon: Icon(
              Icons.menu,
              color: kHighlightColor,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: <Widget>[
            dashboard(context),
            menu(context),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 230.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                    print('Profile');
                  },
                  child: Container(
                    width: 20 * 5.0,
                    height: 20 * 5.0,
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(100),
                      child: ProfilePicture(),
                    ),
                  ),
                ),
                SizedBox(height: 5 * 10.0),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(1 * 10.0),
                      child: IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          _controller.reverse();

                          setState(() {
                            isCollapsed = true;
                          });

                          print('Home');
                        },
                      ),
                    ),
                    SizedBox(height: 3 * 10.0),
                    Padding(
                      padding: EdgeInsets.all(1 * 10.0),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => Favorite()),
//                          );
                          Dialogs.serviceDialog(context);
                        },
                      ),
                    ),
                    SizedBox(height: 3 * 10.0),
                    Padding(
                      padding: EdgeInsets.all(1 * 10.0),
                      child: IconButton(
                        icon: Icon(Icons.bookmark_border),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => Bookmark()),
//                          );
                          Dialogs.serviceDialog(context);
                        },
                      ),
                    ),
                    SizedBox(height: 3 * 10.0),
                    Padding(
                      padding: EdgeInsets.all(1 * 10.0),
                      child: IconButton(
                        icon: Icon(Icons.chat_bubble_outline),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          Dialogs.codingDialog(context);
                        },
                      ),
                    ),
                    SizedBox(height: 3 * 10.0),
                    Padding(
                      padding: EdgeInsets.all(1 * 10.0),
                      child: IconButton(
                        icon: Icon(Icons.power_settings_new),
                        color: Colors.lightBlueAccent,
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Authenticate()));

                          print('Logged out');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    print(MediaQuery.of(context).size.height);
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : -0.09 * screenHeight,
      bottom: isCollapsed ? 0 : -0.05 * screenHeight,
      left: isCollapsed ? 0 : 0.2 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: IgnorePointer(
          ignoring: !isCollapsed,
          child: Material(
            animationDuration: duration,
            elevation: 8,
            color: backgroundColor,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTapDown: (_) =>
                          Navigator.pushNamed(context, SearchBooks.id),
                      child: AbsorbPointer(
                        child: BookSearchTextField(),
//                        Hero(
//                          tag: 'searchBooks',
//                          child: Material(
//                            child: Container(
//                              padding: EdgeInsets.only(left: 5.0),
//                              decoration: BoxDecoration(
//                                color: Colors.grey.withOpacity(0.1),
//                                borderRadius: BorderRadius.circular(10.0),
//                              ),
//                              child: TextField(
//                                controller: _textEditingController,
//                                textAlign: TextAlign.left,
//                                decoration: InputDecoration(
//                                  contentPadding: EdgeInsets.all(15.0),
//                                  hintText: 'Search for books',
//                                  hintStyle:
//                                      GoogleFonts.notoSans(fontSize: 14.0),
//                                  border: InputBorder.none,
//                                  fillColor: Colors.grey.withOpacity(0.5),
//                                  prefixIcon: Icon(
//                                    Icons.search,
//                                    color: Colors.grey,
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 150.0,
                          maxWidth: 700.0,
                          minWidth: 250.0,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Study time today',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.0,
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    SizedBox(height: 20.0),

                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: '10',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '  minutes',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]),
                                    ),
//                                  Text(
//                                    'minutes',
//                                    style: GoogleFonts.montserrat(
//                                      fontSize: 15.0,
//                                      color: Colors.white.withOpacity(0.7),
//                                      fontWeight: FontWeight.w600,
//                                    ),
//                                  ),
                                  ],
                                ),
                              ),
                            ),
//                          Flex(direction: Axis.horizontal, children: [
//                            Container(
//                              decoration: BoxDecoration(),
//                            ),
//                          ]),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TabBar(
                      controller: tabController,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.lightBlueAccent,
                      unselectedLabelColor: Colors.grey.withOpacity(0.5),
                      labelStyle: GoogleFonts.notoSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                      unselectedLabelStyle: GoogleFonts.notoSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                      tabs: tabs,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: tabItems,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
