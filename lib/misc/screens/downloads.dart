import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sastra_ebooks/components/emptyListPlaceholder.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

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
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      body: Stack(
        children: [
          if (files.isEmpty) EmptyListPlaceholder('downloads'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
                child: Heading(
                  text: 'Your',
                  text2: 'Downloads',
                  highlightText: ' .',
                ),
              ),
              SizedBox(
                height: Dimensions.largePadding,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, i) {
                      String filename = basename(files[i].path);
                      String bookId =
                          filename.substring(0, filename.indexOf('.pdf'));

                      return Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.padding,
                          right: Dimensions.padding,
                          bottom: Dimensions.padding,
                        ),
                        child:
                            BookListItem(book: Book.bookInstancesMap[bookId]),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
