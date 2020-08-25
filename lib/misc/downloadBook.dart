import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/misc/errors.dart';

class DownloadBook {
  static Future<File> get(Book book) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books/${book.id}.pdf';
    if (await File(filePath).exists()) {
      return File(filePath);
    } else {
      throw const FileNotFoundError();
    }
  }

  static Future<void> download(Book book) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books/${book.id}.pdf';
    final File _bookPdf = await DefaultCacheManager().getSingleFile(book.url);
    _bookPdf.rename(filePath);
  }

  static Future<void> remove(Book book) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/books/${book.id}.pdf';
    await File(filePath).delete();
  }
}
