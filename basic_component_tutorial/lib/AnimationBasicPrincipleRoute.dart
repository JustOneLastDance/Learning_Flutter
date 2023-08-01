import 'package:flutter/material.dart';

/*
* Animation
* 有4个主要角色：Animation Curve Controller Tween
* Animation: 本身与渲染无关，用户保存动画的差值和状态
* Curve: 描述动画行进的速率
* AnimationController: 用于控制动画，会在动画的每一帧生成一个新的值，值的区间[0.0, 1,0]
* Tween: 用与动画值在不同的范围内或者类型不同之间的过渡
*
* 用AnimatedBuilder重构
* 用AnimatedWidget 可以从动画中分离出 widget，而动画的渲染过程（即设置宽高）仍然在AnimatedWidget 中，
* 假设如果我们再添加一个 widget 透明度变化的动画，那么我们需要再实现一个AnimatedWidget，这样不是很优雅，
* 如果我们能把渲染过程也抽象出来，那就会好很多，而AnimatedBuilder正是将渲染逻辑分离出来
*
* */

/// 对动画图片进行封装
class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Center(
      child: Image.asset(
        'images/avatar.jpeg',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({super.key});

  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

/// 需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this, // 用于同步动画的帧率与屏幕刷新率
      duration: const Duration(seconds: 3),
    );

    // 使用弹性曲线
    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //图片宽高从0变到300
    // animation = Tween(begin: 0.0, end: 300.0).animate(animation)
    //   ..addListener(() {
    //     setState(() {
    //       // todo
    //     });
    //   });

    // 动画监听状态，实现动画循环执行
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动动画（正向）
    controller.forward();
  }

  @override
  void dispose() {
    // 务必记得路由销毁时需要释放动画资源
    // 代码中addListener()函数调用了setState()，所以每次动画生成一个新的数字时，当前帧被标记为脏(dirty)，
    // 这会导致widget的build()方法再次被调用，而在build()中，改变Image的宽高，因为它的高度和宽度现在使用的是animation.value ，
    // 所以就会逐渐放大。值得注意的是动画完成时要释放控制器(调用dispose()方法)以防止内存泄漏。
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Flutter 动画'),
    //   ),
    //   body: Center(
    //     child: AnimatedImage(animation: animation), // 使用封装后的动画图片
    //   ),
    // );

    // 使用 AnimatedBuilder 抽离渲染逻辑过程
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 动画'),
      ),
      body: AnimatedBuilder(
        // 其中有两个 child，是同一个组件，和上面的示例有所不同但有3个好处：
        // 1. 不用显式地添加帧监听器再去调用 setState()
        // 2. 更好的性能：因为动画每一帧需要构建的 widget 的范围缩小了，
        //    如果没有 builder，setState() 将会在父组件上下文中调用，这将会导致父组件的build方法重新调用；
        //    而有了 builder 之后，只会导致动画widget自身的build重新调用，避免不必要的rebuild。
        // 3. 通过 AnimatedBuilder 可以封装常见的过渡效果来复用动画。
        animation: animation,
        child: Image.asset('images/avatar.jpeg'),
        builder: (BuildContext context, child) {
          return Center(
            child: SizedBox(
              height: animation.value,
              width: animation.value,
              child: child,
            ),
          );
        },
      ),
    );

  }
}
