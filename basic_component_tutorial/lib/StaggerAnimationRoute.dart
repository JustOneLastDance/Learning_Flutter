import 'package:flutter/material.dart';

/*
* 交织动画
* 有些时候我们可能会需要一些复杂的动画，这些动画可能由一个动画序列或重叠的动画组成，
* 比如：有一个柱状图，需要在高度增长的同时改变颜色，等到增长到最大高度后，我们需要在X轴上平移一段距离。
* 可以发现上述场景在不同阶段包含了多种动画，要实现这种效果，使用交织动画（Stagger Animation）会非常简单。
* 交织动画需要注意以下几点：
* 1. 要创建交织动画，需要使用多个动画对象（Animation）。
* 2. 一个AnimationController控制所有的动画对象。 ***
* 3. 给每一个动画对象指定时间间隔（Interval）
*
*
*
* */

class StaggerAnimationRoute extends StatefulWidget {
  const StaggerAnimationRoute({super.key});

  @override
  _StaggerAnimationRouteState createState() => _StaggerAnimationRouteState();
}

class _StaggerAnimationRouteState extends State<StaggerAnimationRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  _playAnimation() async {
    try {
      // orCancel 返回的 Future 对象会得到一个值。如果动画被取消了，那么 orCancel 返回的 Future 对象会报告一个错误。
      // 先正向执行动画
      await _controller.forward().orCancel;
      // 再反向执行动画
      await _controller.reverse().orCancel;
      print('Animation completed!');
    } on TickerCanceled {
      //捕获异常。可能发生在组件销毁时，计时器会被取消。
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交织动画'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () => _playAnimation(),
                child: const Text('Start Animation')
            ),

            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(color: Colors.black.withOpacity(0.5))
              ),
              // 调用我们定义的交错动画Widget
              child: StaggerAnimation(controller: _controller),
            ),

          ],
        ),
      ),
    );
  }
}

/// 将执行动画的Widget分离
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key, required this.controller}) : super(key: key) {
    height = Tween<double>(begin: .0, end: 300.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.ease)));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.6, curve: Curves.ease)));

    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: .0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
