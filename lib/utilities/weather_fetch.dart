import 'dart:convert';

import 'package:weather/utilities/weather.dart';
import 'package:http/http.dart' as http;

Future<Weather> getWeather(String cityName) async {
  const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final url =
      "$BASE_URL?q=$cityName&appid=a819e7c96006e2db4ae0dd354d08ed03&units=metric";
  final uri = Uri.parse(url);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final body = response.body;
    final json = jsonDecode(body);
    return Weather.fromJson(json);
  } else {
    throw Exception('failed to load');
  }
}

Future<Weather> get_auto_Weather(double lat, double lon) async {
  const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';

  final url =
      "$BASE_URL?lat=${lat.toDouble()}&lon=${lon.toDouble()}&appid=a819e7c96006e2db4ae0dd354d08ed03&units=metric";
  final uri = Uri.parse(url);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return Weather.fromJson(json);
  } else {
    throw Exception('Failed to load');
  }
}
