import 'dart:convert';
import 'package:demo02/provide/child_category.dart';
import 'package:flutter/material.dart';
import 'package:demo02/service/service_mothed.dart';
import 'package:demo02/model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("商品分类"),
        ),
        body: Container(
          child: Row(
            children: <Widget>[
              LeftCategory(),
              Column(
                children: <Widget>[
                  RightCategoryNav(),
                ],
              )
            ],
          ),
        ));
  }
}

//左侧大类导航
class LeftCategory extends StatefulWidget {
  @override
  _LeftCategoryState createState() => _LeftCategoryState();
}

class _LeftCategoryState extends State<LeftCategory> {
  List leftList = [];
  var listIndex = 0;
  @override
  void initState() {
    _getCategory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: leftList.length,
        itemBuilder: (context, index) {
          return _leftInkwell(index);
        },
      ),
    );
  }

  Widget _leftInkwell(index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = leftList[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          leftList[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request("CategoryURL").then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        leftList = categoryModel.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(leftList[0].bxMallSubDto);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  BxMallSubDto bxMallSubDto = BxMallSubDto();
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategoryList) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategoryList.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(childCategoryList.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item) {
    bool isClickk = false;
    isClickk = (item.mallSubName == bxMallSubDto.mallSubName) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          bxMallSubDto.mallSubName = item.mallSubName;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClickk ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
