import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Context {
  Context._privateConstructor();
  static final Context instance = Context._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'episode_plus.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Database tables.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE series(
      id INTEGER PRIMARY KEY, 
      name TEXT, 
      currentEpisode INTEGER
    )
    ''');
  }
}
