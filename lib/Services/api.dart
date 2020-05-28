import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  final String url;

  ApiServiceProvider(this.url);

  Future<String> loadPDF() async {
    var response = await http.get(url);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
