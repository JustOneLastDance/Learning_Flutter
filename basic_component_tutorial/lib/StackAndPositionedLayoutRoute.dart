import 'package:flutter/material.dart';

/*
* 堆叠布局（Stack Positioned）
* 类似 iOS 中的绝对布局，根据父控件的各个边（上下左右）进行一定的偏移
* 子组件可以根据距父容器四个角的位置来确定自身的位置。层叠布局允许子组件按照代码中声明的顺序堆叠起来。
* Flutter中使用Stack和Positioned这两个组件来配合实现绝对定位。
* Stack允许子组件堆叠，而Positioned用于根据Stack的四个角来确定子组件的位置。
* */


class StackAndPositionedLayoutRoute extends StatelessWidget {
  const StackAndPositionedLayoutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('堆叠布局'),
      ),
      body: ConstrainedBox(
        // 利用 ConstrainedBox 来确保 Stack 占满整个屏幕
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          // 没有指定位置的控件，默认占满整个 Stack
          // fit: StackFit.expand,
          children: <Widget>[
            Container(
              // 该控件并没有指定位置，故根据 stack 的 alignment 而居中显示
              color: Colors.red,
              child: const Text('Hello World', style: TextStyle(color: Colors.white)),
            ),
            const Positioned(
              // 指定了水平方向的位置，没有指定垂直方向的位置,故根据 stack 的 alignment 而垂直方向居中显示
                left: 18.0,
                child: Text("I'm Jack")),
            const Positioned(
              // 指定了垂直方向的位置，没有指定水平方向的位置，故根据 stack 的 alignment 而水平方向居中显示
                top: 18.0,
                child: Text("Your friend")),
          ],
        ),
      ),
    );
  }
}