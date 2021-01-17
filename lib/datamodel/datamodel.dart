import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import "dart:math";

class currencydata {
  String type;
  int id;
  double amount;
  Color color = Colors.green;
  double startrate;
  double endrate;
  Color startcolor;
  Color endcolor;
  currencydata(
      {this.type, this.id, this.startcolor, this.endcolor, this.amount});
}

class ReviewModel {
  double value;
  String text;
  String name;
  ReviewModel({this.value=3.8,this.text="Good apps",this.name="paul"});
}
