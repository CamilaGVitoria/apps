import 'package:app_anuncios/anuncio_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  Database? _db;

  static final DataBaseHelper _instace = DataBaseHelper.internal();

  factory DataBaseHelper() => _instace;

  DataBaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database?> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'anuncioDatabase.db');

    try {
      return _db = await openDatabase(path, version: 7, onCreate: _onCreateDB, onUpgrade: _onUpgradeDB);
    } catch (e) {
      throw Exception(e);
    }
  }
  Future _onCreateDB(Database db, int newVersion) async {
    await db.execute(AnuncioHelper.createScript);
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE ${AnuncioHelper.tableName};');
      await _onCreateDB(db, newVersion);
    }
  }
}