/*
 * Name: pdf
 * Use:
 * TODO:    - Add Use of this file
            - clean up
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/components/buttons/iconButtons/floatingIconButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/pdfViewBottomBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/misc/bookmarks.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
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
//    pdfController = PdfController(document: PdfDocument.openFile(bookPdf.path));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.book.url);
    return KeyboardSizeProvider(
      child: CustomScaffold(
        safeAreaTop: false,
        resizeToAvoidBottomPadding: false,
//        appBar: CustomAppBar(
//          context,
//          backButton: true,
//          backButtonColor: CustomColors.darkColor,
//          isTranslucent: true,
//          title: Text(
//            widget.book.name,
//            style: TextStyle(color: Colors.black),
//          ),
//        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
//                  GestureRecognizer
//                  TapGestureRecognizer
                  PDFView(
//                      nightMode: true,
                    filePath: _bookPdf.path,
                    fitPolicy: FitPolicy.WIDTH,
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
                          onBookmarkPressed: () {
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
