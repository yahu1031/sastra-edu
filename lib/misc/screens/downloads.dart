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
import 'package:sastra_ebooks/listScreen.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/downloadBook.dart';

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
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      body: ListScreen(
        heading: Heading(
          text: 'Your',
          text2: 'Downloads',
          highlightText: ' .',
        ),
        placeholderString: 'downloads',
        isEmpty: DownloadBook.downloadedBooks.isEmpty,
        listItems: [
          for (String bookISBN in DownloadBook.downloadedBooks)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.padding),
              child: BookListItem(
                book: Book.bookInstancesMap[bookISBN],
                setStateParent: setState,
                isDownloadScreen: true,
              ),
            ),
        ],
      ),
    );
  }
}
