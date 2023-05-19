import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _importCsv() async {
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
      print(appDir);

      // Move the CSV file to the database directory
      File csvFile = File(csvFilePath);
      String newCsvPath = join(appDir.path, basename(csvFilePath));
      print(newCsvPath);
      await csvFile.rename(newCsvPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
                          Text("SETTINGS",
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
                                await _importCsv();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Config file updated successfully!")));
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
                    )
                  ],
                ),
              ),
            ),
          ))
    ]);
  }
}
