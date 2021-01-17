import 'dart:async';
import 'package:currency/data/model.dart';
import 'package:currency/util/networkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import "dart:math";
import "package:currency/screens/screen1.dart";
import "package:currency/screens/notifications.dart";
import "package:currency/screens/webview.dart";
import "package:currency/screens/rateusscreen.dart";
import 'data/data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'package:shared_preferences/shared_preferences.dart';
//backgroundservice handler

Future getnotificationstrange() async {
  for (int i = 0; i < notificationtimename.length; i++) {
    currencymodel.getcurrency_data_2(() {}, i, i + 4);
  }
}

Future loadnotificationdata() async {
  for (int i = 0; i < notificationtimename.length; i++) {
    Datafilemanage.loadData(i + 4);
  }
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    print("notification");
    shownotification();
  });
  /* getnotificationstrange().then((v) {
    loadnotificationdata().then((value) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              channelKey: 'basic_channel',
              title: notificationtimename[cupdate[5]] + ' update',
              body: currencytypedata2[4][sortsequency_2[4][0]].type +
                  currencytypedata2[4][sortsequency_2[4][7]].type));
    });
  });
*/
}

//localnotificationinit
void localnotificationinit(context) {
  AwesomeNotifications().initialize("", [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel ',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ]);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // Insert here your friendly dialog box before call the request method
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  AwesomeNotifications().actionStream.listen((receivedNotification) {
    Navigator.push(context, _createRoute_2());
  });
}

//backgroundseviceinit
void backgroundserviceinit() {
  Workmanager.initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
}

Future shownotification() {
  getnotificationstrange();
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: notificationtimename[cupdate[5]] + ' update',
          body: "Strength :" +
              currencytypedata2[4][sortsequency_2[4][0]].type +
              " " +
              "Lowest :" +
              currencytypedata2[4][sortsequency_2[4][7]].type));
}

//main
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(title: 'distant', debugShowCheckedModeBanner: false, routes: {
    '/': (context) => Dashboard(),
    '/screen1': (context) => Screen1(),
    '/notifications': (context) => Notificationscreen()
  }));
}

//class Dashboard
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int freenum = 7;
  bool startactive = false;

  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  void notificationrecieve() {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.subscribeToTopic("currency");
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        Navigator.push(context, _createRoute_2());
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Navigator.push(context, _createRoute_2());
      },
    );

    _fcm.requestNotificationPermissions(const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: true));
  }

  _saveDeviceToken() async {
    // Get the current user
    String uid = 'kni';
    //  FirebaseUser user = await _auth.currentUser();
    // Get the token for this device
    fcmtoken = await _fcm.getToken();
    // Save it to Firestore
  }
//getdata

  void initState() {
    //pushnotification init
    notificationrecieve();
    //local notification init
    //  localnotificationinit(context);
    //backgrounf service
    //  backgroundserviceinit();
    //screen rotation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    updatetime = DateTime.now();
    currencymodel.initalizecurrencydata();
    ApiHelper.getToken("http://zapp.fxsonic.com/api/token");
    installed().then((value) {
      if (value) Navigator.push(context, _createRoute());
    });
    //   Workmanager.registerOneOffTask("1", "simpleTask");
  }

  Future<bool> installed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool flag = (prefs.getBool("installed") ?? false);
    prefs.setBool("installed", true);
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Stack(alignment: Alignment.topCenter, children: [
        Column(
          children: [
            SizedBox(
              height: 100 * size.height / 750,
            ),
            Text(
              "Fx Power Meter",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black87,
                  fontSize: 37 * size.width / 390,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1),
            ),
            //logo
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 30),
                width: 330 * size.width / 390,
                child: Image(image: AssetImage('assets/logo.png'))),
            //buttons
            Container(
                child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  freenum.toString() + "-Day Free Trial",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24 * size.width / 390,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(
                          colors: [
                            Colors.grey[700],
                            Colors.grey[900],
                            Colors.grey[700],
                          ],
                          stops: [
                            0.1,
                            0.5,
                            0.9
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  height: 55 * size.width / 390,
                  child: RaisedButton(
                    color: Colors.grey.withAlpha(30),
                    padding: EdgeInsets.only(
                        left: 100, right: 100, top: 8, bottom: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () {
                      /*        shownotification();
                      //              Workmanager.registerOneOffTask("1", "simpleTask");
                      Workmanager.registerPeriodicTask(
                        "5",
                        "notification",
                        frequency: Duration(minutes: 15),
                      );
              */
                      Navigator.push(context, _createRoute());
                    },
                    child: Text(
                      "Start",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28 * size.width / 390,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
        Positioned(
            bottom: 40 * size.height / 750,
            child: Column(
              children: [
                Text(
                  "By signing up you agree to",
                  style: TextStyle(
                      fontSize: 16 * size.width / 390, letterSpacing: 0.1),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Text("our ",
                        style: TextStyle(
                            fontSize: 16 * size.width / 390,
                            letterSpacing: 0.1)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, _createRoute_3(5));
                      },
                      child: Text("Term of Service",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16 * size.width / 390,
                              letterSpacing: 0.1)),
                    ),
                    Text(" and ",
                        style: TextStyle(
                            fontSize: 16 * size.width / 390,
                            letterSpacing: 0.1)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, _createRoute_3(4));
                      },
                      child: Text("Privacy Policy",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16 * size.width / 390,
                              letterSpacing: 0.1)),
                    ),
                  ],
                )
              ],
            ))
      ]),
    )));
  }
}

class Menulist extends StatefulWidget {
  var changeid;
  Menulist(this.changeid);
  @override
  _MenulistState createState() => _MenulistState(changeid);
}

class _MenulistState extends State<Menulist> {
  int stateflag = 0;
  var changeid;
  _MenulistState(this.changeid);
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle substyle = TextStyle(
        fontSize: 20, fontFamily: "Montserrat", fontWeight: FontWeight.w600);
    return Drawer(
        child: ListView(children: [
      if (stateflag == 0)
        Container(
          height: 60,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(top: 20, left: 20),
          decoration: BoxDecoration(color: Colors.grey[350]),
          child: Text(
            'Fx Power Meter',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      if (stateflag == 1)
        Container(
          height: 60,
          padding: EdgeInsets.only(top: 20, left: 10),
          decoration: BoxDecoration(color: Colors.grey[350]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                padding: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black),
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onTap: () {
                    setState(() {
                      stateflag = 0;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                'Alert Setting',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      if (stateflag == 0)
        Column(
          children: [
            GestureDetector(
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("assets/strong_icon.png"),
                        height: 25,
                      ),
                      Text(
                        ' Strongest & Weakest',
                        style: substyle,
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.push(context, _createRoute_2());
              },
            ),
            GestureDetector(
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.notifications),
                      Text(
                        ' Alert Setting',
                        style: substyle,
                      ),
                    ],
                  )),
              onTap: () {
                setState(() {
                  stateflag = 1;
                });
              },
            ),
            /*         GestureDetector(
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.grade_rounded),
                      Text(
                        ' Rate us',
                        style: substyle,
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.push(context, _createRoute_3(0));
              },
            ),
   */
            GestureDetector(
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.near_me),
                      Text(
                        ' Support',
                        style: substyle,
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.push(context, _createRoute_3(1));
              },
            ),
            GestureDetector(
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.business),
                      Text(
                        ' About us',
                        style: substyle,
                      ),
                    ],
                  )),
              onTap: () {
                Navigator.push(context, _createRoute_3(2));
              },
            ),
          ],
        ),
      if (stateflag == 1)
        Column(
          children: [
            //title
            Container(
              width: size.width,
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Text(
                'Strongest-Weakest by timeframe',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(color: Colors.grey[200]),
            ),
            GestureDetector(
              onTap: () {
                if (notification_time[0] == true)
                  for (int i = 1; i < 11; i++) {
                    setState(() {
                      notification_time[0] = false;
                      notification_time[i] = false;
                      Map<String, String> register_data = {
                        "register_token": fcmtoken,
                        "time": i.toString(),
                        'enable': "0"
                      };
                      ApiHelper.postRegister(register_data);
                      Datafilemanage.save_notification_time();
                    });
                  }
                else
                  setState(() {
                    notification_time[0] = true;
                  });
              },
              //show notification
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                width: size.width,
                height: 40,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 40,
                      child: Text(
                        "Show Alert",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        right: 20,
                        child: Switch(
                          value: notification_time[0],
                          onChanged: (value) {
                            if (value == false)
                              for (int i = 1; i < 11; i++) {
                                setState(() {
                                  notification_time[0] = false;
                                  notification_time[i] = false;
                                  Map<String, String> register_data = {
                                    "register_token": fcmtoken,
                                    "time": i.toString(),
                                    'enable': "0"
                                  };
                                  ApiHelper.postRegister(register_data);
                                  Datafilemanage.save_notification_time();
                                });
                              }
                            else
                              setState(() {
                                notification_time[0] = true;
                              });
                          },
                        ))
                  ],
                ),
              ),
            ),
            //timeset
            SizedBox(
              height: 10,
            ),
            for (int i = 1; i < 11; i++)
              GestureDetector(
                onTap: () {
                  notification_time[i] = !notification_time[i];
                  if (notification_time[i] == true)
                    setState(() {
                      notification_time[0] = true;
                      Map<String, String> register_data = {
                        "register_token": fcmtoken,
                        "time": i.toString(),
                        'enable': "1"
                      };
                      ApiHelper.postRegister(register_data);
                      Datafilemanage.save_notification_time();
                    });
                  else {
                    int fflag = 0;
                    for (int j = 1; j < 11; j++) {
                      if (notification_time[j] == true) fflag = 1;
                    }
                    if (fflag == 0) notification_time[0] = false;
                    setState(() {
                      Map<String, String> register_data = {
                        "register_token": fcmtoken,
                        "time": i.toString(),
                        'enable': "0"
                      };
                      ApiHelper.postRegister(register_data);
                      Datafilemanage.save_notification_time();
                    });
                  }
                },
                child: Container(
                  width: size.width,
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 40,
                        child: Text(
                          notificationtimename_1[i],
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                          right: 20,
                          child: Switch(
                            value: notification_time[i],
                            onChanged: (value) {
                              if (value == true)
                                setState(() {
                                  notification_time[0] = true;
                                  notification_time[i] = true;
                                  Map<String, String> register_data = {
                                    "register_token": fcmtoken,
                                    "time": i.toString(),
                                    'enable': "1"
                                  };
                                  ApiHelper.postRegister(register_data);
                                  Datafilemanage.save_notification_time();
                                });
                              else {
                                setState(() {
                                  notification_time[i] = false;
                                  Map<String, String> register_data = {
                                    "register_token": fcmtoken,
                                    "time": i.toString(),
                                    'enable': "0"
                                  };
                                  ApiHelper.postRegister(register_data);
                                  Datafilemanage.save_notification_time();
                                });
                              }
                            },
                          ))
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        )
    ]));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Screen1(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute_2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        Notificationscreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute_3(int id) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Webviewscreen(
      id: id,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute_4() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Rateusscreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
