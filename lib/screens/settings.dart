import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
//import 'package:excel/excel.dart' as xl;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ngx/screens/DB_Helper.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'ConfigHelper.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Future<int> _importConsignor() async {
    // Open file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String csvFilePath = file.path!;

      // Read CSV file
      final input = File(csvFilePath).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();

      print(fields[0]);

      if(!fields[0].contains(consignor_name_key))
      {
        return -1;
      }

      // Get database directory path
      Directory appDir = await getApplicationDocumentsDirectory();
      // Move the CSV file to the database directory
      File csvFile = File(csvFilePath);
      String newCsvPath = join(appDir.path, 'consignor_name.csv');

      print(newCsvPath);
      await csvFile.rename(newCsvPath);

      return 1;
    }
    return 0;
  }

  Future<int> _importItem() async {
    // Open file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String csvFilePath = file.path!;

      // Read CSV file
      final input = File(csvFilePath).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();

      print(fields[0]);

      if(!fields[0].contains(item_name_key))
      {
        return -1;
      }

      // Get database directory path
      Directory appDir = await getApplicationDocumentsDirectory();
      // Move the CSV file to the database directory
      File csvFile = File(csvFilePath);
      String newCsvPath = join(appDir.path, 'item_name.csv');

      print(newCsvPath);
      await csvFile.rename(newCsvPath);

      return 1;
    }
    return 0;
  }

  Future<int> _importCustomer() async {
    // Open file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String csvFilePath = file.path!;

      // Read CSV file
      final input = File(csvFilePath).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();

      print(fields[0]);

      if(!fields[0].contains(customer_name_key))
        {
          return -1;
        }

      if(!fields[0].contains(customer_balance_key))
      {
        return -2;
      }

      int balanceColIdx = fields[0].indexOf(customer_balance_key);
      for (var line in fields.sublist(1)) {
        var balance = line[balanceColIdx];
        if(balance is int)
          {

          }
        else
          {
            return -3;
          }
      }

      // Get database directory path
      Directory appDir = await getApplicationDocumentsDirectory();
      // Move the CSV file to the database directory
      File csvFile = File(csvFilePath);
      String newCsvPath = join(appDir.path, 'customer_name.csv');

      print(newCsvPath);
      await csvFile.rename(newCsvPath);

      return 1;
    }
    return 0;
  }

  Future<int> exportDatabaseToCsvFiles() async
  {


      // Get the database path
      final String databasePath = join(await getDatabasesPath(), 'pos.db');

      // Open the database
      final Database database = await openDatabase(databasePath);

      // Get the list of table names
      final List<Map<String, dynamic>> tables =
      await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

      // Get the directory for saving the CSV files
      final String directory = "/storage/emulated/0/Documents/db_exports";

      if (await Directory(directory).exists()) {
        print('Specified folder exists');
      } else {
        print('Specified folder does not exist. Hence creating..');
        await Directory(directory).create(recursive: true);
        print('Folder created successfully');
      }

      var status = await Permission.storage.status;
      print('Status Before: $status');
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      print('Status After: $status');

      // Loop through each table
      for (final Map<String, dynamic> table in tables) {

          final String tableName = table['name'];

          if (!['android_metadata','users'].contains(tableName)) {

          final File csvFile = File('${directory}/$tableName.csv');

          print(tableName);
          print(csvFile);

          final csvData = <List<dynamic>>[];
          final List<Map<String, dynamic>> rows = await database.query(tableName);


          csvData.add(rows[0].keys.toList());

          for (final Map<String, dynamic> row in rows) {
            csvData.add(row.values.toList());
          }

          final csvString = ListToCsvConverter().convert(csvData);


          await csvFile.writeAsString(csvString, flush: true);

          print('CSV file saved at: $csvFile');
        }
      }

      // Close the database
      await database.close();

    print("Function called");
    return 1;
  }

  // ##############
  // this commented function can export the db to a single .xlsx file with each sheet containing data of each table
  // commented but not deleted in case if needed in future
  // ##############
  // Future<int> exportDatabaseToExcel() async {
  //   // Get the database path
  //   final String databasePath = join(await getDatabasesPath(), 'pos.db');
  //   print('databasePath: $databasePath');
  //
  //   // Open the database
  //   final Database database = await openDatabase(databasePath);
  //
  //   // Get the list of table names
  //   final List<Map<String, dynamic>> tables = await database
  //       .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
  //
  //   // Create a new Excel workbook
  //   final xl.Excel excel = xl.Excel.createExcel();
  //
  //   // Loop through each table
  //   for (final Map<String, dynamic> table in tables) {
  //     final String tableName = table['name'];
  //     print('Table: $tableName');
  //
  //     if (tableName != 'android_metadata') {
  //       // Query the table and retrieve all rows
  //       final List<Map<String, dynamic>> rows = await database.query(tableName);
  //
  //       // Create a new Excel sheet for the table
  //       final xl.Sheet sheetObject = excel[tableName];
  //       excel.link(tableName, sheetObject);
  //
  //       // Add column headers to the sheet
  //       final List<String> columnHeaders =
  //           rows.isNotEmpty ? rows[0].keys.toList() : [];
  //
  //       sheetObject.insertRowIterables(columnHeaders, 0);
  //
  //       // Add rows to the sheet
  //       for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
  //         final row = rows[rowIndex];
  //
  //         sheetObject.insertRowIterables(row.values.toList(), rowIndex + 1);
  //       }
  //     }
  //
  //     // Add the sheet to the workbook
  //     //excel.sheets.add(sheetObject);
  //   }
  //
  //   var status = await Permission.storage.status;
  //   print('Status Before: $status');
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   print('Status After: $status');
  //
  //   // Save the Excel file
  //   var fileBytes = excel.save();
  //
  //   var excelfullname = '/storage/emulated/0/Documents/pos.xlsx';
  //
  //   File(excelfullname)
  //     ..createSync(recursive: true)
  //     ..writeAsBytesSync(fileBytes!);
  //
  //   // Save the Excel file
  //   // const String excelPath = '/storage/emulated/0/Documents/pos.xlsx';
  //   // await excel.save(fileName: excelPath);
  //
  //   // Close the database
  //   await database.close();
  //
  //   return 1;
  // }

  TextEditingController _pwd = TextEditingController();

  Future<String> login_validate() async {
    String login_status = await DB_Helper.auth("admin", _pwd.text);
    return login_status;
  }

  void clearTextFields() {
    _pwd.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image(
          image: AssetImage("images/veg1.jpg"),
          colorBlendMode: BlendMode.softLight,
          fit: BoxFit.fill,
          opacity: AlwaysStoppedAnimation(.2),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: SafeArea(
                  child: Center(
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.deepOrange,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Retail Management System",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Settings",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Table(
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                    // Allows to add a border decoration around your table
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Load Consignor Name",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange)),
                          child: Center(
                            child: IconButton(
                              onPressed: () async {
                                int res = await _importConsignor();
                                String resText = "";
                                if (res == 1) {
                                  resText =
                                      'Consignor Name updated successfully!';
                                }
                                else if (res == -1)
                                {
                                  resText = "Key $consignor_name_key is missing. Update failed";
                                }
                                else {
                                  resText = 'Consignor Name not updated';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(resText)));
                              },
                              icon: Icon(
                                Icons.file_upload,
                                color: Colors.deepOrange,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Load Customer Name",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange)),
                          child: IconButton(
                            onPressed: () async {
                              int res = await _importCustomer();
                              String resText = "";

                              if (res == 1) {
                                resText = 'Customer Name updated successfully!';
                              }
                              else if (res == -1)
                                {
                                  resText = "Key $customer_name_key is missing. Update failed";
                                }

                              else if (res == -2)
                              {
                                resText = "Key $customer_balance_key is missing. Update failed";
                              }
                              else if (res == -3)
                              {
                                resText = "Invalid value in customer balance. Update failed";
                              }
                              else {
                                resText = 'Customer Name not updated';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(resText)));
                            },
                            icon: Icon(
                              Icons.file_upload,
                              color: Colors.deepOrange,
                              size: 23,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Load Item Name",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange)),
                          child: IconButton(
                            onPressed: () async {
                              int res = await _importItem();
                              String resText = "";
                              if (res == 1) {
                                resText = 'Item Name updated successfully!';
                              }
                              else if (res == -1)
                              {
                                resText = "Key $item_name_key is missing. Update failed";
                              }
                              else {
                                resText = 'Item Name not updated';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(resText)));
                            },
                            icon: Icon(
                              Icons.file_upload,
                              color: Colors.deepOrange,
                              size: 23,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Export DB To Excel",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange)),
                          child: IconButton(
                            onPressed: () async {
                              //int res = await exportDatabaseToExcel();
                              int res = await exportDatabaseToCsvFiles();
                              String resText = "";
                              if (res == 1) {
                                resText = 'Database exported successfully!';
                              } else {
                                resText = 'Database not exported';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(resText)));
                            },
                            icon: Icon(
                              Icons.download,
                              color: Colors.deepOrange,
                              size: 23,
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Wipe Entries",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange)),
                          child: IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Wipe the entries'),
                                  content: TextField(
                                    controller: _pwd,
                                    obscureText: true,
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24),
                                    onTapOutside: (event) {},

                                    //autofocus: true,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1.0)),
                                        labelText: "Enter Password",
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        bool login_status =
                                            _pwd.text == "renuka";

                                        if (login_status) {
                                          clearTextFields();
                                          await exportDatabaseToCsvFiles();
                                          await DB_Helper.deleteDB();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "DB exported and wiped successfully")));

                                          Navigator.pop(context, 'Cancel');
                                        } else {
                                          clearTextFields();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Password incorrect")));
                                        }
                                      },
                                      child: const Text('Wipe Entries'),
                                    ),
                                  ],
                                ),
                              );
                              // await exportDatabaseToExcel();
                              // await DB_Helper.deleteDB();
                              //
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //         content: Text("DB exported and wiped")));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                              size: 23,
                            ),
                          ),
                        ),
                      ]),
                    ]),
              ),

              // Center(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Update config csv",
              //         style: TextStyle(
              //             color: Colors.deepOrange, fontSize: 22),
              //       ),
              //       Container(
              //         margin: const EdgeInsets.all(15.0),
              //         padding: const EdgeInsets.all(3.0),
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.deepOrange)),
              //         child: IconButton(
              //           onPressed: () async {
              //             int res = await _importCsv();
              //             String resText = "";
              //             if (res == 1) {
              //               resText = 'Config updated successfully!';
              //             } else {
              //               resText = 'Config not updated';
              //             }
              //             ScaffoldMessenger.of(context).showSnackBar(
              //                 SnackBar(content: Text(resText)));
              //           },
              //           icon: Icon(
              //             Icons.file_upload,
              //             color: Colors.deepOrange,
              //             size: 32,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange)),
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        icon: Icon(
                          Icons.home_rounded,
                          color: Colors.deepOrange,
                          size: 23,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ))))
    ]);
  }
}
