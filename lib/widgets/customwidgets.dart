import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:currency/data/data.dart';
import 'package:currency/data/model.dart';

class Dialogboxwidget extends StatefulWidget {
  int id = 0;
  var reset;
  Dialogboxwidget(this.reset, {this.id = 0});
  @override
  _DialogboxwidgetState createState() => _DialogboxwidgetState(reset, id: id);
}

class _DialogboxwidgetState extends State<Dialogboxwidget> {
  var reset;
  int id = 0;
  int cvalue = 0;
  SwiperController _swiperController = SwiperController();
  _DialogboxwidgetState(this.reset, {this.id = 0});

  @override
  void initState() {
    if (id == 0)
      cvalue = cupdate[id];
    else
      cvalue = cupdate[id] - 1;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: GestureDetector(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(color: Colors.black.withAlpha(100)),
              child: Text(""),
            ),
            onTap: () {
              Navigator.pop(context);
              if (id > 0) Datafilemanage.saveData(id);
              if (id > 0)
                currencymodel.getcurrency_data_2(reset, cupdate[id], id - 1);
              reset();
            },
          ),
        ),
        if (id == 0)
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 220),
              height: size.height > size.width
                  ? 100 * size.width / 390
                  : 100 * size.width / 760,
              width: size.width - 60,
              child: Swiper(
                viewportFraction: 0.5,
                fade: 0.1,
                scale: 0.3,
                index: cvalue,
                itemCount: notificationtimename.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      cupdate[id] = cvalue;
                      Navigator.pop(context);
                      if (id > 0) Datafilemanage.saveData(id);
                      if (id > 0)
                        currencymodel.getcurrency_data_2(
                            reset, cupdate[id], id - 1);
                      reset();
                    },
                    child: Container(
                        width: 100,
                        height: size.height / 3,
                        alignment: Alignment.center,
                        child: index == 0
                            ? Text("Real  \n Time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height > size.width
                                        ? 35 * size.width / 390
                                        : 35 * size.width / 760,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.none))
                            : Text(notificationtimename[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height > size.width
                                        ? 35 * size.width / 390
                                        : 35 * size.width / 760,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.none))),
                  );
                },
                controller: _swiperController,
                onIndexChanged: (value) {
                  cvalue = value;
                },
              )),
        if (id > 0)
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 220),
              height: 100,
              width: size.width - 60,
              child: Swiper(
                viewportFraction: 0.5,
                fade: 0.1,
                scale: 0.3,
                index: cvalue,
                itemCount: notificationtimename.length - 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        cupdate[id] = cvalue + 1;
                        Navigator.pop(context);
                        if (id > 0) Datafilemanage.saveData(id);
                        if (id > 0)
                          currencymodel.getcurrency_data_2(
                              reset, cupdate[id], id - 1);
                        reset();
                      },
                      child: Container(
                          width: 100,
                          height: size.height / 3,
                          alignment: Alignment.center,
                          child: Text(notificationtimename[index + 1],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height > size.width
                                      ? 35 * size.width / 390
                                      : 35 * size.width / 760,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.none))));
                },
                controller: _swiperController,
                onIndexChanged: (value) {
                  cvalue = value;
                },
              ))
      ],
    ));
  }
}
