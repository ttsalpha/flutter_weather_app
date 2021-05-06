import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app/model/current.dart';
import 'package:flutter_weather_app/model/infor_block.dart';
import 'package:flutter_weather_app/model/location.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

/* lấy dữ liệu current api */

Future<Location> fetchRealtime(Location location) async {
  final String url ="http://api.weatherapi.com/v1/current.json?key=d5eefeb47af549f1ad9101139211504&q=" + location.location_infor.url+"&aqi=yes";
  final response = await http.get(Uri.parse(url),headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    location.location_infor.update(jsonDecode(response.body)['location']);
    location.current_weather = CurrentWeather.fromJson(jsonDecode(response.body)['current']);
    return location;
  } else {
    throw Exception('Failed to load album');
  }
}

/* lấy dữ liệu forecast api */

Future<Map<String, dynamic>> fetchForecast(String address) async {
  final String url ="http://api.weatherapi.com/v1/forecast.json?key=d5eefeb47af549f1ad9101139211504&q=" + address;
  final response = await http.get(Uri.parse(url),headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<LocationInfor>> fetchSearch(String words) async {
  final String url ="http://api.weatherapi.com/v1/search.json?key=d5eefeb47af549f1ad9101139211504&q=" + words;
  final response = await http.get(Uri.parse(url),headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

List<LocationInfor> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<LocationInfor>((json) =>LocationInfor.fromJson(json)).toList();
}
