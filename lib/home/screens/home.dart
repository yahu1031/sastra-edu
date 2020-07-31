/*
 * Name: home
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/bookCategory.dart';
import 'package:sastra_ebooks/components/appBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/components/infoBanner.dart';
import 'package:sastra_ebooks/components/textFields/bookSearchTextField.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/profile/settingScreens/downloadsPayment.dart';

import 'searchBooks.dart';

final Color backgroundColor = Colors.white;

class Home extends StatefulWidget {
  static const String id = '/home';
  final appBarTitle = AppBarTitle('M-Book Edu');

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController tabController;
  final List<Tab> tabs = [];
  final List<Widget> tabItems = [];

  @override
  void initState() {
    super.initState();

    loadBookTabs();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void loadBookTabs() {
    for (BookCategory bookCategory in BookCategory.bookCategoryInstancesList) {
      final List<Widget> bookListItems = [];

      tabs.add(
        Tab(
          child: Text(bookCategory.name),
        ),
      );

      for (Book book in bookCategory.books) {
        bookListItems.add(
          Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.padding,
              right: Dimensions.padding,
              bottom: Dimensions.padding,
            ),
            child: BookListItem(
              book: book,
            ),
          ),
        );
      }

      tabItems.add(
        ListView(
          scrollDirection: Axis.vertical,
          children: bookListItems,
        ),
      );
    }

    tabController = new TabController(
        length: BookCategory.bookCategoryInstancesList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ///--- Heading ---///
              Heading(
                text: 'Your',
                text2: 'Bookshelf',
                highlightText: ' .',
              ),

              SizedBox(height: 20.0),

              ///--- BookSearchTextField Dummy ---///
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SearchBooks.id),
                child: AbsorbPointer(
                  child: BookSearchTextField(),
                ),
              ),

              SizedBox(height: 20),

              ///--- Study Time Banner ---///
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DownloadPayment.id);
                },
                child: InfoBanner(
                  message: 'This app is a WIP :)',
                ),
              ),

              SizedBox(height: 10),

              ///--- TabBar ---///
              TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelColor: Colors.lightBlueAccent,
                unselectedLabelColor: CustomColors.lightGrey,
                labelStyle: tabTitleTextStyle,
                tabs: tabs,
              ),
            ],
          ),
        ),

        ///--- Tabs ---///
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabItems,
          ),
        ),
      ],
    );
  }
}
