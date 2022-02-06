import 'package:weatherapp/Forecastmodel.dart';
import 'package:weatherapp/models.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherInfo> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': 'e91a32657d0817385b653b2e50a9f998',
      'units': 'imperial'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherInfo.fromJson(json);
  }

  // https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
  Future<ForecastWeather?> getWeatherForecast(
      {required String lat, required String lon}) async {
    final queryParameters = {
      'lat': lat,
      'lon': lon,
      'exclude': 'minutely',
      'appid': 'e91a32657d0817385b653b2e50a9f998',
      'units': 'imperial'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/onecall', queryParameters);

    final response = await http.get(uri);

    print("Forecast data is:  ${response.body}");
    final json = jsonDecode(response.body);
    return ForecastWeather.fromJson(json);
  }
}
