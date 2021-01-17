import 'dart:convert';
import 'dart:io';
import 'constants.dart' as Constants;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as httpClient;
import 'package:currency/util/constants.dart';

class ResponseModel {
  int statusCode;
  Data data;
  String jwt;
  int infoId;

  bool state;
  int timestamp;
  String base;
  String date;
  Data rates;

  ResponseModel(
      {this.state = false,
      this.timestamp = 0,
      this.base = "EUR",
      this.date = null,
      this.rates = null});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    state = json["success"];
    timestamp = json["timestamp"];
    base = json["base"];
    date = json["date"];
    rates = json["rates"] != null ? new Data.fromJson(json['rates']) : null;
  }
}

class Data {
  double AUD = 1;
  double CAD = 1;
  double CHF = 1;
  double EUR = 1;
  double GBP = 1;
  double JPY = 1;
  double NZD = 1;
  double USD = 1;
  Data();
  Data.fromJson(Map<String, dynamic> json) {
    AUD = json["AUD"];
    CAD = json["CAD"];
    CHF = json["CHF"];
    GBP = json["GBP"];
    JPY = json["JPY"];
    NZD = json["NZD"];
    USD = json["USD"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class ApiHelper {
  static Future<ResponseModel> postRequest(
      String url, Map<String, dynamic> data) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
    };

    return await httpClient
        .post(Constants.BASE_URL + url, body: jsonEncode(data), headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      ResponseModel model = ResponseModel.fromJson(json.decode(value.body));
      print("RESPONSE_MODEL");
      return model;
    }).catchError((err) {
      print('Response Error:' + err.toString());
      throw err;
    });
  }

  static Future<ResponseModel> getRequest(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      print("get: " + value.body);
      return ResponseModel.fromJson(jsonDecode(value.body));
    }).catchError((err) {
      throw err;
    });
  }

  static Future getToken(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      var data = jsonDecode(value.body.substring(3));
      Constants.ACCESSKEY = data;
    }).catchError((err) {
      throw err;
    });
  }

  static Future getHtml(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return value.body.substring(4, value.body.length - 1);
    }).catchError((err) {
      throw err;
    });
  }

  static Future getcurrency_day(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return value.body;
    }).catchError((err) {
      throw err;
    });
  }

  static Future getcurrency(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return value.body.substring(4, value.body.length - 1);
    }).catchError((err) {
      throw err;
    });
  }

  //register
  static Future postRegister(Map<String, dynamic> data) async {
/*    Map<String, String> head = {
      "Content-Type": "application/json",
    };
*/
    return await httpClient
        .post(Constants.REGISTER_TOKEN, body: data)
        .timeout(Duration(seconds: 10))
        .then((value) {
      print(value.body);
    }).catchError((err) {
      print('Response Error:' + err.toString());
      throw err;
    });
  }

  //getstrength time
  static Future getcurrency_time() async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(Constants.BASE_URL_TIME, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      print(value.body);
      return value.body;
    }).catchError((err) {
      throw err;
    });
  }
  //

}
