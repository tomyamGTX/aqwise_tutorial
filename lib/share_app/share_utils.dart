import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

fileFromImageUrl(String url, String userName) async {
  final response = await http.get(
    Uri.parse(url),
  );

  final documentDirectory = await getApplicationDocumentsDirectory();

  var randomNumber = Random();

  final file = File(
    join(
      documentDirectory.path,
      "${randomNumber.nextInt(100)}_$userName.png",
    ),
  );

  file.writeAsBytesSync(response.bodyBytes);

  return XFile(file.path);
}

String join(String path, String s) {
  return '$path/$s';
}
