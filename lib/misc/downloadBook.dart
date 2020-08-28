import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/misc/errors.dart';

class DownloadBook {
  static List<String> _downloadedBooks = [];
  static Future<File> get(Book book) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books/${book.isbn}.pdf';
    if (await File(filePath).exists()) {
      return File(filePath);
    } else {
      throw const FileNotFoundError();
    }
  }

  static void init() async {
    final directory = await getApplicationDocumentsDirectory();

    List<FileSystemEntity> files =
        (Directory("${directory.path}/books/").listSync());

    for (FileSystemEntity file in files) {
      _downloadedBooks.add(basename(file.path).split(".")?.first);
    }
  }

  static bool contains(String isbn) {
    return _downloadedBooks.contains(isbn);
  }

  static Future<void> download(Book book) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books/${book.isbn}.pdf';
    final File _bookPdf = await DefaultCacheManager().getSingleFile(book.url);
    _bookPdf.rename(filePath);
    _downloadedBooks.add(book.isbn);
  }

  static Future<void> remove(Book book) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books/${book.isbn}.pdf';
    await File(filePath).delete();
    _downloadedBooks.remove(book.isbn);
  }

  static List<String> get downloadedBooks => _downloadedBooks;
}
