import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Downloads extends StatefulWidget {
  static const String id = '/downloads';
  const Downloads({Key key}) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  //Declare Globaly
  String directory;
  List<FileSystemEntity> files = [];
  bool filesLoaded = false;
  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      files = io.Directory("$directory/books/").listSync();
      print(files);
      filesLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, i) {
            String filename = basename(files[i].path);
            String bookId = filename.substring(0, filename.indexOf('.pdf'));

            return BookListItem(book: Book.bookInstancesMap[bookId]);
          }),
    );
  }
}
