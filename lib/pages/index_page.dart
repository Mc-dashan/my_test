import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
  final selectColor = Colors.pink;
  final unSelectColor = Colors.grey;
  final double fontSize = 14.0;

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: Center(
        child: Text("百姓生活+"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: itemlist,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: fontSize,
        unselectedFontSize: fontSize,
        selectedItemColor: selectColor,
        unselectedItemColor: unSelectColor,
      ),
    );
  }
}
