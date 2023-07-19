import 'package:flutter/material.dart';

/*
* TabBarView
* 通常和 TabBar 搭配使用，TabBar 中封装了 PageView
* TabController 用于监听和控制 TabBarView 的页面切换，通常和 TabBar 联动。
* 如果没有指定，则会在组件树中向上查找并使用最近的一个 DefaultTabController 。
*
*
* */

class TabBarViewRoute extends StatefulWidget {
  const TabBarViewRoute({super.key});

  @override
  TabBarViewRouteState createState() => TabBarViewRouteState();
}

class TabBarViewRouteState extends State<TabBarViewRoute>
    with SingleTickerProviderStateMixin {
  // 在 late 变量的声明中，必须使用延迟初始化的方式来初始化该变量，否则会导致编译错误。
  // 通常，延迟初始化的方式是在 initState 方法中或其他适当的位置对变量进行赋值。
  // late TabController _tabController;
  List tabs = ["新闻", "历史", "图片"];

  @override
  void initState() {
    super.initState();
    // vsync 为 TickerProvider 类型，作用是为动画提供帧回调的功能，使动画能够与屏幕刷新频率同步
    // _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // 想要 TabBar 和 TabBarView 联动，通常会创建一个 DefaultTabController 作为它们共同的父级组件，
    // 这样它们在执行时就会从组件树向上查找，都会使用我们指定的这个 DefaultTabController。
    // 如此就不用手动创建一个 TabController，也不用再对状态进行管理，同时要把 StateFulWidget 转变成 StatelessWidget。
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TabBarView'),
            bottom: TabBar(
                tabs: tabs.map((e) => Tab(text: e,)).toList()),
          ),
          body: TabBarView(
            children: tabs.map((e) {
              return KeepAliveWrapper(
                  child: Container(
                alignment: Alignment.center,
                child: Text(e, textScaleFactor: 5),
              ));
            }).toList(),
          ),
        ));
  }

  @override
  void dispose() {
    // 及时释放资源，注意代码顺序
    // _tabController.dispose();
    super.dispose();
  }
}

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
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
