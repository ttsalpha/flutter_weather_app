import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_weather_app/model/city.dart';
import 'package:flutter_weather_app/ui/home/weather_details_widget.dart';
import 'package:flutter_weather_app/ui/ui_constants.dart';

DateFormat format = DateFormat('E, dd MMM yyyy');

class WeathersWidget extends StatefulWidget {
  final List<City> cities;
  final VoidCallback onTap;

  const WeathersWidget({
    Key key,
    this.cities,
    this.onTap,
  }) : super(key: key);

  @override
  _WeathersWidgetState createState() => _WeathersWidgetState();
}

class _WeathersWidgetState extends State<WeathersWidget> {
  int _currentIndex = 0;

  void handleArrowPressed(City city) {
    showBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.0,
          ),
        ),
      ),
      builder: (_) {
        return WeatherDetailsWidget(city: city);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final weather = widget.cities[_currentIndex].weathers.first;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
                alignment: Alignment.center,
              );
            },
            duration: Duration(
              milliseconds: 600,
            ),
            child: Image.asset(
              'assets/background_states/${weather.weatherStateAbbr}.jpg',
              fit: BoxFit.cover,
              key: Key(weather.weatherStateAbbr),
            ),
          ),
        ),
        PageView.builder(
          onPageChanged: (val) {
            setState(() {
              _currentIndex = val;
            });
          },
          physics: const ClampingScrollPhysics(),
          itemCount: widget.cities.length,
          itemBuilder: (context, index) {
            final city = widget.cities[index];
            return WeatherItem(
              city: city,
              onTap: () => handleArrowPressed(city),
            );
          },
        ),
        Positioned(
          left: 20,
          top: 20,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: widget.onTap,
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: widget.onTap,
            ),
          ),
        ),
      ],
    );
  }
}

class WeatherItem extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const WeatherItem({
    Key key,
    this.city,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = city.weathers.first;
    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                city.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: shadows,
                ),
              ),
              Text(
                format.format(weather.applicableDate),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  shadows: shadows,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TweenAnimationBuilder<int>(
                      tween: IntTween(
                        begin: 0,
                        end: weather.theTemp.toInt(),
                      ),
                      duration: const Duration(
                        milliseconds: 800,
                      ),
                      builder: (context, value, child) {
                        return Text(
                          value.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            shadows: shadows,
                            fontSize: 75,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            shadows: shadows,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                weather.weatherStateName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  shadows: shadows,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Temp min',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Temp max',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: shadows,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${weather.minTemp.toStringAsFixed(2)} °C',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${weather.maxTemp.toStringAsFixed(2)} °C',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                shadows: shadows,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Humidity',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Visibility',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: shadows,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${weather.humidity} %',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${weather.visibility.toStringAsFixed(2)} km',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                shadows: shadows,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Wind',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Air pressure',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: shadows,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${weather.windSpeed.toStringAsFixed(2)} mph',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                shadows: shadows,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${weather.airPressure} mBar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                shadows: shadows,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherItemDetails extends StatelessWidget {
  final String title;
  final String value;

  const _WeatherItemDetails({Key key, this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.white, shadows: shadows),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            shadows: shadows,
          ),
        ),
      ],
    );
  }
}
