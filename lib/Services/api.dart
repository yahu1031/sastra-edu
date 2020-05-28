import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  // ignore: non_constant_identifier_names
//  static final String BASE_URL = widget.data[index]["Link"];
//  static final String BASE_URL = "http://seu1.org/files/level4/IT-242/Software%20Engineering%20_%207th%20Edition.pdf";
  static final String BASE_URL = "https://www.tutorialspoint.com/software_engineering/software_engineering_tutorial.pdf";

  static Future<String> loadPDF() async {
    var response = await http.get(BASE_URL);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
