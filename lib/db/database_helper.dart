import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> database(String dbName) async {
    final dbpath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbpath, '$dbName.db'), version: 1,
        onCreate: (db, version) {
      db.execute(dbName == 'cart'
          ? 'CREATE TABLE $dbName(id INTEGER PRIMARY KEY, productId String, data TEXT NOT NULL)'
          : 'CREATE TABLE $dbName(id INTEGER PRIMARY KEY, productId String, title TEXT NOT NULL, price FLOAT, imgUrl TEXT, isCartable INTEGER)');
    });
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DbHelper.database(table);
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchDb(String table) async {
    final db = await DbHelper.database(table);

    return db.query(table);
  }

  static Future<void> updateQuantity(
      String table, productId, Map<String, dynamic> data) async {
    final db = await DbHelper.database(table);
    db.update(
      table,
      data,
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  static Future<void> deleteDbTable(String table) async {
    final db = await DbHelper.database(table);
    db.delete(table);
  }

  static Future<void> deleteDbSI(String table, id) async {
    final db = await DbHelper.database(table);

    db.delete(
      table,
      where: 'productId = ?',
      whereArgs: [id],
    );
  }
}
