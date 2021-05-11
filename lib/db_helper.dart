import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._privateConstructor();

  // singleton class
  static final DBHelper instance = DBHelper
      ._privateConstructor(); // DBHelper _dbHelper = DBHelper._privateCons();

  static final _dbName = 'nyotz.db';
  static final _dbName2 = 'zian.db';
  static final _dbName3 = "budi_family.db";

  static final _dbVersion = 1;
  static final _tableNyotz = 'myTable';
  static final _tableName = "keluarga_budi";

  static final columnId = 'id';
  static final columnName = 'nama';
  static final columnJK = 'jenis_kelamin';
  static final columnStatus = 'status';

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();

    return _database;
  }

  initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();

    final path = join(directory.path, _dbName3);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnJK TEXT NOT NULL, $columnStatus TEXT NOT NULL)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await instance.database;

    final data = await db.query(_tableName);

    return data;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
