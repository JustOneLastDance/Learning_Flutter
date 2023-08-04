import 'package:flutter/material.dart';

/*
* Http分块下载
* 通过一个“Http分块下载”的示例演示一下dio的具体用法。
*
*
*
* */

class ChunkDownloadRoute extends StatefulWidget {
  const ChunkDownloadRoute({super.key});

  @override
  _ChunkDownloadRouteState createState() => _ChunkDownloadRouteState();
}

class _ChunkDownloadRouteState extends State<ChunkDownloadRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分块下载'),
      ),
      body: Center(
        child: const Text('To-do'),
      ),
    );
  }
}