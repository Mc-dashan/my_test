import 'package:demo02/provide/counter.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text('${counter.value}');
        },
      )),
    );
  }
}
