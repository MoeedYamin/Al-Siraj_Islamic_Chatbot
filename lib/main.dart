import 'package:adhan/adhan.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:fyp/view/intro.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
var myCoordinates;
var prayerTimes;

List alarms = [
  {"Name": "Fajr", "Prayer": prayerTimes.fajr},
  {"Name": "Dhuhr", "Prayer": prayerTimes.dhuhr},
  {"Name": "Asr", "Prayer": prayerTimes.asr},
  {"Name": "Maghrib", "Prayer": prayerTimes.maghrib},
  {"Name": "Isha", "Prayer": prayerTimes.isha},
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Al-Siraj'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Alarm.init();
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          "assets/splashscreen.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<void> get() async {
    Location location = new Location();
    prefs = await SharedPreferences.getInstance();
    bool _serviceEnabled;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData _locationData;
    _locationData = await location.getLocation();
    print(_locationData.latitude.toString() + "latitude");
    print(_locationData.longitude);
    myCoordinates =
        Coordinates(_locationData.latitude, _locationData.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.shafi;
    prayerTimes = PrayerTimes.today(myCoordinates, params);
    print(
        "---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");
    // print(DateFormat.jm().format(prayerTimes.fajr));
    // print(prayerTimes.fajr);
    // print(DateFormat.jm().format(prayerTimes.sunrise));
    // print(DateFormat.jm().format(prayerTimes.dhuhr));
    // print(DateFormat.jm().format(prayerTimes.asr));
    // print(DateFormat.jm().format(prayerTimes.maghrib));
    // print(DateFormat.jm().format(prayerTimes.isha));
    // print(prayerTimes.currentPrayer);
    // print(prayerTimes.currentPrayer.toString());
    // print(prayerTimes.nextPrayer.toString());
    // print(prayerTimes.nextPrayer);

    print('---');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Intro()));
  }
}
