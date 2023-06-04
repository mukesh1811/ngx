import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as xl;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ngx/screens/DB_Helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<int> _importCsv() async {
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

      print(fields);

      // Get database directory path
      Directory appDir = await getApplicationDocumentsDirectory();
      // Move the CSV file to the database directory
      File csvFile = File(csvFilePath);
      String newCsvPath = join(appDir.path, 'pos_config.csv');
      print(newCsvPath);
      await csvFile.rename(newCsvPath);

      return 1;
    }
    return 0;
  }

  Future<int> exportDatabaseToExcel() async {
    // Get the database path
    final String databasePath = join(await getDatabasesPath(), 'pos.db');
    print('databasePath: $databasePath');

    // Open the database
    final Database database = await openDatabase(databasePath);

    // Get the list of table names
    final List<Map<String, dynamic>> tables = await database
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

    // Create a new Excel workbook
    final xl.Excel excel = xl.Excel.createExcel();

    // Loop through each table
    for (final Map<String, dynamic> table in tables) {
      final String tableName = table['name'];
      print('Table: $tableName');

      if (tableName != 'android_metadata') {
        // Query the table and retrieve all rows
        final List<Map<String, dynamic>> rows = await database.query(tableName);

        // Create a new Excel sheet for the table
        final xl.Sheet sheetObject = excel[tableName];
        excel.link(tableName, sheetObject);

        // Add column headers to the sheet
        final List<String> columnHeaders =
            rows.isNotEmpty ? rows[0].keys.toList() : [];

        sheetObject.insertRowIterables(columnHeaders, 0);

        // Add rows to the sheet
        for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
          final row = rows[rowIndex];

          sheetObject.insertRowIterables(row.values.toList(), rowIndex + 1);
        }
      }

      // Add the sheet to the workbook
      //excel.sheets.add(sheetObject);
    }

    var status = await Permission.storage.status;
    print('Status Before: $status');
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    print('Status After: $status');

    // Save the Excel file
    var fileBytes = excel.save();

    var excelfullname = '/storage/emulated/0/Documents/pos.xlsx';

    File(excelfullname)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    // Save the Excel file
    // const String excelPath = '/storage/emulated/0/Documents/pos.xlsx';
    // await excel.save(fileName: excelPath);

    // Close the database
    await database.close();

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image(
          image: AssetImage("images/veg1.jpg"),
          colorBlendMode: BlendMode.softLight,
          fit: BoxFit.fill,
          opacity: AlwaysStoppedAnimation(.5),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
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
                    SizedBox(height: 100),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Update config csv",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange)),
                            child: IconButton(
                              onPressed: () async {
                                int res = await _importCsv();
                                String resText = "";
                                if (res == 1) {
                                  resText = 'Config updated successfully!';
                                } else {
                                  resText = 'Config not updated';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(resText)));
                              },
                              icon: Icon(
                                Icons.file_upload,
                                color: Colors.deepOrange,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Export DB To Excel",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange)),
                            child: IconButton(
                              onPressed: () async {
                                int res = await exportDatabaseToExcel();
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
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Wipe Entries",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 22),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange)),
                            child: IconButton(
                              onPressed: () async {
                                await exportDatabaseToExcel();
                                await DB_Helper.deleteDB();

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("DB exported and wiped")));
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepOrange)),
                            child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Homepage()),
                                // );
                              },
                              icon: Icon(
                                Icons.home_rounded,
                                color: Colors.deepOrange,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
    ]);
  }
}
