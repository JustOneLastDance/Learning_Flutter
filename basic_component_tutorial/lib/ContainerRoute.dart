import 'package:flutter/material.dart';

/*
* Container
* 是一种组合型容器，它本身不对应具体的RenderObject。
* 它是DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器。
* 只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景。
* 可以指定宽高，亦可以使用 constraints 来限制子控件的大小
*
* */


class ContainerRoute extends StatelessWidget {
  const ContainerRoute({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('容器组件——Container'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 120.0),
            constraints: const BoxConstraints.tightFor(width: 200.0, height: 150.0),
            decoration: const BoxDecoration( // 背景装饰
              gradient: RadialGradient( // 背景渐变色
                colors: [Colors.red, Colors.orange],
                center: Alignment.topRight,
                radius: 0.98
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0
                )
              ],
            ),
            transform: Matrix4.rotationZ(.2), // 倾斜变换
            alignment: Alignment.center, // 文字居中显示
            child: const Text('520', style: TextStyle(color: Colors.white, fontSize: 40.0)),
          ),

          const Padding(padding: EdgeInsets.only(top: 40.0)),
          // Padding Margin 的区别(填充 间距)
          Container( // margin 向外
            margin: const EdgeInsets.all(20.0),
            color: Colors.orange,
            child: const Text('Hello World!'),
          ),
          Container( // padding 向内
            padding: const EdgeInsets.all(20.0),
            color: Colors.orange,
            child: const Text('Hello World!'),
          ),
        ],
      ),
    );
  }
}