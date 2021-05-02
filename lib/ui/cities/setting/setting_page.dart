import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          // elevation: 0,
          backgroundColor: Colors.white70,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'Section',
              titlePadding: const EdgeInsets.only(
                  left: 20, right: 0, top: 20, bottom: 10),
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Use fingerprint',
                  leading: Icon(Icons.fingerprint),
                  switchValue: true,
                  onToggle: (bool value) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Unit',
              titlePadding: const EdgeInsets.only(
                  left: 20, right: 0, top: 20, bottom: 10),
              tiles: [
                SettingsTile(
                  title: 'Temperature',
                  subtitle: '°C',
                  leading: Icon(Icons.ac_unit),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Amount of rain',
                  subtitle: 'mm',
                  leading: Icon(Icons.invert_colors),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Pressure',
                  subtitle: 'mBar',
                  leading: Icon(Icons.wb_cloudy),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'speed',
                  subtitle: 'km/h',
                  leading: Icon(Icons.toys),
                  onPressed: (BuildContext context) {},
                )
              ],
            ),
            SettingsSection(
              title: 'Other',
              titlePadding: const EdgeInsets.only(
                  left: 20, right: 0, top: 20, bottom: 10),
              tiles: [
                SettingsTile.switchTile(
                  title: 'Dark mode',
                  leading: Icon(Icons.brightness_medium),
                  switchValue: false,
                  onToggle: (bool value) {},
                ),
                SettingsTile(
                  title: 'Other',
                  subtitle: 'other',
                  leading: Icon(Icons.scatter_plot),
                  onPressed: (BuildContext context) {},
                )
              ],
            )
          ],
        ));
  }
}
