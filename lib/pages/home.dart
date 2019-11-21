import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:demo02/service/service_mothed.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String responseTv = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Center(
          child: FutureBuilder(
              future: getHomePageContent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = json.decode(snapshot.data.toString());
                  List<Map> swiper = (data['data']['slides'] as List).cast();
                  List<Map> navigatorList =
                      (data['data']['category'] as List).cast();
                  String adPrcture =
                      data['data']['advertesPicture']['PICTURE_ADDRESS'];
                  if (navigatorList.length > 10) {
                    navigatorList.removeRange(10, navigatorList.length);
                  }
                  return Column(
                    children: <Widget>[
                      SwiperDiy(
                        swiperDateList: swiper,
                      ),
                      TopNavigator(
                        navigatorList: navigatorList,
                      ),
                      AdBanner(
                        adPicture: adPrcture,
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("服务器挂了"),
                  );
                }
              })),
    ));
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({Key key, this.swiperDateList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDateList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        transformer: ScaleAndFadeTransformer(),
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _grideViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(350),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _grideViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImg;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImg, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[Text(leaderPhone), Image.network(leaderImg)],
      ),
    );
  }
}
