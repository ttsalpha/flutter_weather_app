import 'dart:convert';

import 'package:flutter_weather_app/model/infor_block.dart';


class CurrentWeather{
   int last_updated_epoch;
   String last_updated;
   double temp_c;
   double temp_f;
   int is_day;
   Condition condition;
   double wind_mph;
   double wind_kph;
   int wind_degree;
   String wind_dir;
   double pressure_mb;
   double pressure_in;
   double precip_mm;
   double precip_in;
   int humidity;
   int cloud;
   double feelslike_c;
   double feelslike_f;
   double vis_km;
   double vis_miles;
   double uv;
   double gust_mph;
   double gust_kph;
   AirQuality airQuality;

   CurrentWeather({this.last_updated_epoch,this.last_updated,this.temp_c,this.temp_f,this.is_day,
   this.condition,this.wind_mph,this.wind_kph,this.wind_degree,this.wind_dir,this.pressure_mb,
   this.pressure_in,this.precip_mm,this.precip_in,this.humidity,this.cloud,this.feelslike_c,this.feelslike_f,this.vis_km,this.vis_miles,
   this.uv,this.gust_mph,this.gust_kph,this.airQuality});

factory CurrentWeather.fromJson(Map<String,dynamic> json){
   //do something
   return CurrentWeather(last_updated_epoch:json['last_updated_epoch'],last_updated:json['last_updated'],temp_c: json['temp_c'],temp_f: json['temp_f'],is_day: json['is_day'],
       condition:Condition(text: json['condition']['text'],icon: json['condition']['icon'],code: json['condition']['code']),wind_mph:json['wind_mph'],wind_kph: json['wind_kph'],wind_degree: json['wind_degree'],wind_dir: json['wind_dir'],pressure_mb: json['pressure_mb'],
       pressure_in: json['pressure_in'],precip_mm: json['precip_mm'],precip_in: json['precip_in'],humidity: json['humidity'],cloud: json['cloud'],feelslike_c: json['feelslike_c'],feelslike_f: json['feelslike_f'],vis_km: json['vis_km'],vis_miles: json['vis_miles'],
      uv: json['uv'],gust_mph: json['gust_mph'],gust_kph: json['gust_kph'],airQuality: AirQuality(co:json['air_quality']['co'] ,no2:json['air_quality']['no2'] ,o3:json['air_quality']['o3'] ,so2:json['air_quality']['so2'] ,pm2_5:json['air_quality']['pm2_5'] ,pm10:json['air_quality']['pm10'] ,us_epa_index:json['air_quality']['us_epa_index'] ,gb_defra_index:json['air_quality']['gb_defra_index'] ));
}

@override
  String toString() {
    // TODO: implement toString
    return super.toString()+"\n"+last_updated+"\n"+condition.toString();
  }
}
