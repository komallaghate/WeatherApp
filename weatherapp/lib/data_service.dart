import 'package:weatherapp/models.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherInfo> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',
      'units': 'imperial'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherInfo.fromJson(json);
  }

  Future<WeatherInfo> getWeatherForecast(String city) async {
    final queryParameters = {
      'q': city,
      'cnt': 7,
      'appid': 'e91a32657d0817385b653b2e50a9f998',
      'units': 'imperial'
    };

    final uri = Uri.https('api.openweathermap.org',
        '/data/2.5/2.5/forecast/daily', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherInfo.fromJson(json);
  }
}
