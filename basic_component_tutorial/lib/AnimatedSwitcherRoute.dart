import 'package:flutter/material.dart';

/*
* 动画切换组件 AnimatedSwitcher
* 实际开发中，我们经常会遇到切换UI元素的场景，比如Tab切换、路由切换。
* 为了增强用户体验，通常在切换时都会指定一个动画，以使切换过程显得平滑。
* Flutter SDK组件库中已经提供了一些常用的切换组件，如PageView、TabView等，
* 但是，这些组件并不能覆盖全部的需求场景，为此，Flutter SDK中提供了一个AnimatedSwitcher组件，它定义了一种通用的UI切换抽象。
*
* AnimatedSwitcher是在一个子元素的新旧值之间切换
*
* */

/// AnimatedSwitcher高级用法
/// 实现一个类似路由平移切换的动画：旧页面屏幕中向左侧平移退出，新页面从屏幕右侧平移进入。
/// AnimatedSwitcher的 child 切换时会对新child执行正向动画（forward），而对旧child执行反向动画（reverse）
/// 因为同一个Animation正向（forward）和反向（reverse）是对称的。所以如果我们可以打破这种对称性，那么便可以实现这个功能了。
class MySlideTransition extends AnimatedWidget {
  const MySlideTransition(
      {Key? key,
      required Animation<Offset> position,
      this.transformHitTests = true,
      required this.child})
      : super(key: key, listenable: position);

  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }

    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({super.key});

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画切换组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              // 常规 AnimationSwitcher
              // transitionBuilder: (Widget child, Animation<double> animation) {
              //   //执行缩放动画
              //   return ScaleTransition(scale: animation, child: child);
              // },

              // 高阶 AnimationSwitcher
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween = Tween<Offset>(
                    begin: const Offset(1, 0), end: const Offset(0, 0));
                return MySlideTransition(
                    position: tween.animate(animation), child: child);
              },

              child: Text(
                '$_count',
                // 显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _count += 1;
                  });
                },
                child: const Text('点击+1')),
          ],
        ),
      ),
    );
  }
}
