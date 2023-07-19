import 'package:flutter/material.dart';

/*
* SliverAppBar
*
* 如此改进的原理：
* 1. SliverAppBar 用 SliverOverlapAbsorber 包裹了起来，它的作用就是获取 SliverAppBar
*    返回时遮住内部可滚动组件的部分的长度，这个长度就是 overlap（重叠） 的长度。
* 2. 在 body 中往 CustomScrollView 的 Sliver列表的最前面插入了一个 SliverOverlapInjector，
*    它会将 SliverOverlapAbsorber 中获取的 overlap 长度应用到内部可滚动组件中。
*    这样在 SliverAppBar 返回时内部可滚动组件也会相应的同步滑动相应的距离。
*
* SliverOverlapAbsorber 和 SliverOverlapInjector 都接收有一个 handle，给它传入的是NestedScrollView.sliverOverlapAbsorberHandleFor(context)。
* handle 就是 SliverOverlapAbsorber 和 SliverOverlapInjector 的通信桥梁，即传递 overlap 长度。
*
* */

class SnapAppBar extends StatelessWidget {
  const SnapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[

            // 原始代码 下述代码可能导致在滑动 ListView 时出现 header 会覆盖部分要展示的 list 内容
            // SliverAppBar(
            //   floating: true,
            //   snap: true,
            //   expandedHeight: 200,
            //   forceElevated: innerBoxIsScrolled,
            //   flexibleSpace: FlexibleSpaceBar(
            //     background: Image.asset('images/avatar.jpeg', fit: BoxFit.cover),
            //   ),
            // ),

            // 以下为标准解决方案
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 200,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      Image.asset('images/avatar.jpeg', fit: BoxFit.cover),
                ),
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            // 原始代码 下述代码可能导致在滑动 ListView 时出现 header 会覆盖部分要展示的 list 内容
            // slivers: [
            //   buildSliverList(30),
            // ],

            // 以下为标准解决方案
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              buildSliverList(30),
            ],
          );
        }),
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
