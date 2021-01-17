import 'dart:convert';
import 'package:currency/data/model.dart';
import 'package:currency/util/networkapi.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:currency/widgets/currency_widget.dart';
import 'package:intl/intl.dart';
import 'package:currency/data/data.dart';
import 'package:currency/widgets/customwidgets.dart';
import 'dart:async';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  double offsetsize = 0;
  var sidespace = 60.0;
  int screentype = 0;
  void changeid() {
    reset();
    Datafilemanage.saveData(0);
    dataupdate();
  }

  Future loaddata() async {
    for (int i = 0; i < 6; i++) await Datafilemanage.loadData(i);
    await Datafilemanage.load_notification_time().then((value) {
      for (int i = 1; i < 11; i++) {
        if (notification_time[i] == true) {
          Map<String, String> register_data = {
            "register_token": fcmtoken,
            "time": i.toString(),
            'enable': "1"
          };
          ApiHelper.postRegister(register_data);
        }
      }
    });
  }

  // ignore: must_call_super
  void initState() {
    loaddata().then((value) {
      currencymodel.getcurrency_data(reset, cupdate[0]);
    });
    for (int i = 0; i < notificationtimename.length; i++) {
      currencymodel.getcurrency_data_2(reset, i, i + 4);
    }
    ApiHelper.getcurrency_time().then((value) {
      // value = "'" + value + "'";
      s_w_data = jsonDecode(value);
      print(s_w_data[0]["last_time"]);
    }).catchError((err) {
      print(err);
    });
    startTimer();
  }

  dataupdate() {
    currencymodel.getcurrency_data(reset, cupdate[0]);
  }

  reset() {
    setState(() {});
  }

  void startTimer() {
    new Timer.periodic(Duration(minutes: 1), (f) {
      updatetime = DateTime.now();
      dataupdate();
      ApiHelper.getcurrency_time();
    });
  }

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    sidespace = 80 * size.width / 390;
    offsetsize = offsetsize * size.height / 760;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              centerTitle: true,
              title: Text(
                "Currency Strength",
                style: TextStyle(fontSize: 25*size.width/390),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.watch_later,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialogboxwidget(changeid));
                    })
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                      Colors.grey[800],
                      Colors.black,
                      Colors.grey[800],
                    ])),
              ),
            )),
        key: _scaffoldKey,
        drawer: Menulist(changeid),
        resizeToAvoidBottomPadding: true,
        body: Padding(
            padding: EdgeInsets.only(
              left: 5 * size.width / 390,
              right: 5 * size.width / 390,
            ),
            child: Stack(
              children: [
                Positioned(
                    right: 30,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: cupdate[0] == 0
                          ? Text("Real Time")
                          : Text(
                              notificationtimename_1[cupdate[0]],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    )),
                Container(
                  child: ListView(
                    children: [
                      if (size.width < size.height)
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 30 *
                                      size.height /
                                      size.width *
                                      390 /
                                      760),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currencywidget(
                                      id: 0,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                    SizedBox(width: 10*size.width/390,),
                                    currencywidget(
                                      id: 1,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top:size.height>700? 7 *
                                      size.height /
                                      size.width *
                                      390 /
                                      760:0),
                              transform: Matrix4.translationValues(
                                  0, -1 * offsetsize * 390 / size.width, 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currencywidget(
                                      id: 2,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                    SizedBox(width: 10*size.width/390,),
                                    currencywidget(
                                      id: 3,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top:size.height>700? 7 *
                                      size.height /
                                      size.width *
                                      390 /
                                      760:0),
                              transform: Matrix4.translationValues(
                                  0, -2 * offsetsize * 390 / size.width, 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currencywidget(
                                      id: 4,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                    SizedBox(width: 10*size.width/390,),
                                    currencywidget(
                                      id: 5,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top:size.height>700? 7 *
                                      size.height /
                                      size.width *
                                      390 /
                                      760:0),
                              transform: Matrix4.translationValues(
                                  0, -3 * offsetsize * 390 / size.width, 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currencywidget(
                                      id: 6,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                    SizedBox(width: 10*size.width/390,),
                                    currencywidget(
                                      id: 7,
                                      size: (size.width - sidespace) / 2,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      if (size.width >= size.height)
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currencywidget(
                                      id: 0,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                    currencywidget(
                                      id: 1,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                    currencywidget(
                                      id: 2,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                    currencywidget(
                                      id: 3,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                  ]),
                            ),
                            Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    currencywidget(
                                      id: 4,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                    currencywidget(
                                      id: 5,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                    currencywidget(
                                      id: 6,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                    currencywidget(
                                      id: 7,
                                      size: (size.width - sidespace) / 4,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                //bottom bar
                Positioned(
                    bottom: size.width < size.height
                        ? 18 * size.height / 760
                        : 10 * size.height / 390,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 6*size.height / 760),
                          width: size.width,
                          child: Text(
                            "Updated: " +
                                DateFormat('dd MMMM yyyy h:mm aa')
                                    .format(updatetime),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (size.width < size.height)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14 * size.height / 760,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 14 * size.height / 760,
                                width: size.width - 80 * size.width / 390,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.yellow[200],
                                          Colors.yellow,
                                          Colors.red,
                                        ],
                                        stops: [
                                          0.1,
                                          0.5,
                                          0.8,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                              ),
                              Text(
                                '10',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14 * size.height / 760,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                      ],
                    ))
              ],
            )));
  }
}
