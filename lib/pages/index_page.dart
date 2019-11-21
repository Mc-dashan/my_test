import 'package:demo02/pages/category.dart';
import 'package:demo02/pages/home.dart';
import 'package:demo02/pages/shopping_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'my.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> itemlist = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("我的")),
  ];
  final List pageList = [Home(), Category(), ShoppingCar(), My()];

  final selectColor = Colors.pink;
  final unSelectColor = Colors.grey;
  final double fontSize = 12.0;

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: itemlist,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: fontSize,
        unselectedFontSize: fontSize,
        selectedItemColor: selectColor,
        unselectedItemColor: unSelectColor,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
