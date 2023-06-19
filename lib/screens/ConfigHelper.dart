import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String consignor_name_key = "Consignor Code";
final String customer_name_key = "Customer Code";
final String customer_balance_key = "ClosingBalance";
final String item_name_key = "Item Name";

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

  return result.cast<String>();
}

Future<int> getCustomerBalance(String custumer_lookup_id) async
{
  Directory appDir = await getApplicationDocumentsDirectory();

  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "customer_name.csv");


  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];
  int lookupColIdx = headers.indexOf(customer_name_key);
  int balanceColIdx = headers.indexOf(customer_balance_key);

  int balance = 0;

  for (var line in fields.sublist(1)) {
    if(line[lookupColIdx] == custumer_lookup_id)
      {
        balance = line[balanceColIdx];
      }
  }

  return balance;
}