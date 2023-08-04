import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/*
* 文件操作
* Dart的 IO 库包含了文件读写的相关类，它属于 Dart 语法标准的一部分，
* 所以通过 Dart IO 库，无论是 Dart VM 下的脚本还是 Flutter，都是通过 Dart IO 库来操作文件的，
* 不过和 Dart VM 相比，Flutter 有一个重要差异是文件系统路径不同，
* 这是因为Dart VM 是运行在 PC 或服务器操作系统下，而 Flutter 是运行在移动操作系统中，他们的文件系统会有一些差异。
*
* */

class FileOperationRoute extends StatefulWidget {
  const FileOperationRoute({super.key});

  @override
  _FileOperationRouteState createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  // 记录数字
  int _count = 0;

  @override
  void initState() {
    super.initState();

    _readCounter().then((value) {
      setState(() {
        _count = value;
      });
    });
  }

  // 获取本地文件
  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      // 若文件读取异常，则直接返回次数0
      return 0;
    }
  }

  void _incrementCounter() async {
    setState(() {
      _count ++;
    });

    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_count');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件操作'),
      ),
      body: Center(
        child: Text('点击了 $_count 次', textScaleFactor: 3.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        // 是一个用于显示简短描述信息的小组件，通常用于向用户展示按钮或其他交互元素的功能说明。
        // Tooltip 组件会在用户将鼠标悬停在包含它的元素上一段时间后显示，并在一段时间后自动消失。
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
