
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'locations.dart';

const String CREATE_PLACES_TABLE = "CREATE TABLE Places ("
    "id INTEGER PRIMARY KEY,"
    "place TEXT,"
    "longitude REAL,"
    "latitude REAL"
    ")";

Database? _database;

Future<Database?> getDatabase() async {
  _database = await openDatabase('location_db.db');
  if (_database != null) {
    return _database;
  }

  // if _database is null we instantiate it
  _database = await _initDB('location_db.db');
  return _database;
}

Future<Database> _initDB(String filePath) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, "location_db.db");

  return await openDatabase(path, version: 1, onCreate: _createDB);
}

Future _createDB(Database db, int version) async {
  await db.execute(CREATE_PLACES_TABLE);
}

void insertLocations({required Locations locations}) async {
  try {
    _database?.insert("Places", locations.toMap());
  } catch (e) {
    throw ("Error");
  }
}

Future<List<Locations>> getAllLocations() async {
  var res = await _database?.query("Places");
  if (res == null) {
    return [];
  } else {
    List<Locations>? list = res.map((c) => Locations.fromJson(c)).toList();
    return list;
  }
}

void deleteLocations({required Locations locations}) async {
  try {
    var latitude = locations.lat;
    var longitude = locations.lng;
    await _database?.delete(
      'Places',
      // Use a `where` clause to delete a specific dog.
      where: 'latitude = $latitude AND longitude = $longitude',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [],
    );
  } catch (e) {
    throw (e.toString());
  }
}
