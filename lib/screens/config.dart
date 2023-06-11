import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CsvFileReader {
  static Future<void> openFileBrowserAndReadCSV() async {
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
          .transform(const CsvToListConverter())
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
      for (var row in fields) {
        batch.insert('my_table', {
          'column1': row[0],
          'column2': row[1],
          'column3': row[2],
        });
      }
      await batch.commit();

      // Close the database
      await database.close();

      print('Data inserted into the database.');
    } else {
      // User canceled the file picker
      print('No file selected.');
    }
  }
}

void main() {
  CsvFileReader.openFileBrowserAndReadCSV();
}
