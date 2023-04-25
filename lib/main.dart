import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/nogps_page/no_gps_page.dart';
import 'package:weather_app/weather_page/weather_page.dart';

void main() {
  runApp(MaterialApp(home:WeatherPage()));
}
