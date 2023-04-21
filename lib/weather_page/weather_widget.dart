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
    return weatherURL + iconURL + ".png";
  }

  Weather(this.dateTime, this.degree, this.clouds, this.iconURL);
}

class DayHeading extends ListItem {
  final DateTime dateTime;

  DayHeading(this.dateTime);
}

class HeadingListItem extends StatelessWidget implements ListItem {
  static var _dateFormatWeekDay = DateFormat('EEEE');
  static var _dateFormatMonth = DateFormat('MMMM');
  final DayHeading dayHeading;

  HeadingListItem(this.dayHeading);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
  static var _dateFormat = DateFormat('yyyy-MM-dd - hh:mm');
  final ForecastResponseList weather;
  WeatherListItem(this.weather);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Row(
        children: [
          Expanded(child: Text((weather.main.temp - 273).roundToDouble().toString() + " C"), flex: 1),
          Expanded(child: Text(weather.dtTxt), flex: 2),
          Expanded(child: Image.network(weather.weather.first.getIconUrl()), flex: 1)
        ],
      ),
    );
  }
}