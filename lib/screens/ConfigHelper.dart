import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String consignor_name_key = "Consignor Code";
final String customer_name_key = "Customer Code";
final String item_name_key = "Item Code";

Future<List<String>?> getConsignorList() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "consignor_name.csv");
  String key = consignor_name_key;

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];
  int reqColIdx = headers.indexOf(key);
  List result = [];

  for (var line in fields.sublist(1)) {
    result.add(line[reqColIdx].toString());
  }

  print(result);
  return result.cast<String>();
}

Future<List<String>?> getCustomerList() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "customer_name.csv");
  String key = customer_name_key;

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];
  int reqColIdx = headers.indexOf(key);
  List result = [];

  for (var line in fields.sublist(1)) {
    result.add(line[reqColIdx].toString());
  }

  print(result);
  return result.cast<String>();
}

Future<List<String>?> getItemList() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "item_name.csv");
  String key = item_name_key;

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];
  int reqColIdx = headers.indexOf(key);
  List result = [];

  for (var line in fields.sublist(1)) {
    result.add(line[reqColIdx].toString());
  }

  print(result);
  return result.cast<String>();
}

Future<List<String>?> getList(String key) async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "pos_config.csv");
  String key = "ItemName";

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  var map_list = {for (var v in fields) v[0]: v.sublist(1)};

  print(map_list);

  if (map_list[key] == null) {
    return [""];
  } else {
    List result = [];

    for (var item in map_list[key]!) {
      if (!item.isEmpty) {
        result.add(item);
      }
    }

    print(result);
    return result.cast<String>();
  }
}
