import 'dart:convert';

import 'package:flutter_weather_app/data/data_constants.dart';
import 'package:flutter_weather_app/data/repository/api_repository.dart';
import 'package:flutter_weather_app/model/city.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/model/weather.dart';
import 'dart:async';

class ApiImpl extends ApiRepository {
  @override
  Future<List<City>> getCities(String text) async {
    final url = Uri.parse('${api}search/?query=$text');
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();
    return cities;
  }

  @override
  Future<City> getWeathers(City city) async {
    final url = Uri.parse('$api${city.id}');
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weatherData = data['consolidated_weather'] as List;
    final weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);
    return newCity;
  }
}
