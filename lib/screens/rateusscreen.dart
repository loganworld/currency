import 'package:currency/data/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import 'package:currency/widgets/currency_widget.dart';
import 'package:intl/intl.dart';
import 'package:currency/data/data.dart';
import 'package:currency/widgets/customwidgets.dart';
import "dart:math";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:currency/datamodel/datamodel.dart';

class Rateusscreen extends StatefulWidget {
  @override
  _RateusscreenState createState() => _RateusscreenState();
}

class _RateusscreenState extends State<Rateusscreen> {
  TextStyle substyle_1 = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  TextStyle substyle_2 = TextStyle(fontSize: 16);
  double ratevalue = 3;
  @override
  void initState() {
    super.initState();
    reviewdata.add(ReviewModel());
    reviewdata.add(ReviewModel());
    reviewdata.add(ReviewModel());
    reviewdata.add(ReviewModel());
    reviewdata.add(ReviewModel());
    reviewdata.add(ReviewModel());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            "Rate us",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                //rate
                Container(
                    width: size.width,
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        RatingBar.builder(
                          initialRating: ratevalue,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            ratevalue = rating;
                          },
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                top: 0, bottom: 0, left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.amber,
                                  style: BorderStyle.solid,
                                  width: 3),
                            ),
                            child: TextField(
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: "review content",
                                  border: InputBorder.none,
                                ))),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.only(
                                top: 0, bottom: 0, left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.amber,
                                  style: BorderStyle.solid,
                                  width: 3),
                            ),
                            child: TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "name",
                                  border: InputBorder.none,
                                ))),

                        //submit
                        Container(
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            height: 40,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: RaisedButton(
                              color: Colors.amber,
                              onPressed: () {},
                              child: Text(
                                "send",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: size.width,
                    child: Text("Reviews",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold))),
                for (int i = 0; i < reviewdata.length;i++)
                  Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: 2.75,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          direction: Axis.horizontal,
                        ),
                        Text(reviewdata[i].text),
                        Text(reviewdata[i].name),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
