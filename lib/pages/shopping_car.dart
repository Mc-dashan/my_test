import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:demo02/provide/counter.dart';

class ShoppingCar extends StatefulWidget {
  @override
  _ShoppingCarState createState() => _ShoppingCarState();
}

class _ShoppingCarState extends State<ShoppingCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[MyText(), MyButton()],
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  const MyText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 200),
        child: Provide<Counter>(
          builder: (context, child, counter) {
            return Text('${counter.value}');
          },
        ));
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      ),
    );
  }
}
