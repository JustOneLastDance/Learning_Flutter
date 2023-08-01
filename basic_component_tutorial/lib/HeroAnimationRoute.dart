import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

/*
* Hero 动画
* 指的是可以在路由(页面)之间“飞行”的 widget，简单来说 Hero 动画就是在路由切换时，
* 有一个共享的widget 可以在新旧路由间切换。由于共享的 widget 在新旧路由页面上的位置、外观可能有所差异，
* 所以在路由切换时会从旧路逐渐过渡到新路由中的指定位置，这样就会产生一个 Hero 动画。
*
* Hero 动画的原理比较简单，Flutter 框架知道新旧路由页中共享元素的位置和大小，
* 所以根据这两个端点，在动画执行过程中求出过渡时的插值（中间态）即可，
* 而感到幸运的是，这些事情不需要我们自己动手，Flutter 已经帮我们做了，
* 实际上，Flutter Hero 动画的实现原理和我们在本章开始自实现的原理是差不多的。
*
* */

class CustomHeroAnimationRoute extends StatefulWidget {
  const CustomHeroAnimationRoute({super.key});

  @override
  _CustomHeroAnimationRouteState createState() =>
      _CustomHeroAnimationRouteState();
}

/// 自定义 Hero 动画
class _CustomHeroAnimationRouteState extends State<CustomHeroAnimationRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// 动画是否执行
  bool _isAnimating = false;

  /// 保存动画的最新状态
  AnimationStatus? _lastAnimationStatus;
  late Animation _animation;

  //两个组件在Stack中所占的区域
  Rect? child1Rect;
  Rect? child2Rect;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.addListener(() {
      if (_controller.isCompleted || _controller.isDismissed) {
        if (_isAnimating) {
          setState(() {
            _isAnimating = false;
          });
        }
      } else {
        _lastAnimationStatus = _controller.status;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //小头像
    final Widget child1 = wChild1();
    //大头像
    final Widget child2 = wChild2();

    // 是否展示小头像；只有在动画执行时、初始状态或者刚从大图变为小图时才应该显示小头像
    bool showChild1 =
        !_isAnimating && _lastAnimationStatus != AnimationStatus.forward;

    // 执行动画时的目标组件；如果是从小图变为大图，则目标组件是大图；反之则是小图
    Widget targetWidget;
    if (showChild1 || _controller.status == AnimationStatus.reverse) {
      targetWidget = child1;
    } else {
      targetWidget = child2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义 Hero 动画'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          // 让 Stack 填满屏幕剩余空间
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              // 如果在 children 列表中使用了 {} 进行包裹，会导致编译器解析出错，
              // 因为 {} 会被认为是一个代码块，而不是列表中的一个元素。
              if (showChild1)
                AfterLayout(
                  //获取小图在Stack中占用的Rect信息
                  callback: (value) => child1Rect = _getRect(value),
                  child: child1,
                ),

              if (!showChild1)
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    //求出 rect 插值
                    final rect = Rect.lerp(
                      child1Rect,
                      child2Rect,
                      _animation.value,
                    );
                    // 通过 Positioned 设置组件大小和位置
                    return Positioned.fromRect(rect: rect!, child: child!);
                  },
                  child: targetWidget,
                ),

              // 用于测量 child2 的大小，设置为全透明并且不能响应事件
              IgnorePointer(
                child: Center(
                  child: Opacity(
                    opacity: 0,
                    child: AfterLayout(
                      //获取大图在Stack中占用的Rect信息
                      callback: (value) => child2Rect = _getRect(value),
                      child: child2,
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      }),
    );
  }

  Widget wChild1() {
    return GestureDetector(
      // 点击执行放大动画
      onTap: () {
        setState(() {
          _isAnimating = true;
          _controller.forward();
        });
      },
      child: SizedBox(
        width: 50,
        child: ClipOval(child: Image.asset('images/avatar.jpeg')),
      ),
    );
  }

  Widget wChild2() {
    return GestureDetector(
      // 点击后执行反向动画
      onTap: () {
        setState(() {
          _isAnimating = true;
          _controller.reverse();
        });
      },
      child: Image.asset('images/avatar.jpeg', width: 400),
    );
  }

  Rect _getRect(RenderAfterLayout renderAfterLayout) {
    //我们需要获取的是AfterLayout子组件相对于Stack的Rect
    return renderAfterLayout.localToGlobal(Offset.zero,
            ancestor: context.findRenderObject() // //找到Stack对应的 RenderObject 对象
            ) &
        renderAfterLayout.size;
  }
}

class AfterLayout extends SingleChildRenderObjectWidget {
  const AfterLayout({
    Key? key,
    required this.callback,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAfterLayout(callback);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderAfterLayout renderObject) {
    renderObject..callback = callback;
  }

  ///组件树布局结束后会被触发，注意，并不是当前组件布局结束后触发
  final ValueSetter<RenderAfterLayout> callback;
}

class RenderAfterLayout extends RenderProxyBox {
  RenderAfterLayout(this.callback);

  ValueSetter<RenderAfterLayout> callback;

  @override
  void performLayout() {
    super.performLayout();
    // 不能直接回调callback，原因是当前组件布局完成后可能还有其他组件未完成布局
    // 如果callback中又触发了UI更新（比如调用了 setState）则会报错。因此，我们
    // 在 frame 结束的时候再去触发回调。
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => callback(this));
  }

  /// 组件在屏幕坐标中的起始点坐标（偏移）
  Offset get offset => localToGlobal(Offset.zero);

  /// 组件在屏幕上占有的矩形空间区域
  Rect get rect => offset & size;
}

// ================使用 Flutter 中的 Hero 动画===================
class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero 动画'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            // InkWell 是 Flutter 中的一个小部件，它提供了一个可点击的区域，并在点击时产生水波纹效果。
            // 通常用于响应用户的点击操作，比如按钮或者可点击的区域。
            InkWell(
              child: Hero(
                tag: 'avatar',
                child: ClipOval(
                  child: Image.asset('images/avatar.jpeg', width: 50.0),
                ),
              ),
              onTap: () {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
                      return FadeTransition(
                          opacity: animation,
                        child: Scaffold(
                          appBar: AppBar(
                            title: const Text('原图'),
                          ),
                          body: HeroAnimationRouteB(),
                        ),
                      );
                    }
                ));
              },
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("点击头像"),
            ),

          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("images/avatar.jpeg"),
      ),
    );
  }
}