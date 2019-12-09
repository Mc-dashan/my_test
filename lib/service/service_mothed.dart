import 'package:dio/dio.dart';
import 'dart:async';
import 'package:demo02/config/service_url.dart';
import 'dart:io';

Future request(url, {formData}) async {
  print("获取数据");
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded").toString();
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
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
