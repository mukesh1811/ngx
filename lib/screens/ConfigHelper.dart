import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getList(String key) async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Move the CSV file to the database directory
  String newCsvPath = join(appDir.path, "pos_config.csv");
}
