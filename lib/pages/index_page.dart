import 'package:demo02/pages/home.dart';
import 'package:demo02/pages/search.dart';
import 'package:demo02/pages/shopping_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'my.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> itemlist = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
  ];

  List<Widget> pageList = [Home(), Search(), ShoppingCar(), My()];

  final selectColor = Colors.pink;
  final unSelectColor = Colors.grey;
  final double fontSize = 14.0;

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
