import 'package:dio/dio.dart';
import 'dart:async';
import 'package:demo02/config/service_url.dart';
import 'dart:io';

Future getHomePageContent() async {
  print("开始获取首页数据");
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    var formData = {"lon": "115.02932", "lat": "35.76189"};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      return Exception("服务器异常");
    }
  } catch (e) {
    return print("ERROR=========>>>${e}");
  }
}
