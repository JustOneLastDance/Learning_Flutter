import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'models/StudentList.dart';

/*
* JSON转Dart类
* 在实战中，后台接口往往会返回一些结构化数据，如 JSON、XML 等，如之前我们请求 Github API 的示例，
* 它返回的数据就是 JSON 格式的字符串，为了方便我们在代码中操作 JSON，我们先将 JSON 格式的字符串转为 Dart 对象，
* 这个可以通过 dart:convert 中内置的 JSON 解码器json.decode()来实现，该方法可以根据 JSON 字符串具体内容将其转为 List 或 Map，
* 这样我们就可以通过他们来查找所需的值
*
*
* */

class JsonToDartModelRoute extends StatefulWidget {
  const JsonToDartModelRoute({super.key});

  @override
  _JsonToDartModelRouteState createState() => _JsonToDartModelRouteState();
}

class _JsonToDartModelRouteState extends State<JsonToDartModelRoute> {
  Dio _dio = Dio();
  List<Student> _resultList = [];

  @override
  void initState() {
    super.initState();
    sendHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json To DartModel'),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(
                    'Name:${_resultList[index].studentName}  Id:${_resultList[index].studentId}  Age:${_resultList[index].studentAge}'));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.red);
          },
          itemCount: _resultList.length),
    );
  }

  void sendHttp() async {
    var uri = Uri.parse(
        'http://rap2api.taobao.org/app/mock/293606/api/flutter/jsonmodel');
    // Unhandled Exception: type '_Map<String, dynamic>' is not a subtype of type 'String'
    // 需要指明返回类型为 String ，即 _dio.getUri<String>(uri)......
    Response response = await _dio.getUri<String>(uri);
    print('JsonPage打印看看 data ：${response.data}');

    // json 转模型
    // 响应数据已经以 UTF-8 编码解码
    StudentList studentList = StudentList.fromJson(jsonDecode(response.data));

    // 下面是测试代码～～
    // print('查看请求状态码 ---${studentList.code}');
    // print('查看list ---${studentList.list}');
    // for (var listChild in studentList.list) {
    //   print('查看list子元素 ---${listChild.studentName}');
    // }

    setState(() {
      _resultList = studentList.list;
    });
  }
}
