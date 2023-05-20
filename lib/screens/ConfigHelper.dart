import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<List<String>?> getList(String key) async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Move the CSV file to the database directory
  String newCsvPath = join(appDir.path, "pos_config.csv");

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  var maplist = {for (var v in fields) v[0]: v.sublist(1)};

  print(maplist);

  if (maplist[key] == null) {
    return [""];
  } else {
    List result = [];

    for (var item in maplist[key]!) {
      if (!item.isEmpty) {
        result.add(item);
      }
    }

    print(result);
    return result.cast<String>();
  }
}
