import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/*
* Dio
*
* 直接使用HttpClient发起网络请求是比较麻烦的，很多事情得我们手动处理，
* 如果再涉及到文件上传/下载、Cookie管理等就会非常繁琐。幸运的是，Dart社区有一些第三方http请求库，
* 用它们来发起http请求将会简单的多
*
* */

class HttpRequestDioRoute extends StatefulWidget {
  const HttpRequestDioRoute({super.key});

  @override
  _HttpRequestDioRouteState createState() => _HttpRequestDioRouteState();
}

class _HttpRequestDioRouteState extends State<HttpRequestDioRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http 请求库 —— Dio'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求完成
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                //发生错误
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                //请求成功，通过项目信息构建用于显示项目名称的ListView
                return ListView(
                  children: response.data.map<Widget>((e) =>
                      ListTile(title: Text(e["full_name"]))
                  ).toList(),
                );
              }

              //请求未完成时弹出loading
              return const CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
