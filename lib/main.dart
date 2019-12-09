import 'package:demo02/pages/index_page.dart';
import 'package:demo02/provide/child_category.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';

void main() {
  var counter = Counter();
  var proviers = Providers();
  var child = ChildCategory();

  proviers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(child));

  runApp(ProviderNode(
    child: new MyApp(),
    providers: proviers,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
