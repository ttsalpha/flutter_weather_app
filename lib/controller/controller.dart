import 'package:flutter/widgets.dart';
import 'package:flutter_weather_app/data/api.dart';
import 'package:flutter_weather_app/model/infor_block.dart';
import 'package:flutter_weather_app/model/location.dart';

class Controller{
  static List<Location> listLocation =[];
  static List<LocationInfor> listLocationInfor=[];
  static void addLocation(LocationInfor locationInfor) async {
    Location location = Location(location_infor: locationInfor);
    location = await fetchRealtime(location);
    listLocation.add(location);
  }

  static void searchLocation(String words) async{
    listLocationInfor = await fetchSearch(words);
    // for(LocationInfor a in listLocationInfor)
    //    print(a.toString());
  }
 static void testLoop() async{
    await searchLocation('london-city-of-london-greater-london-united-kingdom');
    if(listLocationInfor.isEmpty) print("emty");
    for(LocationInfor e in listLocationInfor)
    {
      print("dj");
      await addLocation(e);
    }
    print(listLocation[0].toString()) ;

 }
}

