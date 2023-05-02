import 'package:flutter/material.dart';
import 'package:weather_app/places_page/places_page.dart';
import 'package:weather_app/database/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getDatabase();
  runApp(MaterialApp(home:PlacesPage()));
}

