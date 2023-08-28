import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:fyp/model/theme_data.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'package:alarm/alarm.dart' as alaram;

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  bool positive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (prefs.getBool("AlarmState") != null) {
      positive=prefs.getBool("AlarmState")!;
    }
    get();
  }

  get() async {
    await alaram.Alarm.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (prayerTimes != null)
          ? SizedBox(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'assets/azan.jpg',
                            fit: BoxFit.fill,
                          ),
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/alarmback.png"),
                                    fit: BoxFit.fill)),
                            // color: Colors.grey,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 20.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          gradient: sunset,
                                          // border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 15),
                                          ]),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              alarms[index]["Name"],
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            Text(
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black),
                                                DateFormat.jm().format(
                                                    alarms[index]["Prayer"])),
                                          ],
                                        ),
                                      )),
                                );
                              },
                              itemCount: alarms.length,
                            ),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: positive,
                          first: false,
                          second: true,
                          innerColor: Colors.white38,
                          dif: 8.0,
                          borderColor: Colors.black,
                          borderWidth: 1.0,
                          height: 55,
                          // boxShadow: const [
                          //   BoxShadow(
                          //     color: Colors.black26,
                          //     spreadRadius: 1,
                          //     blurRadius: 2,
                          //     offset: Offset(0, 1.5),
                          //   ),
                          // ],
                          onChanged: (b) async {
                            print("work");
                            setState(() {
                              positive = b;
                            });
                            prefs.setBool("AlarmState", positive);
                            if (positive) {
                              for (int i = 0; i < 5; i++) {
                                DateTime now = alarms[i]["Prayer"];

                                DateTime dateTime = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  now.hour,
                                  now.minute,
                                  0,
                                  0,
                                );
                                if (dateTime.isBefore(DateTime.now())) {
                                  dateTime =
                                      dateTime.add(const Duration(days: 1));
                                }

                                final alarmSettings = alaram.AlarmSettings(
                                  id: i,
                                  // dateTime: DateTime.now().add(Duration(seconds: 10)),
                                  dateTime: dateTime,
                                  assetAudioPath: 'assets/azanalarm.mp3',
                                  loopAudio: true,
                                  vibrate: true,
                                  fadeDuration: 3.0,
                                  notificationTitle: '${alarms[i]["Name"]}',
                                  // notificationTitle: 'Its Azan time',
                                  notificationBody: 'Tap to stop',
                                  enableNotificationOnKill: true,
                                );
                                print(alarmSettings.dateTime.toString() +
                                    "work");
                                await alaram.Alarm.set(
                                    alarmSettings: alarmSettings);
                              }
                            } else {
                              for (int i = 0; i < 5; i++) {
                                alaram.Alarm.stop(i);
                              }
                            }
                          },
                          colorBuilder: (b) => b ? Colors.green : Colors.red,
                          iconBuilder: (value) => value
                              ? Icon(Icons.alarm_on)
                              : Icon(Icons.alarm_off),
                          textBuilder: (value) => value
                              ? Center(child: Text('ON ^_^'))
                              : Center(child: Text('OFF :(')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}
