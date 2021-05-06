import 'package:flutter/foundation.dart';
import 'package:flutter_weather_app/model/current.dart';
import 'package:flutter_weather_app/model/infor_block.dart';

class Location {
  // ignore: non_constant_identifier_names
  LocationInfor location_infor;
  // ignore: non_constant_identifier_names
  CurrentWeather current_weather;

  Location({this.location_infor});
  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+"\n"+location_infor.toString()+"\n"+current_weather.toString();
  }
}
