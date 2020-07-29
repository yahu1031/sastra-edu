/*
 * Name: pdf
 * Use:
 * TODO:    - Add Use of this file
            - clean up
 */

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/outlineListItem.dart';
import 'package:sastra_ebooks/components/pdfViewBottomBar.dart';
import 'package:sastra_ebooks/misc/bookmarks.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';

import 'book.dart';

class PdfViewerPage extends StatefulWidget {
  final Book book;

  const PdfViewerPage(this.book);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  int _totalPages = 0, _currentPage = 0;

  bool _isLoading = true,
      _showOverlay = true,
      pageBookmarked = false,
      isFavorite = false;

  File _bookPdf;

  PDFViewController _pdfViewController;

  List<Widget> bookOutline = [];

  List outline = [
    {
      "page": 1,
      "title": "Cover",
    },
    {
      "page": 24,
      "title": "Chapter 0 - Guide for Readers and Instructors",
      "subs": [
        {"page": 25, "title": "0.1 - Outline of this Book"},
        {"page": 26, "title": "0.2 - A Roadmap for Readers and Instructors"},
        {"page": 27, "title": "0.3 Internet and Web Resources"},
        {"page": 28, "title": "0.4 Standards"}
      ]
    },
    {
      "page": 30,
      "title": "Chapter 1 - Overview",
      "subs": [
        {"page": 32, "title": "1.1 Computer Security Concepts"},
        {"page": 37, "title": "1.2 The OSI Security Architecture"},
        {
          "page": 38,
          "title": "1.3 Security Attacks",
          "subs": [
            {"page": 38, "title": "1.3.1 Security Stuff"},
          ]
        },
        {"page": 40, "title": "1.4 Security Services"},
        {"page": 43, "title": "1.5 Security Mechanisms"},
        {"page": 45, "title": "1.6 A Model for Network Security"},
        {"page": 47, "title": "1.7 Recommended Reading"},
        {"page": 48, "title": "1.8 Key Terms, Review Questions, and Problems"}
      ]
    }
  ];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadPdf();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  loadPdf() async {
    _bookPdf = await DefaultCacheManager().getSingleFile(widget.book.url);

    setState(() {
      _isLoading = false;
    });
  }

  _loadOutline() {
    for (Map chapter in outline) {
      List<OutlineListItem> chapterSubs = [];

      if (chapter.containsKey('subs')) {
        for (Map subChapter in chapter['subs']) {
          List<OutlineListItem> subChapterSubs = [];

          if (subChapter.containsKey('subs')) {
            for (Map doubleSubChapter in subChapter['subs']) {
              subChapterSubs.add(
                OutlineListItem(
                  title: doubleSubChapter['title'],
                  page: doubleSubChapter['page'],
                  pdfViewController: _pdfViewController,
                ),
              );
            }
          }

          chapterSubs.add(
            OutlineListItem(
              title: subChapter['title'],
              page: subChapter['page'],
              pdfViewController: _pdfViewController,
              children: subChapterSubs.isNotEmpty ? subChapterSubs : null,
            ),
          );
//          chapterSubs.add(value)
        }
      }
      bookOutline.add(
        OutlineListItem(
          title: chapter['title'],
          page: chapter['page'],
          pdfViewController: _pdfViewController,
          children: chapterSubs.isNotEmpty ? chapterSubs : null,
        ),
      );
    }
    print(bookOutline);
    print('bookOutline');
  }

  @override
  Widget build(BuildContext context) {
    print(widget.book.url);
    return KeyboardSizeProvider(
      child: CustomScaffold(
        safeAreaTop: false,
        resizeToAvoidBottomPadding: false,
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  PDFView(
                    filePath: _bookPdf.path,
                    swipeHorizontal: true,
                    fitEachPage: true,
                    pageFling: true,
                    pageSnap: true,
                    onViewCreated: (PDFViewController pdfViewController) async {
                      _pdfViewController = pdfViewController;

                      int _totalPagesTemp =
                          await pdfViewController.getPageCount();
                      int _currentPageTemp =
                          await pdfViewController.getCurrentPage() + 1;
                      setState(() {
                        _totalPages = _totalPagesTemp;
                        _currentPage = _currentPageTemp;

                        List bookmarks = Bookmarks.map[widget.book.id];

                        if (bookmarks != null)
                          pageBookmarked = bookmarks.contains(_currentPage);
                        else
                          pageBookmarked = false;

                        isFavorite =
                            FavoriteBooks.list.contains(widget.book.id);
                      });
                    },
                    onPageChanged: (int currentPage, int totalPages) async {
                      setState(() {
                        _totalPages = totalPages;
                        _currentPage = currentPage + 1;

                        List bookmarks = Bookmarks.map[widget.book.id];

                        if (bookmarks != null)
                          pageBookmarked = bookmarks.contains(_currentPage);
                        else
                          pageBookmarked = false;
                      });
                    },
                  ),
                  AnimatedPositioned(
                    top: _showOverlay ? 0 : -80,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
//                    padding: EdgeInsets.only(top: 24),
                      child: CustomAppBar(
                        context,
                        backButton: true,
                        backButtonColor: CustomColors.darkColor,
                        isTranslucent: true,
                        title: Text(
                          widget.book.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Consumer<ScreenHeight>(
                    builder: (context, _res, child) {
                      print(_res.keyboardHeight);
                      return AnimatedPositioned(
                        bottom: _showOverlay ? _res.keyboardHeight : -56,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 0
//                          milliseconds: 500,
                            ),
                        child: PdfViewBottomBar(
                          onPageNumberSubmit: (String pageNumberString) {
                            int pageNumber = int.parse(pageNumberString) - 1;
                            _pdfViewController.setPage(pageNumber);
                            _textEditingController.clear();
                          },
                          textEditingController: _textEditingController,
                          totalPages: _totalPages,
                          currentPage: _currentPage,
                          bookId: widget.book.id,
                          pageBookmarked: pageBookmarked,
                          isFavorite: isFavorite,
                          onBookmarkPressed: () async {
                            if (pageBookmarked)
                              Bookmarks.remove(widget.book.id, _currentPage);
                            else if (!pageBookmarked)
                              Bookmarks.add(widget.book.id, _currentPage);
                            setState(() {
                              pageBookmarked = !pageBookmarked;
                            });
                          },
                          onFavoritePressed: () {
                            if (isFavorite)
                              FavoriteBooks.remove(widget.book.id);
                            else if (!isFavorite)
                              FavoriteBooks.add(widget.book.id);

                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          onOutlinePressed: () {
                            if (bookOutline.isEmpty) _loadOutline();

                            showBarModalBottomSheet(
                              context: context,
                              builder: (context, scrollController) {
                                return ScrollConfiguration(
                                  behavior: ScrollBehavior(),
                                  child: Material(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.padding),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: Dimensions.padding,
                                            ),
                                            ...bookOutline
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
//                            showModalBottomSheet(
//                              context: context,
//                              backgroundColor:
//                                  CustomColors.translucentLightColor,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.only(
//                                  topLeft: Radius.circular(
//                                      Dimensions.borderRadiusDouble),
//                                  topRight: Radius.circular(
//                                      Dimensions.borderRadiusDouble),
//                                ),
//                              ),
//                              builder: (context) {
//                                return Padding(
//                                  padding: EdgeInsets.symmetric(
//                                      horizontal: Dimensions.padding),
//                                  child: SingleChildScrollView(
//                                    child: Column(
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: bookOutline,
//                                    ),
//                                  ),
//                                );
//                              },
//                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
