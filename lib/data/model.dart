import 'dart:convert';
import 'dart:math';

import "data.dart";
import '../datamodel/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:currency/util/networkapi.dart';
import 'package:currency/util/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class currencymodel {
  static void initalizecurrencydata() {
    currencytypedata.add(currencydata(
        type: "EUR",
        id: 0,
        startcolor: Color(0xFF3143eb),
        endcolor: Color(0xFF4c05c1),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "NZD",
        id: 1,
        startcolor: Color(0xFFfce41f),
        endcolor: Color(0xFFe6c303),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "CHF",
        id: 2,
        startcolor: Color(0xFFf538f0),
        endcolor: Color(0xFFe81582),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "JPY",
        id: 3,
        startcolor: Color(0xFF15FF00),
        endcolor: Color(0xFF18DA06),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "CAD",
        id: 4,
        startcolor: Color(0xFFffb519),
        endcolor: Color(0xFFff8d19),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "GBP",
        id: 5,
        startcolor: Color(0xFF31ddfa),
        endcolor: Color(0xFF0395c5),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "USD",
        id: 6,
        startcolor: Color(0xFFff2d39),
        endcolor: Color(0xFFd51719),
        amount: 1));
    currencytypedata.add(currencydata(
        type: "AUD",
        id: 7,
        startcolor: Color(0xFFa449e5),
        endcolor: Color(0xFF8823d0),
        amount: 1));
    for (int i = 0; i < notificationtimename.length + 4; i++) {
      List<currencydata> cdata = [];
      currencytypedata2.add(cdata);
      currencytypedata2[i].add(currencydata(
          type: "EUR",
          id: 0,
          startcolor: Color(0xFF3143eb),
          endcolor: Color(0xFF4c05c1),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "NZD",
          id: 1,
          startcolor: Color(0xFFfce41f),
          endcolor: Color(0xFFe6c303),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "CHF",
          id: 2,
          startcolor: Color(0xFFf538f0),
          endcolor: Color(0xFFe81582),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "JPY",
          id: 3,
          startcolor: Color(0xFF00ff2c),
          endcolor: Color(0xFF18cb00),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "CAD",
          id: 4,
          startcolor: Color(0xFFffb519),
          endcolor: Color(0xFFff8d19),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "GBP",
          id: 5,
          startcolor: Color(0xFF31ddfa),
          endcolor: Color(0xFF0395c5),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "USD",
          id: 6,
          startcolor: Color(0xFFff2d39),
          endcolor: Color(0xFFd51719),
          amount: 1));
      currencytypedata2[i].add(currencydata(
          type: "AUD",
          id: 7,
          startcolor: Color(0xFFa449e5),
          endcolor: Color(0xFF8823d0),
          amount: 1));
    }
  }

  static getstartrate(reset, int pasttimeid) {
    ApiHelper.getRequest(
            BASE_URL + "/latest" + "?access_key=" + ACCESSKEY + BASESTRUCT)
        .then((data) {
      print(data.rates.AUD);
      currencytypedata[0].startrate = data.rates.EUR;
      currencytypedata[1].startrate = data.rates.NZD;
      currencytypedata[2].startrate = data.rates.CHF;
      currencytypedata[3].startrate = data.rates.JPY;
      currencytypedata[4].startrate = data.rates.CAD;
      currencytypedata[5].startrate = data.rates.GBP;
      currencytypedata[6].startrate = data.rates.USD;
      currencytypedata[7].startrate = data.rates.AUD;
      getendrate(reset, pasttimeid);
    }).catchError((err) {
      print(err);
    });
  }

  static getendrate(reset, int pasttimeid) {
    var date = new DateTime.now().toUtc();
    var lastdate;
    if (pasttimeid < 4)
      lastdate =
          date.subtract(new Duration(minutes: notificationtime[pasttimeid]));
    else if (pasttimeid < 7)
      lastdate =
          date.subtract(new Duration(hours: notificationtime[pasttimeid]));
    else if (pasttimeid < 9)
      lastdate =
          date.subtract(new Duration(days: notificationtime[pasttimeid]));
    else if (pasttimeid < 10)
      lastdate =
          date.subtract(new Duration(days: 30 * notificationtime[pasttimeid]));
    else
      lastdate =
          date.subtract(new Duration(days: 365 * notificationtime[pasttimeid]));
    ApiHelper.getRequest(BASE_URL +
            DateFormat('yyyy-MM-dd').format(lastdate) +
            "?access_key=" +
            ACCESSKEY +
            BASESTRUCT)
        .then((data) {
      print(data.rates.AUD);
      currencytypedata[0].endrate = data.rates.EUR;
      currencytypedata[1].endrate = data.rates.NZD;
      currencytypedata[2].endrate = data.rates.CHF;
      currencytypedata[3].endrate = data.rates.JPY;
      currencytypedata[4].endrate = data.rates.CAD;
      currencytypedata[5].endrate = data.rates.GBP;
      currencytypedata[6].endrate = data.rates.USD;
      currencytypedata[7].endrate = data.rates.AUD;
      sortdata();
      reset();
    }).catchError((err) {
      print(err);
    });
  }

  static sortdata() {
    for (int i = 0; i < 8; i++)
      for (int j = i + 1; j < 8; j++) {
        if (currencytypedata[sortsequency[i]].endrate /
                currencytypedata[sortsequency[i]].startrate <
            currencytypedata[sortsequency[j]].endrate /
                currencytypedata[sortsequency[j]].startrate) {
          int temp = sortsequency[i];
          sortsequency[i] = sortsequency[j];
          sortsequency[j] = temp;
        }
      }

    for (int i = 0; i < 8; i++) {
      currencytypedata[i].amount = (currencytypedata[i].endrate /
              currencytypedata[i].startrate *
              currencytypedata[sortsequency[7]].startrate /
              currencytypedata[sortsequency[7]].endrate -
          0.995);
      print(currencytypedata[i].type + currencytypedata[i].amount.toString());
    }
    double ratesum = 0;
    for (int i = 0; i < 8; i++) {
      ratesum += currencytypedata[i].amount;
    }

    for (int i = 0; i < 8; i++) {
      currencytypedata[i].amount =
          sqrt(currencytypedata[i].amount / ratesum) * 10 + 1;
    }
  }

//screen2 getdata and sort
  static getstartrate_2(reset, int pasttimeid, int id) {
    ApiHelper.getRequest(
            BASE_URL + "/latest" + "?access_key=" + ACCESSKEY + BASESTRUCT)
        .then((data) {
      print(data.rates.AUD);
      currencytypedata2[id][0].startrate = data.rates.EUR;
      currencytypedata2[id][1].startrate = data.rates.NZD;
      currencytypedata2[id][2].startrate = data.rates.CHF;
      currencytypedata2[id][3].startrate = data.rates.JPY;
      currencytypedata2[id][4].startrate = data.rates.CAD;
      currencytypedata2[id][5].startrate = data.rates.GBP;
      currencytypedata2[id][6].startrate = data.rates.USD;
      currencytypedata2[id][7].startrate = data.rates.AUD;
      getendrate_2(reset, pasttimeid, id);
    }).catchError((err) {
      print(err);
    });
  }

  static getendrate_2(reset, int pasttimeid, int id) {
    var date = new DateTime.now();
    var lastdate;
    if (pasttimeid < 4)
      lastdate =
          date.subtract(new Duration(minutes: notificationtime[pasttimeid]));
    else if (pasttimeid < 7)
      lastdate =
          date.subtract(new Duration(hours: notificationtime[pasttimeid]));
    else if (pasttimeid < 9)
      lastdate =
          date.subtract(new Duration(days: notificationtime[pasttimeid]));
    else if (pasttimeid < 10)
      lastdate =
          date.subtract(new Duration(days: 30 * notificationtime[pasttimeid]));
    else
      lastdate =
          date.subtract(new Duration(days: 365 * notificationtime[pasttimeid]));
    ApiHelper.getRequest(BASE_URL +
            DateFormat('yyyy-MM-dd').format(lastdate) +
            "?access_key=" +
            ACCESSKEY +
            BASESTRUCT)
        .then((data) {
      print(data.rates.AUD);
      currencytypedata2[id][0].endrate = data.rates.EUR;
      currencytypedata2[id][1].endrate = data.rates.NZD;
      currencytypedata2[id][2].endrate = data.rates.CHF;
      currencytypedata2[id][3].endrate = data.rates.JPY;
      currencytypedata2[id][4].endrate = data.rates.CAD;
      currencytypedata2[id][5].endrate = data.rates.GBP;
      currencytypedata2[id][6].endrate = data.rates.USD;
      currencytypedata2[id][7].endrate = data.rates.AUD;
      sortdata_2(id);
      reset();
    }).catchError((err) {
      print(err);
    });
  }

  static sortdata_2(int id) {
    for (int i = 0; i < 8; i++)
      for (int j = i + 1; j < 8; j++) {
        if (currencytypedata2[id][sortsequency_2[id][i]].endrate /
                currencytypedata2[id][sortsequency_2[id][i]].startrate <
            currencytypedata2[id][sortsequency_2[id][j]].endrate /
                currencytypedata2[id][sortsequency_2[id][j]].startrate) {
          int temp = sortsequency_2[id][i];
          sortsequency_2[id][i] = sortsequency_2[id][j];
          sortsequency_2[id][j] = temp;
        }
      }

    for (int i = 0; i < 8; i++) {
      currencytypedata2[id][i].amount = (currencytypedata2[id][i].endrate /
              currencytypedata2[id][i].startrate *
              currencytypedata2[id][sortsequency_2[id][7]].startrate /
              currencytypedata2[id][sortsequency_2[id][7]].endrate -
          0.995);
      print(currencytypedata2[id][i].type +
          currencytypedata2[id][i].amount.toString());
    }
    double ratesum = 0;
    for (int i = 0; i < 8; i++) {
      ratesum += currencytypedata2[id][i].amount;
    }

    for (int i = 0; i < 8; i++) {
      currencytypedata2[id][i].amount =
          sqrt(currencytypedata2[id][i].amount / ratesum) * 9 + 1;
    }
  }

  static getcurrency_data(reset, int pasttimeid) {
    if (pasttimeid == 0)
      ApiHelper.getcurrency_day(BASE_URL_minute + "1mins").then((value) {
        var jvalue = jsonDecode(value);
        currencytypedata[0].endrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["previous_price"]);
        currencytypedata[0].startrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["price"]);
        currencytypedata[1].endrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["previous_price"]);
        currencytypedata[1].startrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["price"]);
        currencytypedata[2].endrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["previous_price"]);
        currencytypedata[2].startrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["price"]);
        currencytypedata[3].endrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["previous_price"]);
        currencytypedata[3].startrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["price"]);
        currencytypedata[4].endrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["previous_price"]);
        currencytypedata[4].startrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["price"]);
        currencytypedata[5].endrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["previous_price"]);
        currencytypedata[5].startrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["price"]);
        currencytypedata[6].endrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["previous_price"]);
        currencytypedata[6].startrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["price"]);
        currencytypedata[7].endrate = 1;
        currencytypedata[7].startrate = 1;
        sortdata();
        reset();
      });
    else if (pasttimeid < 7)
      ApiHelper.getcurrency_day(
              BASE_URL_minute + notificationtimename[pasttimeid])
          .then((value) {
        var jvalue = jsonDecode(value);
        currencytypedata[0].endrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["previous_price"]);
        currencytypedata[0].startrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["price"]);
        currencytypedata[1].endrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["previous_price"]);
        currencytypedata[1].startrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["price"]);
        currencytypedata[2].endrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["previous_price"]);
        currencytypedata[2].startrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["price"]);
        currencytypedata[3].endrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["previous_price"]);
        currencytypedata[3].startrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["price"]);
        currencytypedata[4].endrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["previous_price"]);
        currencytypedata[4].startrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["price"]);
        currencytypedata[5].endrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["previous_price"]);
        currencytypedata[5].startrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["price"]);
        currencytypedata[6].endrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["previous_price"]);
        currencytypedata[6].startrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["price"]);
        currencytypedata[7].endrate = 1;
        currencytypedata[7].startrate = 1;

        sortdata();
        reset();
      });
    else {
      var date = new DateTime.now().toUtc();
      var lastdate;
      if (pasttimeid < 9)
        lastdate =
            date.subtract(new Duration(days: notificationtime[pasttimeid]));
      else if (pasttimeid < 10)
        lastdate = date
            .subtract(new Duration(days: 30 * notificationtime[pasttimeid]));
      else
        lastdate = date
            .subtract(new Duration(days: 365 * notificationtime[pasttimeid]));
      ApiHelper.getcurrency_day(
              BASE_URL_DAY + DateFormat('yyyy-MM-dd').format(lastdate))
          .then((value) {
        print(value);
        var jvalue = jsonDecode(value);
        String t = jvalue["data"]["AUD"]["EUR"]["previous_price"].toString();
        currencytypedata[0].endrate =
            jvalue["data"]["AUD"]["EUR"]["previous_price"];
        currencytypedata[0].startrate = jvalue["data"]["AUD"]["EUR"]["price"];
        currencytypedata[1].endrate =
            jvalue["data"]["AUD"]["NZD"]["previous_price"];
        currencytypedata[1].startrate = jvalue["data"]["AUD"]["NZD"]["price"];
        currencytypedata[2].endrate =
            jvalue["data"]["AUD"]["CHF"]["previous_price"];
        currencytypedata[2].startrate = jvalue["data"]["AUD"]["CHF"]["price"];
        currencytypedata[3].endrate =
            jvalue["data"]["AUD"]["JPY"]["previous_price"];
        currencytypedata[3].startrate = jvalue["data"]["AUD"]["JPY"]["price"];
        currencytypedata[4].endrate =
            jvalue["data"]["AUD"]["CAD"]["previous_price"];
        currencytypedata[4].startrate = jvalue["data"]["AUD"]["CAD"]["price"];
        currencytypedata[5].endrate =
            jvalue["data"]["AUD"]["GBP"]["previous_price"];
        currencytypedata[5].startrate = jvalue["data"]["AUD"]["GBP"]["price"];
        currencytypedata[6].endrate =
            jvalue["data"]["AUD"]["USD"]["previous_price"];
        currencytypedata[6].startrate = jvalue["data"]["AUD"]["USD"]["price"];
        currencytypedata[7].endrate = 1;
        currencytypedata[7].startrate = 1;

        sortdata();
        reset();
      }).catchError((err) {
        print(err);
      });
    }
  }

  static getcurrency_data_2(reset, int pasttimeid, int id) {
    if (pasttimeid == 0)
      ApiHelper.getcurrency_day(BASE_URL_minute + "1mins").then((value) {
        var jvalue = jsonDecode(value);
        currencytypedata2[id][0].endrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["previous_price"]);
        currencytypedata2[id][0].startrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["price"]);
        currencytypedata2[id][1].endrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["previous_price"]);
        currencytypedata2[id][1].startrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["price"]);
        currencytypedata2[id][2].endrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["previous_price"]);
        currencytypedata2[id][2].startrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["price"]);
        currencytypedata2[id][3].endrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["previous_price"]);
        currencytypedata2[id][3].startrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["price"]);
        currencytypedata2[id][4].endrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["previous_price"]);
        currencytypedata2[id][4].startrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["price"]);
        currencytypedata2[id][5].endrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["previous_price"]);
        currencytypedata2[id][5].startrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["price"]);
        currencytypedata2[id][6].endrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["previous_price"]);
        currencytypedata2[id][6].startrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["price"]);
        currencytypedata2[id][7].endrate = 1;
        currencytypedata2[id][7].startrate = 1;
        sortdata_2(id);
        reset();
      });
    else if (pasttimeid < 7)
      ApiHelper.getcurrency_day(
              BASE_URL_minute + notificationtimename[pasttimeid])
          .then((value) {
        var jvalue = jsonDecode(value);
        currencytypedata2[id][0].endrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["previous_price"]);
        currencytypedata2[id][0].startrate =
            double.parse(jvalue["data"]["AUD"]["EUR"]["price"]);
        currencytypedata2[id][1].endrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["previous_price"]);
        currencytypedata2[id][1].startrate =
            double.parse(jvalue["data"]["AUD"]["NZD"]["price"]);
        currencytypedata2[id][2].endrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["previous_price"]);
        currencytypedata2[id][2].startrate =
            double.parse(jvalue["data"]["AUD"]["CHF"]["price"]);
        currencytypedata2[id][3].endrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["previous_price"]);
        currencytypedata2[id][3].startrate =
            double.parse(jvalue["data"]["AUD"]["JPY"]["price"]);
        currencytypedata2[id][4].endrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["previous_price"]);
        currencytypedata2[id][4].startrate =
            double.parse(jvalue["data"]["AUD"]["CAD"]["price"]);
        currencytypedata2[id][5].endrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["previous_price"]);
        currencytypedata2[id][5].startrate =
            double.parse(jvalue["data"]["AUD"]["GBP"]["price"]);
        currencytypedata2[id][6].endrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["previous_price"]);
        currencytypedata2[id][6].startrate =
            double.parse(jvalue["data"]["AUD"]["USD"]["price"]);
        currencytypedata2[id][7].endrate = 1;
        currencytypedata2[id][7].startrate = 1;

        sortdata_2(id);
        reset();
      });
    else {
      var date = new DateTime.now().toUtc();
      var lastdate;
      if (pasttimeid < 9)
        lastdate =
            date.subtract(new Duration(days: notificationtime[pasttimeid]));
      else if (pasttimeid < 10)
        lastdate = date
            .subtract(new Duration(days: 30 * notificationtime[pasttimeid]));
      else
        lastdate = date
            .subtract(new Duration(days: 365 * notificationtime[pasttimeid]));
      ApiHelper.getcurrency_day(
              BASE_URL_DAY + DateFormat('yyyy-MM-dd').format(lastdate))
          .then((value) {
        print(value);
        var jvalue = jsonDecode(value);
        String t = "";
        currencytypedata2[id][0].endrate =
            jvalue["data"]["AUD"]["EUR"]["previous_price"];
        currencytypedata2[id][0].startrate =
            jvalue["data"]["AUD"]["EUR"]["price"];
        currencytypedata2[id][1].endrate =
            jvalue["data"]["AUD"]["NZD"]["previous_price"];
        currencytypedata2[id][1].startrate =
            jvalue["data"]["AUD"]["NZD"]["price"];
        currencytypedata2[id][2].endrate =
            jvalue["data"]["AUD"]["CHF"]["previous_price"];
        currencytypedata2[id][2].startrate =
            jvalue["data"]["AUD"]["CHF"]["price"];
        currencytypedata2[id][3].endrate =
            jvalue["data"]["AUD"]["JPY"]["previous_price"];
        currencytypedata2[id][3].startrate =
            jvalue["data"]["AUD"]["JPY"]["price"];
        currencytypedata2[id][4].endrate =
            jvalue["data"]["AUD"]["CAD"]["previous_price"];
        currencytypedata2[id][4].startrate =
            jvalue["data"]["AUD"]["CAD"]["price"];
        currencytypedata2[id][5].endrate =
            jvalue["data"]["AUD"]["GBP"]["previous_price"];
        currencytypedata2[id][5].startrate =
            jvalue["data"]["AUD"]["GBP"]["price"];
        currencytypedata2[id][6].endrate =
            jvalue["data"]["AUD"]["USD"]["previous_price"];
        currencytypedata2[id][6].startrate =
            jvalue["data"]["AUD"]["USD"]["price"];
        currencytypedata2[id][7].endrate = 1;
        currencytypedata2[id][7].startrate = 1;

        sortdata_2(id);
        reset();
      }).catchError((err) {
        print(err);
      });
    }
  }
}

class Datafilemanage {
  static Future loadData(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (i == 0) cupdate[i] = (prefs.getInt('cupdate' + i.toString()) ?? 0);
    if (i == 1) cupdate[i] = (prefs.getInt('cupdate' + i.toString()) ?? 3);
    if (i == 2) cupdate[i] = (prefs.getInt('cupdate' + i.toString()) ?? 5);
    if (i == 3) cupdate[i] = (prefs.getInt('cupdate' + i.toString()) ?? 7);
    if (i == 4) cupdate[i] = (prefs.getInt('cupdate' + i.toString()) ?? 8);
  }

  static saveData(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("cupdate" + i.toString(), cupdate[i]);
  }

  static Future load_notification_time() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 12; i++)
      if (i == 7||i==0)
        notification_time[i] =
            (prefs.getBool('notification_time' + i.toString()) ?? true);
      else
        notification_time[i] =
            (prefs.getBool('notification_time' + i.toString()) ?? false);
  }

  static save_notification_time() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 12; i++)
      prefs.setBool("notification_time" + i.toString(), notification_time[i]);
  }

  static Future savestrongest(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("strong" + i.toString(), sortsequency_2[i][7]);
    prefs.setInt("lowest" + i.toString(), sortsequency_2[i][0]);
    prefs.setString(
      "updatedate" + i.toString(),
      DateTime.now().toString(),
    );
  }

  static Future loadstrongest(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int strong = prefs.getInt("strong" + i.toString());
    int lowest = prefs.getInt("lowest" + i.toString());
    if (strong != sortsequency_2[i][7] || lowest != sortsequency_2[i][0]) {
      savestrongest(i);
      updatetime_2[i] = DateTime.now();
    } else {
      updatetime_2[i] =
          DateTime.parse(prefs.getString("updatedate" + i.toString()));
    }
  }
}
