import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
* Transform 对 child 进行变换
*
* Transform 是应用在绘制阶段而不是布局阶段，故子控件自身的大小和位置是固定不变的，例如例子(1)中显示
* 子控件的大小和位置在布局阶段就已经确定好了
*
* */

class TransformRoute extends StatelessWidget {
  const TransformRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('变换'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Transform(
              alignment: Alignment.topRight,
              transform: Matrix4.skewY(0.3),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: const Text('Apartment for rent!'),
              ),
            ),
          ),

          const Padding(padding: EdgeInsets.only(top: 20.0)),
          // 平移
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.translate(
              offset: const Offset(-20.0, -5.0),
              child: const Text('Hello World!'),
            ),
          ),

          const Padding(padding: EdgeInsets.only(top: 40.0)),
          // 旋转
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: math.pi / 2,
              child: const Text('Hello World!'),
            ),
          ),

          const Padding(padding: EdgeInsets.only(top: 40)),
          // 缩放
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: const Text('Hello World'),
            ),
          ),

          const Padding(padding: EdgeInsets.only(top: 20.0)),
          // 例子(1)----两端文字发生了重叠
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                child: Transform.scale(
                  scale: 1.5,
                  child: const Text('Hello World'),
                ),
              ),
              const Text('你好',
                  style: TextStyle(color: Colors.green, fontSize: 18.0)),
            ],
          ),

          const Padding(padding: EdgeInsets.only(top: 20.0)),
          // 使用 RotatedBox 解决上述例子中重叠的问题
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                // RotatedBox 在布局阶段发生变换
                child: RotatedBox(
                  quarterTurns: 1, // 旋转90度
                  child: Text('Hello World'),
                ),
              ),
              Text('你好', style: TextStyle(color: Colors.green, fontSize: 18.0)),
            ],
          ),
        ],
      ),
    );
  }
}
