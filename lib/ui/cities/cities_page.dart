import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/repository/store_repository.dart';
import 'package:flutter_weather_app/model/city.dart';
import 'package:flutter_weather_app/ui/cities/add/add_city_page.dart';
import 'package:flutter_weather_app/ui/cities/cities_bloc.dart';
import 'package:flutter_weather_app/ui/home_page.dart';
import 'package:flutter_weather_app/ui/ui_constants.dart';
import 'package:provider/provider.dart';

class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  CitiesBloc bloc;

  void handleDeleteTap(City city) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CupertinoAlertDialog(
          title: Text('Delete'),
          content: Text('You sure want to delete ${city.title}?'),
          actions: [
            CupertinoDialogAction(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        ),
      ),
    );
    if (result) {
      bloc.deleteCity(city);
    }
  }

  @override
  void initState() {
    bloc = CitiesBloc(
      storage: context.read<StoreRepository>(),
    );
    bloc.loadCities();
    super.initState();
  }

  void handleNavigatePress(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        pageBuilder: (_, animation1, animation2) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(animation1),
            child: AddCityPage(),
          );
        },
      ),
    );
    bloc.loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            //   onPressed: () => Navigator.of(context)
            //       .pop(MaterialPageRoute(builder: (_) => HomePage())),
            // ),
            title: Text('List of cities',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700)),
            // elevation: 0,
            backgroundColor: Colors.white70,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: primaryColor,
              onPressed: () => handleNavigatePress(context),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: bloc.cities.isEmpty
                        ? Center(
                            child: Text('You do not have any city'),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            itemCount: bloc.cities.length,
                            itemBuilder: (context, index) {
                              final city = bloc.cities[index];
                              return CityItem(
                                city: city,
                                onTap: () => handleDeleteTap(city),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CityItem extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const CityItem({
    Key key,
    this.city,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(
            color: Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              city.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
