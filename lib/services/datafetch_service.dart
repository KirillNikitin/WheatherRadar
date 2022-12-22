import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class DatafetchService {
  Future<WeatherResponse> getWeather(String id) async {
    // api.openweathermap.org/data/2.5/forecast?id={city ID}&appid={API key}

    final queryParameters = {
      'id': id,
      'appid': '{YOUR API KEY}',
      'units': 'metric'
    };

    final url = Uri.https(
        'api.openweathermap.org', '/data/2.5/forecast', queryParameters);

    final response = await http.get(url);

    final json = jsonDecode(response.body);

    return WeatherResponse.fromJson(json);
  }
}
