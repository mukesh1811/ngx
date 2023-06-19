import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final String consignor_id_key = "Consignor Code";
final String consignor_name_key = "Consignor Name";
final String consignor_location_key = "Location";
final List<String> consignor_mandatory_columns = [consignor_id_key,consignor_name_key,consignor_location_key];

final String customer_id_key = "Customer Code";
final String customer_name_key = "Customer Name";
final String customer_location_key = "Location";
final String customer_balance_key = "ClosingBalance";
final List<String> customer_mandatory_columns = [customer_id_key,customer_name_key,customer_location_key,customer_balance_key];

final String item_name_key = "Item Name";
final List<String> item_mandatory_columns = [item_name_key];

Future<List<String>?> getConsignorList() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "consignor_name.csv");

  String name_key = consignor_name_key;
  String location_key = consignor_location_key;

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];

  int nameColIdx = headers.indexOf(name_key);
  int locColIdx = headers.indexOf(location_key);

  List result = [];

  for (var line in fields.sublist(1)) {
    String consName = line[nameColIdx].toString();
    String consLoc = line[locColIdx].toString();

    String displayValue = consName + " -- " + consLoc;

    result.add(displayValue);
  }

  return result.cast<String>();
}

Future<List<String>?> getCustomerList() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "customer_name.csv");

  String name_key = customer_name_key;
  String location_key = customer_location_key;

  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];

  int nameColIdx = headers.indexOf(name_key);
  int locColIdx = headers.indexOf(location_key);

  List result = [];

  for (var line in fields.sublist(1)) {
    String custName = line[nameColIdx].toString();
    String custLoc = line[locColIdx].toString();

    String displayValue = custName + " -- " + custLoc;

    result.add(displayValue);
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

Future<int> getCustomerBalance(String custumer_lookup_value) async
{

  String custName = custumer_lookup_value.split("--")[0].trim();
  String custLoc = custumer_lookup_value.split("--")[1].trim();

  Directory appDir = await getApplicationDocumentsDirectory();

  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "customer_name.csv");


  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];

  int nameColIdx = headers.indexOf(customer_name_key);
  int locColIdx = headers.indexOf(customer_location_key);

  int balanceColIdx = headers.indexOf(customer_balance_key);

  int balance = 0;

  for (var line in fields.sublist(1)) {

    if((line[nameColIdx] == custName) && line[locColIdx] == custLoc)
      {
        balance = line[balanceColIdx];
      }

  }

  return balance;
}


Future<String> getCustomerID(String custumer_lookup_value) async
{

  String custName = custumer_lookup_value.split("--")[0].trim();
  String custLoc = custumer_lookup_value.split("--")[1].trim();

  Directory appDir = await getApplicationDocumentsDirectory();

  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "customer_name.csv");


  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];

  int nameColIdx = headers.indexOf(customer_name_key);
  int locColIdx = headers.indexOf(customer_location_key);

  int custIdColIdx = headers.indexOf(customer_id_key);

  String custId = "";

  for (var line in fields.sublist(1)) {

    if((line[nameColIdx] == custName) && line[locColIdx] == custLoc)
    {
      custId = line[custIdColIdx];
      //return custId;
    }

  }


  print("Customer ID for $custumer_lookup_value is $custId");
  return custId;
}

Future<String> getConsignorID(String consignor_lookup_value) async
{

  String consignorName = consignor_lookup_value.split("--")[0].trim();
  String consignorLoc = consignor_lookup_value.split("--")[1].trim();

  Directory appDir = await getApplicationDocumentsDirectory();

  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "consignor_name.csv");


  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];

  int nameColIdx = headers.indexOf(consignor_name_key);
  int locColIdx = headers.indexOf(consignor_location_key);

  int consignorIdColIdx = headers.indexOf(consignor_id_key);

  String consignorId = "";

  for (var line in fields.sublist(1)) {

    if((line[nameColIdx] == consignorName) && line[locColIdx] == consignorLoc)
    {
      consignorId = line[consignorIdColIdx];
      //return consignorId;
    }

  }


  print("Consignor ID for $consignor_lookup_value is $consignorId");
  return consignorId;
}












Future<String> getCustomerDisplayValue(String custId) async
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

  int custIdColIdx = headers.indexOf(customer_id_key);

  int nameColIdx = headers.indexOf(customer_name_key);
  int locColIdx = headers.indexOf(customer_location_key);

  String custDisplayName = "";

  for (var line in fields.sublist(1)) {

    if(line[custIdColIdx] == custId)
    {
      String custName = line[nameColIdx].toString();
      String custLoc = line[locColIdx].toString();

      custDisplayName = custName + " -- " + custLoc;

      //return custDisplayName;
    }

  }


  print("Customer Display Name for $custId is $custDisplayName");
  return custDisplayName;
}

Future<String> getConsignorDisplayValue(String consignorId) async
{

  Directory appDir = await getApplicationDocumentsDirectory();

  // Read the CSV file from the database directory
  String newCsvPath = join(appDir.path, "consignor_name.csv");


  final input = File(newCsvPath).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(const CsvToListConverter())
      .toList();

  List headers = fields[0];

  int consignorIdColIdx = headers.indexOf(consignor_id_key);

  int nameColIdx = headers.indexOf(consignor_name_key);
  int locColIdx = headers.indexOf(consignor_location_key);

  String consignorDisplayName = "";

  for (var line in fields.sublist(1)) {

    if(line[consignorIdColIdx] == consignorId)
    {
      String consignorName = line[nameColIdx].toString();
      String consignorLoc = line[locColIdx].toString();

      consignorDisplayName = consignorName + " -- " + consignorLoc;

      //return consignorDisplayName;
    }

  }


  print("Consignor Display Name for $consignorId is $consignorDisplayName");
  return consignorDisplayName;
}