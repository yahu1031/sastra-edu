/*
 Name: pdf
 Use:
 Todo:    - Add Use of this file
            - clean up
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/outlineListItem.dart';
import 'package:sastra_ebooks/components/pdfViewBottomBar.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/misc/bookmarks.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/downloadBook.dart';
import 'package:sastra_ebooks/misc/errors.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';
import 'package:sastra_ebooks/misc/strings.dart';

import 'book.dart';

enum PageInChapter {
  TRUE,
  SubChapter,
  FALSE,
}

class PdfViewerPage extends StatefulWidget {
  static const String id = '/pdf';

  final Book book;
  final int page;

  const PdfViewerPage({@required this.book, this.page});

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

  final _formKey = GlobalKey<FormState>();

  List<Widget> bookOutline = [];

//  List widget.book.outline = [
//    {
//      "page": 1,
//      "title": "Cover",
//    },
//    {
//      "page": 24,
//      "title": "Chapter 0 Guide for Readers and Instructors",
//      "subs": [
//        {"page": 25, "title": "0.1 widget.book.outline of this Book"},
//        {"page": 26, "title": "0.2 A Roadmap for Readers and Instructors"},
//        {"page": 27, "title": "0.3 Internet and Web Resources"},
//        {"page": 28, "title": "0.4 Standards"}
//      ]
//    },
//    {
//      "page": 30,
//      "title": "Chapter 1 Overview",
//      "subs": [
//        {"page": 32, "title": "1.1 Computer Security Concepts"},
//        {"page": 37, "title": "1.2 The OSI Security Architecture"},
//        {
//          "page": 38,
//          "title": "1.3 Security Attacks",
//          "subs": [
//            {"page": 38, "title": "1.3.1 Security Stuff"},
//          ]
//        },
//        {"page": 40, "title": "1.4 Security Services"},
//        {"page": 43, "title": "1.5 Security Mechanisms"},
//        {"page": 45, "title": "1.6 A Model for Network Security"},
//        {"page": 47, "title": "1.7 Recommended Reading"},
//        {"page": 48, "title": "1.8 Key Terms, Review Questions, and Problems"}
//      ]
//    },
//  ];

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

  void loadPdf() async {
    try {
      _bookPdf = await DownloadBook.get(widget.book);
    } on FileNotFoundError {
      _bookPdf = await DefaultCacheManager().getSingleFile(widget.book.url);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _onViewCreated(PDFViewController pdfViewController) async {
    _pdfViewController = pdfViewController;

    setState(() {
      isFavorite = FavoriteBooks.list.contains(widget.book.isbn);
    });
  }

  void _onPageChanged(int currentPage, int totalPages) async {
    setState(() {
      _totalPages = totalPages;
      _currentPage = currentPage + 1;

      List bookmarks = Bookmarks.map[widget.book.isbn];

      if (bookmarks != null) {
        pageBookmarked = false;

        for (Map bookmark in bookmarks) {
          if (bookmark['page'] == _currentPage) {
            pageBookmarked = true;
            break;
          }
        }
      } else
        pageBookmarked = false;
    });
  }

  void _onBookmarkPressed() async {
    if (pageBookmarked) {
      Bookmarks.remove(widget.book.isbn, _currentPage);
      setState(() {
        pageBookmarked = false;
      });
    } else if (!pageBookmarked) {
      await showBarModalBottomSheet(
          isDismissible: false,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.borderRadius,
          ),
          builder: (context) {
            String bookmarkName;
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 250,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 8,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomTextFormField(
                              onChanged: (String newString) {
                                bookmarkName = newString;
                                print(bookmarkName);
                              },
                              autovalidate: true,
                              validator: (String input) {
                                if (input.isEmpty) {
                                  return Strings.nameFieldEmptyString;
                                }
                                return null;
                              },
                              labelText: 'Bookmark Name',
                            ),
                            SizedBox(
                              height: Dimensions.smallPadding,
                            ),
                            RoundedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  String chapter;
                                  PageInChapter pageInChapter;

                                  OUTER:
                                  for (int i = 0;
                                      i < widget.book.outline.length;
                                      i++) {
                                    /// if loop reached last chapter or _currentPage lies between two chapters
                                    pageInChapter = _pageInChapter(
                                        i,
                                        widget.book.outline.length,
                                        widget.book.outline);

                                    if (pageInChapter == PageInChapter.TRUE) {
                                      chapter = widget.book.outline[i]['title'];
                                      break OUTER;
                                    } else if (pageInChapter ==
                                        PageInChapter.SubChapter) {
                                      for (int j = 0;
                                          j <
                                              widget.book.outline[i]['subs']
                                                  .length;
                                          j++) {
                                        /// if loop reached last subChapter or _currentPage lies between two subChapters
                                        pageInChapter = _pageInChapter(
                                          j,
                                          widget.book.outline[i]['subs'].length,
                                          widget.book.outline[i]['subs'],
                                        );

                                        if (pageInChapter ==
                                            PageInChapter.TRUE) {
                                          chapter = widget.book.outline[i]
                                              ['subs'][j]['title'];
                                          break OUTER;
                                        } else if (pageInChapter ==
                                            PageInChapter.SubChapter) {
                                          for (int k = 0;
                                              k <
                                                  widget
                                                      .book
                                                      .outline[i]['subs'][j]
                                                          ['subs']
                                                      .length;
                                              k++) {
                                            /// if _currentPage is part of doubleSubChapter k
                                            pageInChapter = _pageInChapter(
                                                k,
                                                widget
                                                    .book
                                                    .outline[i]['subs'][j]
                                                        ['subs']
                                                    .length,
                                                widget.book.outline[i]['subs']
                                                    [j]['subs']);

                                            if (pageInChapter ==
                                                PageInChapter.TRUE) {
                                              chapter = widget.book.outline[i]
                                                      ['subs'][j]['subs'][k]
                                                  ['title '];
                                              break OUTER;
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                  Bookmarks.add(widget.book.isbn, _currentPage,
                                      bookmarkName, chapter);
                                  setState(() {
                                    pageBookmarked = true;
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              labelText: 'Go!',
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  PageInChapter _pageInChapter(int i, outlineLength, List chapters) {
    if (i == outlineLength - 1 ||
        (_currentPage >= chapters[i]['page'] &&
            _currentPage < chapters[i + 1]['page'])) {
      if (chapters[i]['subs'] == null) {
        return PageInChapter.TRUE;
      }

      return PageInChapter.SubChapter;
    }
    return PageInChapter.FALSE;
  }

  void _onFavoritePressed() {
    if (isFavorite) {
      FavoriteBooks.remove(widget.book.isbn);
    } else if (!isFavorite) {
      FavoriteBooks.add(widget.book.isbn);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _onOutlinePressed() {
    if (bookOutline.isEmpty) _loadOutline();
    showBarModalBottomSheet(
        context: context,
        builder: (context) {
          return ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: Material(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.padding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
        });
  }

  void _loadOutline() {
    for (Map chapter in widget.book.outline) {
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
                  chapterType: ChapterType.doubleSub,
                  pdfViewController: _pdfViewController,
                ),
              );
            }
          }

          chapterSubs.add(
            OutlineListItem(
              title: subChapter['title'],
              page: subChapter['page'],
              chapterType: ChapterType.sub,
              pdfViewController: _pdfViewController,
              children: subChapterSubs.isNotEmpty ? subChapterSubs : null,
            ),
          );
        }
      }
      bookOutline.add(
        OutlineListItem(
          title: chapter['title'],
          page: chapter['page'],
          chapterType: ChapterType.main,
          pdfViewController: _pdfViewController,
          children: chapterSubs.isNotEmpty ? chapterSubs : null,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    defaultPage: widget.page - 1,
                    swipeHorizontal: true,
                    fitEachPage: true,
                    pageFling: true,
                    pageSnap: true,
                    onViewCreated: _onViewCreated,
                    onPageChanged: _onPageChanged,
                  ),
                  AnimatedPositioned(
                    top: _showOverlay ? 0 : -80,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: CustomAppBar(
                        context,
                        backButton: true,
                        backButtonColor: CustomColors.darkColor,
                        isTranslucent: true,
                        title: Text(
                          widget.book.title,
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
                          bookId: widget.book.isbn,
                          pageBookmarked: pageBookmarked,
                          isFavorite: isFavorite,
                          onBookmarkPressed: _onBookmarkPressed,
                          onFavoritePressed: _onFavoritePressed,
                          onOutlinePressed: _onOutlinePressed,
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
