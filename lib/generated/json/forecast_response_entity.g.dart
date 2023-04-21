import 'package:weather_app/generated/json/base/json_convert_content.dart';
import 'package:weather_app/generated/forecast_response_entity.dart';

ForecastResponseEntity $ForecastResponseEntityFromJson(Map<String, dynamic> json) {
	final ForecastResponseEntity forecastResponseEntity = ForecastResponseEntity();
	final String? cod = jsonConvert.convert<String>(json['cod']);
	if (cod != null) {
		forecastResponseEntity.cod = cod;
	}
	final int? message = jsonConvert.convert<int>(json['message']);
	if (message != null) {
		forecastResponseEntity.message = message;
	}
	final int? cnt = jsonConvert.convert<int>(json['cnt']);
	if (cnt != null) {
		forecastResponseEntity.cnt = cnt;
	}
	final List<ForecastResponseList>? list = jsonConvert.convertListNotNull<ForecastResponseList>(json['list']);
	if (list != null) {
		forecastResponseEntity.list = list;
	}
	final ForecastResponseCity? city = jsonConvert.convert<ForecastResponseCity>(json['city']);
	if (city != null) {
		forecastResponseEntity.city = city;
	}
	return forecastResponseEntity;
}

Map<String, dynamic> $ForecastResponseEntityToJson(ForecastResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cod'] = entity.cod;
	data['message'] = entity.message;
	data['cnt'] = entity.cnt;
	data['list'] =  entity.list.map((v) => v.toJson()).toList();
	data['city'] = entity.city.toJson();
	return data;
}

ForecastResponseList $ForecastResponseListFromJson(Map<String, dynamic> json) {
	final ForecastResponseList forecastResponseList = ForecastResponseList();
	final int? dt = jsonConvert.convert<int>(json['dt']);
	if (dt != null) {
		forecastResponseList.dt = dt;
	}
	final ForecastResponseListMain? main = jsonConvert.convert<ForecastResponseListMain>(json['main']);
	if (main != null) {
		forecastResponseList.main = main;
	}
	final List<ForecastResponseListWeather>? weather = jsonConvert.convertListNotNull<ForecastResponseListWeather>(json['weather']);
	if (weather != null) {
		forecastResponseList.weather = weather;
	}
	final ForecastResponseListClouds? clouds = jsonConvert.convert<ForecastResponseListClouds>(json['clouds']);
	if (clouds != null) {
		forecastResponseList.clouds = clouds;
	}
	final ForecastResponseListWind? wind = jsonConvert.convert<ForecastResponseListWind>(json['wind']);
	if (wind != null) {
		forecastResponseList.wind = wind;
	}
	final int? visibility = jsonConvert.convert<int>(json['visibility']);
	if (visibility != null) {
		forecastResponseList.visibility = visibility;
	}
	final int? pop = jsonConvert.convert<int>(json['pop']);
	if (pop != null) {
		forecastResponseList.pop = pop;
	}
	final ForecastResponseListSys? sys = jsonConvert.convert<ForecastResponseListSys>(json['sys']);
	if (sys != null) {
		forecastResponseList.sys = sys;
	}
	final String? dtTxt = jsonConvert.convert<String>(json['dt_txt']);
	if (dtTxt != null) {
		forecastResponseList.dtTxt = dtTxt;
	}
	final ForecastResponseListRain? rain = jsonConvert.convert<ForecastResponseListRain>(json['rain']);
	if (rain != null) {
		forecastResponseList.rain = rain;
	}
	return forecastResponseList;
}

Map<String, dynamic> $ForecastResponseListToJson(ForecastResponseList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['dt'] = entity.dt;
	data['main'] = entity.main.toJson();
	data['weather'] =  entity.weather.map((v) => v.toJson()).toList();
	data['clouds'] = entity.clouds.toJson();
	data['wind'] = entity.wind.toJson();
	data['visibility'] = entity.visibility;
	data['pop'] = entity.pop;
	data['sys'] = entity.sys.toJson();
	data['dt_txt'] = entity.dtTxt;
	data['rain'] = entity.rain.toJson();
	return data;
}

ForecastResponseListMain $ForecastResponseListMainFromJson(Map<String, dynamic> json) {
	final ForecastResponseListMain forecastResponseListMain = ForecastResponseListMain();
	final double? temp = jsonConvert.convert<double>(json['temp']);
	if (temp != null) {
		forecastResponseListMain.temp = temp;
	}
	final double? feelsLike = jsonConvert.convert<double>(json['feels_like']);
	if (feelsLike != null) {
		forecastResponseListMain.feelsLike = feelsLike;
	}
	final double? tempMin = jsonConvert.convert<double>(json['temp_min']);
	if (tempMin != null) {
		forecastResponseListMain.tempMin = tempMin;
	}
	final double? tempMax = jsonConvert.convert<double>(json['temp_max']);
	if (tempMax != null) {
		forecastResponseListMain.tempMax = tempMax;
	}
	final int? pressure = jsonConvert.convert<int>(json['pressure']);
	if (pressure != null) {
		forecastResponseListMain.pressure = pressure;
	}
	final int? seaLevel = jsonConvert.convert<int>(json['sea_level']);
	if (seaLevel != null) {
		forecastResponseListMain.seaLevel = seaLevel;
	}
	final int? grndLevel = jsonConvert.convert<int>(json['grnd_level']);
	if (grndLevel != null) {
		forecastResponseListMain.grndLevel = grndLevel;
	}
	final int? humidity = jsonConvert.convert<int>(json['humidity']);
	if (humidity != null) {
		forecastResponseListMain.humidity = humidity;
	}
	final double? tempKf = jsonConvert.convert<double>(json['temp_kf']);
	if (tempKf != null) {
		forecastResponseListMain.tempKf = tempKf;
	}
	return forecastResponseListMain;
}

Map<String, dynamic> $ForecastResponseListMainToJson(ForecastResponseListMain entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['temp'] = entity.temp;
	data['feels_like'] = entity.feelsLike;
	data['temp_min'] = entity.tempMin;
	data['temp_max'] = entity.tempMax;
	data['pressure'] = entity.pressure;
	data['sea_level'] = entity.seaLevel;
	data['grnd_level'] = entity.grndLevel;
	data['humidity'] = entity.humidity;
	data['temp_kf'] = entity.tempKf;
	return data;
}

ForecastResponseListWeather $ForecastResponseListWeatherFromJson(Map<String, dynamic> json) {
	final ForecastResponseListWeather forecastResponseListWeather = ForecastResponseListWeather();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		forecastResponseListWeather.id = id;
	}
	final String? main = jsonConvert.convert<String>(json['main']);
	if (main != null) {
		forecastResponseListWeather.main = main;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		forecastResponseListWeather.description = description;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		forecastResponseListWeather.icon = icon;
	}
	return forecastResponseListWeather;
}

Map<String, dynamic> $ForecastResponseListWeatherToJson(ForecastResponseListWeather entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['main'] = entity.main;
	data['description'] = entity.description;
	data['icon'] = entity.icon;
	return data;
}

ForecastResponseListClouds $ForecastResponseListCloudsFromJson(Map<String, dynamic> json) {
	final ForecastResponseListClouds forecastResponseListClouds = ForecastResponseListClouds();
	final int? all = jsonConvert.convert<int>(json['all']);
	if (all != null) {
		forecastResponseListClouds.all = all;
	}
	return forecastResponseListClouds;
}

Map<String, dynamic> $ForecastResponseListCloudsToJson(ForecastResponseListClouds entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['all'] = entity.all;
	return data;
}

ForecastResponseListWind $ForecastResponseListWindFromJson(Map<String, dynamic> json) {
	final ForecastResponseListWind forecastResponseListWind = ForecastResponseListWind();
	final double? speed = jsonConvert.convert<double>(json['speed']);
	if (speed != null) {
		forecastResponseListWind.speed = speed;
	}
	final int? deg = jsonConvert.convert<int>(json['deg']);
	if (deg != null) {
		forecastResponseListWind.deg = deg;
	}
	final double? gust = jsonConvert.convert<double>(json['gust']);
	if (gust != null) {
		forecastResponseListWind.gust = gust;
	}
	return forecastResponseListWind;
}

Map<String, dynamic> $ForecastResponseListWindToJson(ForecastResponseListWind entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['speed'] = entity.speed;
	data['deg'] = entity.deg;
	data['gust'] = entity.gust;
	return data;
}

ForecastResponseListSys $ForecastResponseListSysFromJson(Map<String, dynamic> json) {
	final ForecastResponseListSys forecastResponseListSys = ForecastResponseListSys();
	final String? pod = jsonConvert.convert<String>(json['pod']);
	if (pod != null) {
		forecastResponseListSys.pod = pod;
	}
	return forecastResponseListSys;
}

Map<String, dynamic> $ForecastResponseListSysToJson(ForecastResponseListSys entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['pod'] = entity.pod;
	return data;
}

ForecastResponseListRain $ForecastResponseListRainFromJson(Map<String, dynamic> json) {
	final ForecastResponseListRain forecastResponseListRain = ForecastResponseListRain();
	final double? x3h = jsonConvert.convert<double>(json['3h']);
	if (x3h != null) {
		forecastResponseListRain.x3h = x3h;
	}
	return forecastResponseListRain;
}

Map<String, dynamic> $ForecastResponseListRainToJson(ForecastResponseListRain entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['3h'] = entity.x3h;
	return data;
}

ForecastResponseCity $ForecastResponseCityFromJson(Map<String, dynamic> json) {
	final ForecastResponseCity forecastResponseCity = ForecastResponseCity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		forecastResponseCity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		forecastResponseCity.name = name;
	}
	final ForecastResponseCityCoord? coord = jsonConvert.convert<ForecastResponseCityCoord>(json['coord']);
	if (coord != null) {
		forecastResponseCity.coord = coord;
	}
	final String? country = jsonConvert.convert<String>(json['country']);
	if (country != null) {
		forecastResponseCity.country = country;
	}
	final int? population = jsonConvert.convert<int>(json['population']);
	if (population != null) {
		forecastResponseCity.population = population;
	}
	final int? timezone = jsonConvert.convert<int>(json['timezone']);
	if (timezone != null) {
		forecastResponseCity.timezone = timezone;
	}
	final int? sunrise = jsonConvert.convert<int>(json['sunrise']);
	if (sunrise != null) {
		forecastResponseCity.sunrise = sunrise;
	}
	final int? sunset = jsonConvert.convert<int>(json['sunset']);
	if (sunset != null) {
		forecastResponseCity.sunset = sunset;
	}
	return forecastResponseCity;
}

Map<String, dynamic> $ForecastResponseCityToJson(ForecastResponseCity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['coord'] = entity.coord.toJson();
	data['country'] = entity.country;
	data['population'] = entity.population;
	data['timezone'] = entity.timezone;
	data['sunrise'] = entity.sunrise;
	data['sunset'] = entity.sunset;
	return data;
}

ForecastResponseCityCoord $ForecastResponseCityCoordFromJson(Map<String, dynamic> json) {
	final ForecastResponseCityCoord forecastResponseCityCoord = ForecastResponseCityCoord();
	final double? lat = jsonConvert.convert<double>(json['lat']);
	if (lat != null) {
		forecastResponseCityCoord.lat = lat;
	}
	final double? lon = jsonConvert.convert<double>(json['lon']);
	if (lon != null) {
		forecastResponseCityCoord.lon = lon;
	}
	return forecastResponseCityCoord;
}

Map<String, dynamic> $ForecastResponseCityCoordToJson(ForecastResponseCityCoord entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['lat'] = entity.lat;
	data['lon'] = entity.lon;
	return data;
}