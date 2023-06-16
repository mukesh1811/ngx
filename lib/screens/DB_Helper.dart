import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class DB_Helper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'pos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        username TEXT,
        password TEXT,
        phno TEXT
     )
      """);

    await database.execute("""CREATE TABLE tokens(
        consignor_name TEXT,
        item_name TEXT,
        payment_type TEXT,
        lot_no TEXT,
        mark TEXT,
        units INTEGER,
        weight INTEGER,
        rate INTEGER,
        amount INTEGER
     )
      """);

    await database.execute("""CREATE TABLE receipts(
        customer_name TEXT,
        balance INTEGER
     )
      """);

    await database.execute("""
    CREATE TABLE retail(
        item_name TEXT,
        payment_type TEXT,
		units INTEGER,
		weight INTEGER,
		rate INTEGER,
		amount INTEGER
     )
      """);
  }

  static Future<int> createRetail(Map<String, dynamic> data) async {
    final db = await DB_Helper.db();

    final id = await db.insert('retail', data,
        conflictAlgorithm: ConflictAlgorithm.fail);

    return id;
  }

  static Future<int> createReceipt(Map<String, dynamic> data) async {
    final db = await DB_Helper.db();

    final id = await db.insert('receipts', data,
        conflictAlgorithm: ConflictAlgorithm.fail);

    return id;
  }

  static Future<int> createToken(Map<String, dynamic> data) async {
    final db = await DB_Helper.db();

    final id = await db.insert('tokens', data,
        conflictAlgorithm: ConflictAlgorithm.fail);

    return id;
  }

  static Future<int> getBalance(String customerName) async {
    print(customerName);
    final db = await DB_Helper.db();

    var bal = await db.query('receipts',
        where: 'customer_name = ?',
        whereArgs: [customerName],
        // groupBy: 'customer_name',
        columns: ['sum(balance) as balance_sum']);

    var balance_sum = bal[0]['balance_sum'];

    if (balance_sum.toString() == 'null') {
      return 0;
    } else {
      return int.parse(balance_sum.toString());
    }
  }

  static Future<int> getMaxRetailNo() async {
    final db = await DB_Helper.db();

    var max_rowid =
        await db.rawQuery("select max(_rowid_) as token_no from retail");

    print("max_rowid");
    print(max_rowid);
    print(max_rowid[0]['token_no']);

    if (max_rowid[0]['token_no'] == null) {
      return 1;
    } else {
      return int.parse(max_rowid[0]['token_no'].toString()) + 1;
    }
  }

  static Future<int> getMaxReceiptNo() async {
    final db = await DB_Helper.db();

    var max_rowid =
        await db.rawQuery("select max(_rowid_) as token_no from receipts");

    print("max_rowid");
    print(max_rowid);
    print(max_rowid[0]['token_no']);

    if (max_rowid[0]['token_no'] == null) {
      return 1;
    } else {
      return int.parse(max_rowid[0]['token_no'].toString()) + 1;
    }
  }

  static Future<int> deleteDB() async {
    final db = await DB_Helper.db();

    await db.delete('tokens');
    await db.delete('receipts');
    await db.delete('retail');

    return 1;
  }

  static Future<int> getMaxTokenNo() async {
    final db = await DB_Helper.db();

    var max_rowid =
        await db.rawQuery("select max(_rowid_) as token_no from tokens");

    print("max_rowid");
    print(max_rowid);
    print(max_rowid[0]['token_no']);

    if (max_rowid[0]['token_no'] == null) {
      return 1;
    } else {
      return int.parse(max_rowid[0]['token_no'].toString()) + 1;
    }
  }

  static Future<String> addUser(
      String? username, String? password, int? phno) async {
    if (await DB_Helper._userExists(username!)) {
      return "User exists";
    }

    DB_Helper._createItem(username, password, phno);

    return "User added successfully!";
  }

  static Future<String> auth(String? username, String? password) async {
    if (await DB_Helper._userExists(username!)) {
      String pwd_from_db = await DB_Helper.getPwd(username);

      if (pwd_from_db == password) {
        return "Login Successful!";
      } else {
        print('pwd from db = ${pwd_from_db}');
        print('password = ${password}');
        return "Wrong Password";
      }
    } else {
      return "User does not exist";
    }
  }

  static Future<Map<String, Object?>> getRetail(int token_id) async {
    final db = await DB_Helper.db();

    var res =
        await db.query('retail', where: '_rowid_ = ?', whereArgs: [token_id]);

    print('Token: ${res}');

    return res[0];
  }

  static Future<Map<String, Object?>> getReceipts(int token_id) async {
    final db = await DB_Helper.db();

    var res =
        await db.query('receipts', where: '_rowid_ = ?', whereArgs: [token_id]);

    print('Receipts: ${res}');

    return res[0];
  }

  static Future<Map<String, Object?>> getToken(int token_id) async {
    final db = await DB_Helper.db();

    var res =
        await db.query('tokens', where: '_rowid_ = ?', whereArgs: [token_id]);

    print('Token: ${res}');

    return res[0];
  }

  static Future<String> getPwd(String username) async {
    final db = await DB_Helper.db();

    var res =
        await db.query('users', where: 'username = ?', whereArgs: [username]);

    String extracted_password = res[0]['password'] as String;

    return extracted_password;
  }

  static Future<bool> _userExists(String username) async {
    final db = await DB_Helper.db();

    print('checking username ${username}');
    var res =
        await db.query('users', where: 'username = ?', whereArgs: [username]);

    print(res);
    print(res.length);

    return res.isNotEmpty;
  }

  static Future<int> _createItem(
      String? username, String? password, int? phno) async {
    final db = await DB_Helper.db();

    final data = {'username': username, 'password': password, 'phno': phno};

    final id = await db.insert('users', data,
        conflictAlgorithm: ConflictAlgorithm.fail);

    print('id');
    print(id);

    return id;
  }

  static Future<int> createItem_static(
      String? title, String? descrption, String? author) async {
    final db = await DB_Helper.db();

    final data = {'title': title, 'description': descrption, 'author': author};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DB_Helper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<int> updateAdminPwd(String pwd) async {
    print('new pwd sent: $pwd');

    final db = await DB_Helper.db();

    var adminEntry = await db.query('users',
        columns: ['phno'], where: "username = ?", whereArgs: ['admin']);

    String phno_from_db = adminEntry[0]['phno'].toString();

    print('adminEntry: $phno_from_db');

    final data = {'username': 'admin', 'password': pwd, 'phno': phno_from_db};

    final result = await db
        .update('users', data, where: "username = ?", whereArgs: ['admin']);

    print('result: $result');

    return result;
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption, String? author) async {
    final db = await DB_Helper.db();

    final data = {
      'title': title,
      'description': descrption,
      'author': author,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await DB_Helper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}