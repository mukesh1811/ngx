import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CsvFileReaderWidget extends StatefulWidget {
  const CsvFileReaderWidget({super.key});

  @override
  _CsvFileReaderWidgetState createState() => _CsvFileReaderWidgetState();
}

class _CsvFileReaderWidgetState extends State<CsvFileReaderWidget> {
  String _status = '';

  Future<void> _openFileBrowserAndReadCSV() async {
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

      // Initialize database
      Database database = await openDatabase(
        join(await getDatabasesPath(), 'my_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE my_table (column1 TEXT, column2 TEXT, column3 TEXT)',
          );
        },
        version: 1,
      );

      // Insert data into the database
      Batch batch = database.batch();
      fields.forEach((row) {
        batch.insert('my_table', {
          'column1': row[0],
          'column2': row[1],
          'column3': row[2],
        });
      });
      await batch.commit();

      // Close the database
      await database.close();

      setState(() {
        _status = 'Data inserted into the database.';
      });
    } else {
      // User canceled the file picker
      setState(() {
        _status = 'No file selected.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CSV File Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 32),
              ),
              onPressed: _openFileBrowserAndReadCSV,
              child: Text('Open File Browser'),
            ),
            SizedBox(height: 16),
            Text(_status),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CsvFileReaderWidget(),
  ));
}
