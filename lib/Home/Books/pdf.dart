import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../Services/api.dart';

class PdfViewerPage extends StatefulWidget {
  final itemName;
  final url;

  const PdfViewerPage(this.itemName, this.url);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String localPath;
  int _totalPages = 1;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  void initState() {
    super.initState();

    ApiServiceProvider(widget.url).loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          widget.itemName,
          style:
          TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      body: localPath != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            children: <Widget>[
              PDFView(
                enableSwipe: true,
                pageSnap: true,
                swipeHorizontal: true,
                filePath: localPath,
                onError: (e) {
                  print(e);
                },
                onRender: (_pages) {
                  setState(() {
                    _totalPages = _pages;
                    pdfReady = true;
                  });
                },
                onViewCreated: (PDFViewController vc) {
                  _pdfViewController = vc;
                },
                onPageChanged: (int page, int total) {
                  setState(() {
                    _currentPage = page;
                  });
                  print(_currentPage);
                },
                onPageError: (page, e) {},
              ),
            ],
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _currentPage > 0
              ? Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.lightBlueAccent,
              label: Icon(
                Icons.arrow_back_ios,
                size: 10.0,
                color: Colors.white,
              ),
              onPressed: () {
                // _currentPage -= 1;
                _pdfViewController.setPage(_currentPage - 1);
              },
            ),
          )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
            backgroundColor: Colors.lightBlueAccent,
            label: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewController.setPage(_currentPage + 1);
            },
          )
              : Offstage(),
        ],
      ),
    );
  }
}