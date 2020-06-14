// Todo: - implement study timer

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Books/book.dart';
import 'package:sastra_ebooks/Books/bookCategory.dart';
import 'package:sastra_ebooks/Components/Headings/heading.dart';
import 'package:sastra_ebooks/Components/bookListItem.dart';
import 'package:sastra_ebooks/Components/studyTimeBanner.dart';
import 'package:sastra_ebooks/Components/textFields/bookSearchTextField.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';

import 'searchBooks.dart';

final Color backgroundColor = Colors.white;

class Home extends StatefulWidget {
  static const String id = '/home';

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
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
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
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
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
                onTapDown: (_) => Navigator.pushNamed(context, SearchBooks.id),
                child: AbsorbPointer(
                  child: BookSearchTextField(),
                ),
              ),

              SizedBox(height: 30.0),

              ///--- Study Time Banner ---///
              StudyTimeBanner(
                studyTime: 22,
              ),

              SizedBox(height: 30.0),

              ///--- TabBar ---/
              TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelColor: Colors.lightBlueAccent,
                unselectedLabelColor: kLightGrey,
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
