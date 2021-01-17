import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:ui';
import 'package:currency/widgets/currency_widget.dart';
import 'package:currency/data/data.dart';
import 'package:currency/data/model.dart';
import 'package:swipedetector/swipedetector.dart';
import 'screen1.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int offsetsize = 10;
  int spacesize = 10;
  // ignore: must_call_super
  void initState() {
    currencymodel.getcurrency_data_2(reset, cupdate[1], 0);
    currencymodel.getcurrency_data_2(reset, cupdate[2], 1);
    currencymodel.getcurrency_data_2(reset, cupdate[3], 2);
    currencymodel.getcurrency_data_2(reset, cupdate[4], 3);
  }

  reset() {
    setState(() {});
  }

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    offsetsize = (10 * size.height / 760).floor();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: currencytypedata[cid].startcolor,
          title: Text(
            currencytypedata[cid].type + ": Strength History",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        resizeToAvoidBottomPadding: true,
        body: Padding(
            padding: EdgeInsets.only(
                left: 5 * size.width / 390,
                right: 5 * size.width / 390,
                top: 20 * size.height / 750),
            child: SwipeDetector(
                onSwipeRight: () {
                  Navigator.of(context).pop();
                },
                child: Stack(
                  children: [
                    Container(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20 * size.height / 750,
                          ),
                          if (size.width < size.height)
                            Column(
                              children: [
                                Container(
                                  transform: Matrix4.translationValues(
                                      0, -0 * offsetsize * 390 / size.width, 0),
                                  child: currencywidget2(
                                    reset: reset,
                                    id: 0,
                                    size: (size.height -
                                            spacesize * size.height / 760) /
                                        4,
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(
                                      0, -1 * offsetsize * 390 / size.width, 0),
                                  child: currencywidget2(
                                    reset: reset,
                                    id: 1,
                                    size: (size.height -
                                            spacesize * size.height / 760) /
                                        4,
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(
                                      0, -2 * offsetsize * 390 / size.width, 0),
                                  child: currencywidget2(
                                    reset: reset,
                                    id: 2,
                                    size: (size.height -
                                            spacesize * size.height / 760) /
                                        4,
                                  ),
                                ),
                                Container(
                                  transform: Matrix4.translationValues(
                                      0, -3 * offsetsize * 390 / size.width, 0),
                                  child: currencywidget2(
                                    reset: reset,
                                    id: 3,
                                    size: (size.height -
                                            spacesize * size.height / 760) /
                                        4,
                                  ),
                                ),
                              ],
                            ),
                          if (size.width >= size.height)
                            Column(
                              children: [
                                SizedBox(
                                  height: 20 * size.height / 390,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0,
                                          -0 * offsetsize * 390 / size.width,
                                          0),
                                      child: currencywidget2(
                                        reset: reset,
                                        id: 0,
                                        size: (size.width -
                                                200 * size.width / 390) /
                                            2,
                                      ),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0,
                                          -1 * offsetsize * 390 / size.width,
                                          0),
                                      child: currencywidget2(
                                        reset: reset,
                                        id: 1,
                                        size: (size.width -
                                                200 * size.width / 390) /
                                            2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0,
                                          -0 * offsetsize * 390 / size.width,
                                          0),
                                      child: currencywidget2(
                                        reset: reset,
                                        id: 2,
                                        size: (size.width -
                                                200 * size.width / 390) /
                                            2,
                                      ),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(
                                          0,
                                          -1 * offsetsize * 390 / size.width,
                                          0),
                                      child: currencywidget2(
                                        reset: reset,
                                        id: 3,
                                        size: (size.width -
                                                200 * size.width / 390) /
                                            2,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
