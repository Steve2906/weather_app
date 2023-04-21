import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/weather_page/weather_widget.dart';
import '../api/get_weather.dart';
import '../generated/forecast_response_entity.dart';

abstract class ListItem{}

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherForecastPage("Moscow");
  }
}

class WeatherForecastPage extends StatefulWidget {
  WeatherForecastPage(this.cityName);
  final String cityName;
  @override
  State<StatefulWidget> createState() {
    return _WeatherForecastPageState();
  }
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  var _isLoading = true;
  List<ListItem> weatherForecast = <ListItem>[];
  Future<Placemark?> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    CurrentPosition().lng = position.longitude;
    CurrentPosition().lat = position.latitude;
    List<Placemark> placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemark.isNotEmpty) {
      print(placemark[0]);
      return placemark[0];
    } else {
      return null;
    }
  }


  @override
  void initState() {
    super.initState();
    var itCurrentDay = DateTime.now();
    weatherForecast.add(DayHeading(itCurrentDay));
    _isLoading = true;
    var dataFuture = getWeather(CurrentPosition().lat, CurrentPosition().lng);
    dataFuture.then((val) {
      List<ListItem> weatherForecastLocal = [];
      weatherForecastLocal.add(DayHeading(itCurrentDay));
      List<ListItem> weatherData = val!;
      var itNextDay = DateTime.now().add(Duration(days: 1));
      itNextDay =
          DateTime(itNextDay.year, itNextDay.month, itNextDay.day, 0, 0, 0, 0, 1);
      var iterator = weatherData.iterator;
      while (iterator.moveNext()) {
        var weatherDateTime = iterator.current as ForecastResponseList;
        if (DateTime.fromMillisecondsSinceEpoch(weatherDateTime.dt*1000).isAfter(itNextDay)) {
          itCurrentDay = itNextDay;
          itNextDay = itCurrentDay.add(Duration(days: 1));
          itNextDay = DateTime(itNextDay.year, itNextDay.month,
              itNextDay.day, 0, 0, 0, 0, 1);
          weatherForecastLocal.add(DayHeading(itCurrentDay));
        } else {
          weatherForecastLocal.add(iterator.current);
        }
        setState(() {
          weatherForecast = weatherForecastLocal;
        });
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Weather"),
          ),
          body: _pageToDisplay
      ),
    );
  }

  Widget get _pageToDisplay {
    if (_isLoading) {
      return _loadingView;
    }
    else {
      return _contentView;
    }
  }
  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget get _contentView {
    return ListView.builder(
        itemCount: weatherForecast == null ? 0 : weatherForecast.length,
        itemBuilder: (BuildContext context, int index) {
          final item = weatherForecast[index];
          if (item is ForecastResponseList) {
            return WeatherListItem(item as ForecastResponseList);
          } else if (item is DayHeading) {
            return HeadingListItem(item);
          } else
            throw Exception("wrong type");
        });
  }


}

class CurrentPosition extends _WeatherForecastPageState {
  var lat = 55.751244;
  var lng = 37.618423;
}