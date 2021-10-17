import 'dart:io';
import 'package:episode_plus/config/database_tables.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'models/series_model.dart';

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

  // Gets a list of all Series in database.
  Future<List<Series>> getSeries() async {
    Database db = await instance.database;
    var series = await db.query(DatabaseTables.seriesTable, orderBy: 'name');
    List<Series> seriesList =
        series.isNotEmpty ? series.map((s) => Series.fromMap(s)).toList() : [];
    return seriesList;
  }

  // Creates a new Series in database.
  Future<int> addSeries(Series series) async {
    Database db = await instance.database;
    return await db.insert(DatabaseTables.seriesTable, series.toMap());
  }

  // Removes a Series from the database.
  Future<int> deleteSeries(int id) async {
    Database db = await instance.database;
    return await db
        .delete(DatabaseTables.seriesTable, where: 'id = ?', whereArgs: [id]);
  }

  // Update a Series from the database.
  Future<int> updateSeries(Series series) async {
    Database db = await instance.database;
    return await db.update(DatabaseTables.seriesTable, series.toMap(),
        where: "id = ?", whereArgs: [series.id]);
  }
}
