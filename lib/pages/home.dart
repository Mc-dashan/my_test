import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:demo02/service/service_mothed.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String responseTv = "";

  int page = 1;
  List<Map> hotGoodsList = [];

  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 5.0),
    padding: EdgeInsets.all(10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text("火爆专区"),
  );
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('¥${val['mallPrice']}'),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          '¥${val['price']}',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[_hotTitle, _wrapList()],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
          future: request("homePageContent", formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPrcture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImg = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']["recommend"] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1List = (data['data']["floor1"] as List).cast();
              List<Map> floor2List = (data['data']["floor2"] as List).cast();
              List<Map> floor3List = (data['data']["floor3"] as List).cast();
              if (navigatorList.length > 10) {
                navigatorList.removeRange(10, navigatorList.length);
              }
              return EasyRefresh(
                  onRefresh: () async {
                    await request("homePageContent", formData: formData);
                  },
                  header: MaterialHeader(),
                  footer: MaterialFooter(),
                  child: ListView(
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
                      LeaderPhone(
                          leaderImg: leaderImg, leaderPhone: leaderPhone),
                      Recommend(
                        recommendList: recommendList,
                      ),
                      FloorTitle(pictureAddress: floor1Title),
                      FloorContent(
                        floorGoodsList: floor1List,
                      ),
                      FloorTitle(pictureAddress: floor2Title),
                      FloorContent(
                        floorGoodsList: floor2List,
                      ),
                      FloorTitle(pictureAddress: floor3Title),
                      FloorContent(
                        floorGoodsList: floor3List,
                      ),
                      _hotGoods(),
                    ],
                  ),
                  onLoad: () async {
                    var formPage = {'page': page};
                    await request("HomeHotURL", formData: formPage).then((vel) {
                      var data = json.decode(vel.toString());
                      List<Map> newGoodsList = (data['data'] as List).cast();
                      setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page++;
                      });
                    });
                  });
            } else {
              return Center(child: Text("加载中。。。。"));
            }
          }),
    );
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
        child: InkWell(
      onTap: () {
        takePhone();
      },
      child: Image.network(leaderImg),
    ));
  }

  void takePhone() async {
    String url = "tel:" + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw ("url无效");
    }
  }
}

class Recommend extends StatelessWidget {
  final List recommendList;
  const Recommend({Key key, this.recommendList}) : super(key: key);
//推荐商品标题

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

//每个商品

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(400),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(22)),
            )
          ],
        ),
      ),
    );
  }

  Widget _recommedList() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(400),
        margin: EdgeInsets.only(top: 10),
        child: Container(
          child: Column(
            children: <Widget>[_titleWidget(), _recommedList()],
          ),
        ));
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress;

  const FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0), child: Image.network(pictureAddress));
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods['image']),
      ),
    );
  }
}
