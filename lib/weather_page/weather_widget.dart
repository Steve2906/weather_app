import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weather_page/weather_page.dart';

import '../generated/forecast_response_entity.dart';


class Weather extends ListItem {
  static const String weatherURL = "https://openweathermap.org/img/w/";
  DateTime dateTime;
  num degree;
  int clouds;
  String iconURL;

  String getIconUrl() {
    return "$weatherURL$iconURL.png";
  }

  Weather(this.dateTime, this.degree, this.clouds, this.iconURL);
}

class DayHeading extends ListItem {
  final DateTime dateTime;

  DayHeading(this.dateTime);
}

class HeadingListItem extends StatelessWidget implements ListItem {
  static final _dateFormatWeekDay = DateFormat('EEEE');
  static final _dateFormatMonth = DateFormat('MMMM');
  final DayHeading dayHeading;

  const HeadingListItem(this.dayHeading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: ListTile(
      title: Column(
        children: [
          Text(
            "${_dateFormatWeekDay.format(dayHeading.dateTime)}, ${_dateFormatMonth.format(dayHeading.dateTime)}, ${dayHeading.dateTime.day}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    ));
  }
}

class WeatherListItem extends StatelessWidget implements ListItem {
  static final _dateFormat = DateFormat('hh:mm');
  final ForecastResponseList weather;
  const WeatherListItem(this.weather, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_dateFormat.format(DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000))),
          Padding(padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0), child: Image.network(weather.weather.first.getIconUrl())),
          Text("${(weather.main.temp - 273).roundToDouble()} C"),
        ],
      ),
    );
  }
}