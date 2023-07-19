import 'package:flutter/material.dart';

/*
* 填充 Padding
* Padding 可以给其子控件添加填充（留白），和边距效果类似。
* EdgeInsets
* 指定是哪些边的间距
* */

class PaddingAndEdgeInsetsRoute extends StatelessWidget {
  const PaddingAndEdgeInsetsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padding & EdgeInsets'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0), // 周围设置16像素的间距
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                Padding(
                  // 指定单边间距
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Hello World'),
                ),
                Padding(
                  // 指定对称方向的间距
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Who is there'),
                ),
                Padding(
                  // 指定四周的间距
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text('Mother Fucker'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}