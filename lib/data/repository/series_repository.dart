import 'package:sqflite/sqflite.dart';

import '../context.dart';

class Series {
  final int? id;
  final String name;
  final int currentEpisode;

  Series({required this.id, required this.name, required this.currentEpisode});

  factory Series.fromMap(Map<String, dynamic> json) => Series(
      id: json['id'],
      name: json['name'],
      currentEpisode: json['currentEpisode']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currentEpisode': currentEpisode,
    };
  }

  // Gets a list of all Series in database.
  Future<List<Series>> getSeries() async {
    Database db = await Context.instance.database;
    var series = await db.query('groceries', orderBy: 'name');
    List<Series> seriesList =
        series.isNotEmpty ? series.map((s) => Series.fromMap(s)).toList() : [];
    return seriesList;
  }
}
