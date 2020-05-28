import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  final data;
  ApiServiceProvider(this.data);

  static final String baseURL =
      "https://www.tutorialspoint.com/software_engineering/software_engineering_tutorial.pdf";

  static Future<String> loadPDF() async {
    var response = await http.get(baseURL);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
