/*
 * Name: pdf
 * Use:
 * TODO:    - Add Use of this file
            - clean up
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:sastra_ebooks/components/buttons/iconButtons/floatingIconButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class PdfViewerPage extends StatefulWidget {
  final itemName;
  final url;

  const PdfViewerPage(this.itemName, this.url);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  int _totalPages = 0;
  int _currentPage = 1;
  PdfController pdfController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  void dispose() {
    super.dispose();
    pdfController.dispose();
  }

  loadPdf() async {
    final File bookPdf = await DefaultCacheManager().getSingleFile(widget.url);
    pdfController = PdfController(document: PdfDocument.openFile(bookPdf.path));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
        title: Text(
          widget.itemName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                PdfView(
                  controller: pdfController,
                  pageSnapping: true,
                  onDocumentLoaded: (_) {
                    setState(() {
                      _currentPage = 1;
                      _totalPages = pdfController.pagesCount;
                    });
                  },
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                    print(_currentPage);
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(Dimensions.padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: _currentPage > 1,
                        child: FloatingIconButton(
                          onPressed: () {
                            pdfController.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: Icons.keyboard_arrow_left,
                        ),
                      ),
                      Visibility(
                        visible: _currentPage + 1 < _totalPages,
                        child: FloatingIconButton(
                          onPressed: () {
                            pdfController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: Icons.keyboard_arrow_right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

//      PDF(
//        fitPolicy: FitPolicy.WIDTH,
//        pageFling: true, swipeHorizontal: true,
//        enableSwipe: true,
//        fitEachPage: true,
////        nightMode: true,
//        onError: (e) {
//          Dialogs.fetchDataError(context);
//        },
//        onRender: (_pages) {
//          setState(() {
//            _totalPages = _pages;
//          });
//        },
//        onViewCreated: (PDFViewController vc) {
//          _pdfViewController = vc;
//        },
//        onPageChanged: (int page, int total) {
//          setState(() {
//            _currentPage = page;
//          });
//          print(_currentPage);
//        },
//        onPageError: (page, e) {
//          print("error 121");
//        },
//      ).cachedFromUrl(widget.url),
//      floatingActionButton: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          _currentPage > 0
//              ? Padding(
//                  padding: const EdgeInsets.only(left: 32.0),
//                  child: FloatingActionButton.extended(
//                    backgroundColor: Colors.lightBlueAccent,
//                    label: Icon(
//                      Icons.keyboard_arrow_up,
//                      size: 30.0,
//                      color: Colors.white,
//                    ),
//                    onPressed: () {
//                      // _currentPage -= 1;
//                      _pdfViewController.setPage(_currentPage - 1);
//                    },
//                  ),
//                )
//              : Offstage(),
//          _currentPage + 1 < _totalPages
//              ? FloatingActionButton.extended(
//                  backgroundColor: Colors.lightBlueAccent,
//                  label: Icon(
//                    Icons.keyboard_arrow_down,
//                    size: 30.0,
//                    color: Colors.white,
//                  ),
//                  onPressed: () {
//                    _pdfViewController.setPage(_currentPage + 1);
//                  },
//                )
//              : Offstage(),
//        ],
//      ),
    );
  }
}
