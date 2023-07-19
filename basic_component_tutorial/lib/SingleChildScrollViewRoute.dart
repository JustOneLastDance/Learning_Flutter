import 'package:flutter/material.dart';


/*
* SingleChildScrollView
* 只能接收一个子组件
* 一般是在需要展示的内容不会超过屏幕太多的时候使用
* 由于其本身并不支持 Sliver 的延迟加载模型，会导致性能开销巨大
* 这种情况下应使用支持延迟加载模型的可滚动控件如 ListView
* */

class SingleChildScrollViewRoute extends StatelessWidget {
  const SingleChildScrollViewRoute({super.key});

  @override
  Widget build(BuildContext context) {

    String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return Scaffold(
      appBar: AppBar(
        title: const Text('SingleChildScrollView'),
      ),
      body: Scrollbar( // 显示滚动条
        child:  SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: str.split("")
                  .map((character) => Text("This is a $character", textScaleFactor: 2.0))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}