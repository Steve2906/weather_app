import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/inherited_widgets/location_info.dart';
import 'package:weather_app/places_page/places_page.dart';
import 'package:weather_app/weather_page/weather_widget.dart';
import '../api/get_weather.dart';
import '../generated/forecast_response_entity.dart';
import '../nogps_page/no_gps_page.dart';

abstract class ListItem {}

class CurrentLocation {
  double lat = 55.751244;
  double lng = 37.618423;
  String place = "Loading...";
}

class WeatherForecastPage extends StatefulWidget {
  final Locations place;
  const WeatherForecastPage(this.place, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _WeatherForecastPageState(place);
  }
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  _WeatherForecastPageState(this.place);

  Locations place;
  var _isLoading = true;
  List<ListItem> weatherForecast = <ListItem>[];
  CurrentLocation deviceLocation = CurrentLocation();

  Future<void> _onRefresh() async {
    if (place.place == "nullplace") {
      loadData();
    } else {
      loadPlaceData();
    }
  }

  Future<CurrentLocation?> getLocation() async {
    CurrentLocation deviceLocationLocal = CurrentLocation();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    deviceLocationLocal.lat = position.latitude;
    deviceLocationLocal.lng = position.longitude;
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    deviceLocationLocal.place = placemark[0].locality!;
    if (placemark.isNotEmpty) {
      return deviceLocationLocal;
    } else {
      return null;
    }
  }

  Future<bool?> requestpermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const noGPSPage()));
    }
    if (status.isGranted) {
      return true;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (place.place == "nullplace") {
      loadData();
    } else {
      loadPlaceData();
    }
  }

  void loadData() {
    var checkpermission = requestpermission();
    checkpermission.then((permission) {
      var itCurrentDay = DateTime.now();
      weatherForecast.add(DayHeading(itCurrentDay));
      _isLoading = true;
      var placemark = getLocation();
      placemark.then((place) {
        deviceLocation.place = place!.place;
        var dataFuture = getWeather(place.lat, place.lng);
        dataFuture.then((val) {
          List<ListItem> weatherForecastLocal = [];
          weatherForecastLocal.add(DayHeading(itCurrentDay));
          List<ListItem> weatherData = val!;
          var itNextDay = DateTime.now().add(const Duration(days: 1));
          itNextDay = DateTime(
              itNextDay.year, itNextDay.month, itNextDay.day, 0, 0, 0, 0, 1);
          var iterator = weatherData.iterator;
          while (iterator.moveNext()) {
            var weatherDateTime = iterator.current as ForecastResponseList;
            if (DateTime.fromMillisecondsSinceEpoch(weatherDateTime.dt * 1000)
                .isAfter(itNextDay)) {
              itCurrentDay = itNextDay;
              itNextDay = itCurrentDay.add(const Duration(days: 1));
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
      });
    });
    setState(() {});
  }

  void loadPlaceData() {
    var checkpermission = requestpermission();
    checkpermission.then((permission) {
      var itCurrentDay = DateTime.now();
      weatherForecast.add(DayHeading(itCurrentDay));
      _isLoading = true;
      deviceLocation.place = place.place;
      var dataFuture = getWeather(place.lat, place.lng);
      dataFuture.then((val) {
        List<ListItem> weatherForecastLocal = [];
        weatherForecastLocal.add(DayHeading(itCurrentDay));
        List<ListItem> weatherData = val!;
        var itNextDay = DateTime.now().add(const Duration(days: 1));
        itNextDay = DateTime(
            itNextDay.year, itNextDay.month, itNextDay.day, 0, 0, 0, 0, 1);
        var iterator = weatherData.iterator;
        while (iterator.moveNext()) {
          var weatherDateTime = iterator.current as ForecastResponseList;
          if (DateTime.fromMillisecondsSinceEpoch(weatherDateTime.dt * 1000)
              .isAfter(itNextDay)) {
            itCurrentDay = itNextDay;
            itNextDay = itCurrentDay.add(const Duration(days: 1));
            itNextDay = DateTime(
                itNextDay.year, itNextDay.month, itNextDay.day, 0, 0, 0, 0, 1);
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
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.navigate_before), onPressed: () { Navigator.pop(context); },),
            title: Text(deviceLocation.place),
          ),
          body: _pageToDisplay),
    );
  }

  Widget get _pageToDisplay {
    if (_isLoading) {
      return _loadingView;
    } else {
      return _contentView;
    }
  }

  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _contentView {
    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
            itemCount: weatherForecast == null ? 0 : weatherForecast.length,
            itemBuilder: (BuildContext context, int index) {
              final item = weatherForecast[index];
              if (item is ForecastResponseList) {
                return WeatherListItem(item);
              } else if (item is DayHeading) {
                return HeadingListItem(item);
              } else {
                throw Exception("wrong type");
              }
            }));
  }
}
