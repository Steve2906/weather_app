import 'package:weather_app/generated/json/base/json_field.dart';
import 'package:weather_app/generated/json/forecast_response_entity.g.dart';
import 'dart:convert';

import 'package:weather_app/weather_page/weather_page.dart';

import '../constants.dart';

@JsonSerializable()
class ForecastResponseEntity {
	late String cod;
	late int message;
	late int cnt;
	late List<ForecastResponseList> list;
	late ForecastResponseCity city;

	ForecastResponseEntity();

	factory ForecastResponseEntity.fromJson(Map<String, dynamic> json) => $ForecastResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseList extends ListItem {
	late int dt;
	late ForecastResponseListMain main;
	late List<ForecastResponseListWeather> weather;
	late ForecastResponseListClouds clouds;
	late ForecastResponseListWind wind;
	late int visibility;
	late int pop;
	late ForecastResponseListSys sys;
	@JSONField(name: "dt_txt")
	late String dtTxt;
	late ForecastResponseListRain rain;

	ForecastResponseList();

	factory ForecastResponseList.fromJson(Map<String, dynamic> json) => $ForecastResponseListFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseListMain {
	late double temp;
	@JSONField(name: "feels_like")
	late double feelsLike;
	@JSONField(name: "temp_min")
	late double tempMin;
	@JSONField(name: "temp_max")
	late double tempMax;
	late int pressure;
	@JSONField(name: "sea_level")
	late int seaLevel;
	@JSONField(name: "grnd_level")
	late int grndLevel;
	late int humidity;
	@JSONField(name: "temp_kf")
	late double tempKf;

	ForecastResponseListMain();

	factory ForecastResponseListMain.fromJson(Map<String, dynamic> json) => $ForecastResponseListMainFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListMainToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseListWeather {
	late int id;
	late String main;
	late String description;
	late String icon;

	ForecastResponseListWeather();

	factory ForecastResponseListWeather.fromJson(Map<String, dynamic> json) => $ForecastResponseListWeatherFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListWeatherToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
	String getIconUrl() {
		return Constants.WEATHER_IMAGES_URL + icon + ".png";
	}

}

@JsonSerializable()
class ForecastResponseListClouds {
	late int all;

	ForecastResponseListClouds();

	factory ForecastResponseListClouds.fromJson(Map<String, dynamic> json) => $ForecastResponseListCloudsFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListCloudsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseListWind {
	late double speed;
	late int deg;
	late double gust;

	ForecastResponseListWind();

	factory ForecastResponseListWind.fromJson(Map<String, dynamic> json) => $ForecastResponseListWindFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListWindToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseListSys {
	late String pod;

	ForecastResponseListSys();

	factory ForecastResponseListSys.fromJson(Map<String, dynamic> json) => $ForecastResponseListSysFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListSysToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseListRain {
	@JSONField(name: "3h")
	late double x3h;

	ForecastResponseListRain();

	factory ForecastResponseListRain.fromJson(Map<String, dynamic> json) => $ForecastResponseListRainFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseListRainToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseCity {
	late int id;
	late String name;
	late ForecastResponseCityCoord coord;
	late String country;
	late int population;
	late int timezone;
	late int sunrise;
	late int sunset;

	ForecastResponseCity();

	factory ForecastResponseCity.fromJson(Map<String, dynamic> json) => $ForecastResponseCityFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseCityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ForecastResponseCityCoord {
	late double lat;
	late double lon;

	ForecastResponseCityCoord();

	factory ForecastResponseCityCoord.fromJson(Map<String, dynamic> json) => $ForecastResponseCityCoordFromJson(json);

	Map<String, dynamic> toJson() => $ForecastResponseCityCoordToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}