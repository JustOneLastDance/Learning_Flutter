import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

/*
* 通过HttpClient发起HTTP请求
*
* Dart IO库中提供了用于发起Http请求的一些类，我们可以直接使用HttpClient来发起请求。
* 使用HttpClient发起请求分为五步：
* 1. 创建一个HttpClient
* 2. 打开Http连接，设置请求头
* 3. 等待连接服务器
* 4. 读取响应内容
* 5. 请求结束，关闭HttpClient
*
* */

class HTTPRequestRoute extends StatefulWidget {
  const HTTPRequestRoute({super.key});

  @override
  _HTTPRequestRouteState createState() => _HTTPRequestRouteState();
}

class _HTTPRequestRouteState extends State<HTTPRequestRoute> {
  bool _isLoading = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP 请求'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: _isLoading ? null : request,
                child: const Text("获取百度首页")),
            Container(
              // MediaQuery 获取当前屏幕的基本信息
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(_text.replaceAll(RegExp(r"\s"), "")),
            ),
          ],
        ),
      ),
    );
  }

  void request() async {
    setState(() {
      _isLoading = true;
      _text = 'Is Requesting!!!';
    });

    try {
      //创建一个HttpClient
      HttpClient httpClient = HttpClient();
      //打开Http连接
      // URL: www.baidu.com  URI: www.baidu.com/index.html
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('https://www.baidu.com'));
      //使用iPhone的UA
      request.headers.add(
        "user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      );

      //等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      _text = await response.transform(utf8.decoder).join();
      //输出响应头
      print(response.headers);

      //关闭client后，通过该client发起的所有请求都会终止。
      httpClient.close();
    } catch (e) {
      _text = "请求失败：$e";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
