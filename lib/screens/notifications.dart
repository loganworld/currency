import 'package:currency/data/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'package:currency/widgets/currency_widget.dart';
import 'package:intl/intl.dart';
import 'package:currency/data/data.dart';
import 'package:currency/widgets/customwidgets.dart';
import "dart:math";
import 'dart:async';

class Notificationscreen extends StatefulWidget {
  @override
  _NotificationscreenState createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  String validate_time(String s) {
    var ctime = DateTime.parse(s);
    var duration = DateTime.now().difference(ctime);
    if (duration.inDays < 1) {
      if (duration.inHours >= 1) {
        return duration.inHours.toString() +
            "h:" +
            (duration.inMinutes - duration.inHours * 60).toString() +
            'm ago';
      } else {
        return duration.inMinutes.toString() + ' mins ago';
      }
    } else
      return DateFormat('dd MMM yy \n h:mm aa').format(ctime);
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    new Timer.periodic(Duration(minutes: 1), (f) {
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
  TextStyle substyle_1 = TextStyle(fontSize: 15*size.width/390, fontWeight: FontWeight.bold);
  TextStyle substyle_2 = TextStyle(fontSize: 16*size.width/390);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            title: Text(
              "Strongest & Weakest",
              style: TextStyle(fontSize: 25*size.width/390),
            ),
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[400]),
            height: 60,
            child: Row(
              children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80 * size.width / 390,
                          height: 30,
                          child: CustomPaint(
                            painter: Mypaint(),
                            child: Container(),
                          ),
                        ),
                        Text(
                          "Strongest",
                          style: substyle_1,
                        )
                      ]),
                ),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80 * size.width / 390,
                          height: 30,
                          child: CustomPaint(
                            painter: Mypaint_2(),
                            child: Container(),
                          ),
                        ),
                        Text(
                          "Weakest",
                          style: substyle_1,
                        )
                      ]),
                ),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80 * size.width / 390,
                          height: 30,
                        ),
                        Text(
                          "TF",
                          style: substyle_1,
                        )
                      ]),
                ),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140 * size.width / 390,
                          height: 30,
                        ),
                        Text(
                          "Updated",
                          style: substyle_1,
                        )
                      ]),
                ),
              ],
            ),
          ),
          for (int i = 1; i < notificationtimename.length; i++)
            Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(bottom: 5),
              height: 50*size.height/760,
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: 80 * size.width / 390,
                      child: Text(
                        currencytypedata2[i + 4][sortsequency_2[i + 4][0]].type,
                        style: substyle_2,
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: 80 * size.width / 390,
                      child: Text(
                        currencytypedata2[i + 4][sortsequency_2[i + 4][7]].type,
                        style: substyle_2,
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: 80 * size.width / 390,
                      child: Text(
                        "[" + notificationtimename[i] + "]",
                        style: substyle_2,
                      )),
                  Container(
                      alignment: Alignment.center,
                      width: 140 * size.width / 390,
                      child: s_w_data == null
                          ? Text(
                              DateFormat('dd MMMM yyyy h:mm aa')
                                  .format(updatetime_2[i + 4]),
                              style: substyle_2,
                            )
                          : Text(validate_time(s_w_data[10 - i]["last_time"]))),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class Mypaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size.width);
    var paint = Paint()
      ..color = Colors.redAccent[400]
      ..strokeWidth = 7 * size.width / 100
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Offset points1 = Offset(30 * size.width / 100, 20),
        points2 = Offset(70 * size.width / 100, 20);
    canvas.drawLine(points1, points2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Mypaint_2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size.width);
    var paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 7 * size.width / 100
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    Offset points1 = Offset(30 * size.width / 100, 20),
        points2 = Offset(70 * size.width / 100, 20);

    print(size.width);
    var paint_2 = Paint()
      ..color = Colors.grey
      ..strokeWidth = 7 * size.width / 100
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(points1, points2, paint_2);
    canvas.drawLine(points1, Offset(40 * size.width / 100, 20), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
