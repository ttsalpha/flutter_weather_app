import 'dart:core';

import 'package:flutter/material.dart';



// ignore: camel_case_types
class LocationInfor{
  int id;
  // ignore: non_constant_identifier_names
  String full_name;
  String name;
  String region;
  String country;
  String url;
  double lat;
  double lon;
  // ignore: non_constant_identifier_names
  String tz_id;
  // ignore: non_constant_identifier_names
  int localtime_epoch;
  String localtime;
  LocationInfor( {@required this.id,@required this.full_name,
      @required this.region,@required this.country,@required this.lat,
      @required this.lon,@required this.url});

  factory LocationInfor.fromJson(Map<String,dynamic> json){
    return LocationInfor(id:json['id'],full_name:json['name'],
      region:json['region'],country:json['country'],lat:json['lat'],
      lon:json['lon'],url:json['url']);
  }
  update(Map<String,dynamic> json){
    this.name = json[name];
    this.tz_id= json[tz_id];
    this.localtime= json[localtime];
    this.localtime_epoch= json[localtime_epoch];
  }
  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+"\n"+this.full_name;
  }
}

class Condition{
  String text;
  String icon;
  int code;
  Condition({this.text,this.icon,this.code});
  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+"\n"+this.text;
  }
}
// ignore: camel_case_types
class AirQuality{
  double co;
  double no2;
  double o3;
  double so2;
  double pm2_5;
  double pm10;
  // ignore: non_constant_identifier_names
  double us_epa_index;
  // ignore: non_constant_identifier_names
  double gb_defra_index;
  AirQuality({this.co,this.no2,this.o3,this.so2,this.pm2_5,this.pm10,this.us_epa_index,this.gb_defra_index});
}
