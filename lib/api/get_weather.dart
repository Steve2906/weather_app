import 'package:weather_app/generated/forecast_response_entity.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';
import '../weather_page/weather_page.dart';

Future<List<ListItem>?> getWeather(double lat, double lng) async {
  var queryParameters = {
    'APPID': Constants.WEATHER_APP_ID,
    'lat': lat.toString(),
    'lon': lng.toString(),
  };
  var uri = Uri.https(Constants.WEATHER_BASE_URL,
      Constants.WEATHER_FORECAST_URL, queryParameters);
  var response = await http.get(uri);
  print(response.body);
  if (response.statusCode == 200) {
    print("200");
    var forecastResponse =
    ForecastResponseEntity.fromJson(jsonDecode(response.body));
    if (forecastResponse.cod == "200") {
      print("200");
      return forecastResponse.list;
    } else {
      print("Error ${forecastResponse.cod}");
    }
  } else {
    print(Constants.WEATHER_BASE_URL);
    print(Constants.WEATHER_FORECAST_URL);
    print(queryParameters);
    print("Error occured while loading data from server");
  }
}
