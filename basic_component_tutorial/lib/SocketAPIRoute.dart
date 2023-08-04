import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

/*
* Socket
* Socket API 是操作系统为实现应用层网络协议提供的一套基础的、标准的API，它是对传输层网络协议（主要是TCP/UDP）的一个封装。
* Socket API 实现了端到端建立链接和发送/接收数据的基础API，而高级编程语言中的 Socket API 其实都是对操作系统 Socket API 的一个封装。
*
* 如果我们需要自定义协议或者想直接来控制管理网络链接、又或者
* 我们觉得自带的 HttpClient 不好用想重新实现一个，这时我们就需要使用Socket。
*
*
*
* */

class SocketAPIRoute extends StatelessWidget {
  const SocketAPIRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket API'),
      ),
      body: FutureBuilder(
        future: _request(),
        builder: (context,snapshot) {
          return Text(snapshot.data.toString());
        },
      ),
    );
  }

  _request() async {
    //建立连接
    var socket = await Socket.connect("baidu.com", 80);
    //根据http协议，发起 Get请求头
    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln("Connection:close");
    socket.writeln();
    //发送
    await socket.flush();
    //读取返回内容，按照utf8解码为字符串
    String _response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return _response;
  }

}

