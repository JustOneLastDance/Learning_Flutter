import 'package:flutter/material.dart';

/*
* FittedBox (空间适配)
* 子组件如何适配父组件空间？
* 根据 Flutter 布局协议适配算法应该在容器或布局组件的 layout 中实现
* 为了方便开发者自定义适配规则，Flutter 提供了一个 FittedBox 组件
*
* */

/*
* 适配原理
* FittedBox 首先会忽略父组件的约束，让子组件进行布局，从而获得子组件的真实布局信息以及大小
* 通过上述方式，FittedBox 同时知道了父组件的约束条件以及子组件的真实大小
* 最后根据指定的适配方式，让子组件在父组件的约束条件下合理地进行布局
*
* */

// 解决（问1）的方式，由于 原FittedBox拿到的 maxWidth 为无穷大，故无法对宽度进行分割
// 此处把 maxWidth 设置为屏幕宽度即可
class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return FittedBox(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            // 获取屏幕的宽度
            // maxWidth: constraints.maxWidth,

            minWidth: constraints.maxWidth, // 父控件的约束条件为屏幕宽度
            maxWidth: double.infinity, // 可以处理文本长度超过屏幕宽度的情况
          ),
          child: child,
        ),
      );
    });
  }
}

class FittedBoxRoute extends StatelessWidget {
  const FittedBoxRoute({super.key});

  Widget wRow(String text) {
    Widget child = Text(text);

    Widget rowText = Row(
      // 水平方向上进行等分
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [child, child, child],
    );

    return rowText;
  }

  Widget wContainer(BoxFit boxFit) {
    return Container(
      // 父组件的约束
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        child: Container(
            // 子组件的真实大小已经超过了父组件
            width: 60,
            height: 70,
            color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FittedBox'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 子组件超过父组件的大小时，出现的异常
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                children: [
                  Text('XX' * 30),
                ],
              ),
            ),

            wContainer(BoxFit.none),
            const Text("以上没有添加是适配方式"),
            wContainer(BoxFit.contain),
            const Text("以上是添加了让子组件显示完整即进行比例缩放且尽可能多地占据父组件的适配方式"),

            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text('================分割线================'),
            ),
            Column(
              children: <Widget>[
                wRow(' 90000000000000000 '), //未经过适配
                FittedBox(child: wRow(' 90000000000000000 ')), // 经过适配等比例缩放后
                wRow(' 800 '), //未经过适配
                FittedBox(child: wRow(' 800 ')), // (问1)——经过适配，但不符合预期结果

                const Text('以下为正确的例子'),
                SingleLineFittedBox(child: wRow(' 90000000000000000 ')),
                SingleLineFittedBox(child: wRow('800')),

              ]
                  .map((e) => Padding(
                        // 遍历为 Column 中的控件添加间距
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: e,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
