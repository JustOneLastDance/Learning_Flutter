import 'package:flutter/material.dart';

/*
* PageView
* 用于实现页面切换和 Tab 布局
*
* 可滚动组件子项缓存
* AutomaticKeepAlive: 该属性可以对子组件进行缓存
* 虽然 PageView 中并没有这个属性，但是其会生成一个 SliverChildDelegate，
* 在 SliverChildDelegate 中会添加一个 AutomaticKeepAlive 父控件
*
* AutomaticKeepAlive
* 作用是将列表项的根 RenderObject 的 keepAlive 按需自动标记为 true/false，列表组件的 viewport 和 cacheExtent 称为加载区域
* keepAlive = false : 当列表项滑出加载区域，立刻销毁
* keepAlive = true : 当列表项滑出加载区域，viewport 会将其缓存起来；当再次进入加载区域，viewport 首先在缓存中查找该列表项
* 有则复用，无则重新创建。
*
* 当子组件想要改变其自身的缓存状态会发送一个 KeepAliveNotification 通知告知 AutomaticKeepAlive 更改 keepAlive 的状态
* 与此同时进行资源清理工作。
*
* with 关键字
* 使用Mixin模式混入一个或者多个Mixin类
*
* Mixin (类似 protocol)
* 方法有具体的实现
* 一种在多重继承中复用某个类中代码的方法模式
* 在不继承的情况下添加方法或者属性，提供了方法的实现。其他类可以访问mixin类的方法、变量而不必成为其子类。
* 具有线性化
*
*
* */

class PageViewRoute extends StatelessWidget {
  const PageViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (int i = 1; i < 6; i++) {
      children.add(Page(text: '$i'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
      ),
      body: PageView(
        children: children,
      ),
    );
  }
}

/// 自定义缓存页面
class Page extends StatefulWidget {
  const Page({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  PageState createState() => PageState();
}

class PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("build No.${widget.text} page");
    return Center(
      child: Text(widget.text, textScaleFactor: 5.0),
    );
  }

  @override
  bool get wantKeepAlive => true; // 是否需要缓存
}

/// 缓存包装器
/// 当组件需要进行缓存时，使用该组件作为比邻父组件
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  KeepAliveWrapperState createState() => KeepAliveWrapperState();
}

class KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if(oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}