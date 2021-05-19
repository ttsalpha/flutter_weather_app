import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather_app/data/repository/api_impl.dart';
import 'package:flutter_weather_app/data/repository/api_repository.dart';
import 'package:flutter_weather_app/data/repository/store_impl.dart';
import 'package:flutter_weather_app/data/repository/store_repository.dart';
import 'package:flutter_weather_app/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepository>(
          create: (_) => ApiImpl(),
        ),
        Provider<StoreRepository>(
          create: (_) => StoreImpl(),
        ),
      ],
      child: MaterialApp(
        title: 'flutter_weather_app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: HomePage(),
      ),
    );
  }
}
