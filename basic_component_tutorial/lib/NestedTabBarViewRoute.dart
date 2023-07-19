import 'package:flutter/material.dart';

/*
* NestedTabBarView
* 为了获得更大的商品显示空间，我们希望用户向上滑动时 导航栏能够滑出屏幕。
* 当用户向下滑动时，导航栏能迅速回到屏幕，因为向下滑动时可能是用户想看之前的商品，也可能是用户向找到导航栏返回。
*
* */

class NestedTabBarViewRoute extends StatelessWidget {
  const NestedTabBarViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('商城'),
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return Builder(builder: (BuildContext context) {
                return CustomScrollView(
                  // 设置泛形类型为 String，参数名为 name 的唯一标识符 PageStorageKey
                  // 用作记录指定的页面的当前状态，如当前滚动的位置等
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: buildSliverList(50),
                    ),
                  ],
                );
              });
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(title: Text('$index'));
        },
        childCount: count,
      ),
    );
  }
}
