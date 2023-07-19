import 'dart:ffi';

import 'package:flutter/material.dart';


/*
Material 组件库中提供了两种进度指示器：LinearProgressIndicator和CircularProgressIndicator
它们都可以同时用于精确的进度指示和模糊的进度指示。
精确进度通常用于任务进度可以计算和预估的情况，比如文件下载；而模糊进度则用户任务进度无法准确获得的情况，如下拉刷新，数据提交等。
*/
class ProgressIndicatorRoute extends StatelessWidget {
  const ProgressIndicatorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("进度指示器"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // 圆形进度条：模糊进度条，会执行一个加载动画
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),
          const SizedBox(height: 20),

          // 圆形进度条：显示50%进度
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            value: 0.5,
          ),
          const SizedBox(height: 20),

          // 利用 SizedBox 自定义进度指示器的大小
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.orange),
              value: .7,
            ),
          ),
        ],
      ),
    );
  }
}