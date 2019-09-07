import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const MAX_SCROLL_HEIGHT = 100;
  final _imageItems = [
    "https://dimg04.c-ctrip.com/images/zg05170000013cm17FDEB.jpg",
    "https://dimg04.c-ctrip.com/images/zg0e1700000134c1zC91B.jpg",
    "https://dimg04.c-ctrip.com/images/zg0d180000013l5cgA5FF.jpg"
  ];
  double _appBarAlpha = 0;

  _onScroll(offset) {
    double alpha = offset / MAX_SCROLL_HEIGHT;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Stack(children: <Widget>[
              NotificationListener(
                  onNotification: (scrollNotication) {
                    if (scrollNotication is ScrollUpdateNotification &&
                        scrollNotication.depth == 0) {
                      _onScroll(scrollNotication.metrics.pixels);
                    }
                    return true;
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                          height: 150,
                          child: Swiper(
                            itemCount: _imageItems.length,
                            autoplay: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(_imageItems[index],
                                  fit: BoxFit.fill);
                            },
                          )),
                      Container(
                        height: 800,
                        child: Center(child: Text("hello world")),
                      )
                    ],
                  )),
              Opacity(
                opacity: _appBarAlpha,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("首页"),
                  )),
                ),
              )
            ])));
  }
}
