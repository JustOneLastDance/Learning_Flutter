import 'package:flutter/material.dart';

/*
* NestedScrollView
* CustomScrollView 只能组合 sliver，但不能解决多个组件滚动方向一致时所产生的冲突
* 故 Flutter 提供组件 NestedScrollView 用于协调两个可滚动组件
*
* NestedScrollView 在逻辑上将可滚动组件分成 header 和 body
* header 称为外部可滚动组件，可认为是一个 CustomScrollView
* 而 body 称为内部可滚动组件，可以接收任何任意可滚动组件
* NestedScrollView 整体就是一个 CustomScrollView
*
* NestedScrollView 通过一个协调器来协调 内部和外部可滚动组件，
* 即分别为内外部设置一个 controller，通过控制 controller 来协调组件的滚动操作
*
* */

class NestedScrollViewRoute extends StatelessWidget {
  const NestedScrollViewRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('嵌套ListView'),
              pinned: true,
              forceElevated: innerBoxIsScrolled,
            ),
            buildSliverList(5),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          // 一个滚动物理模型，用于在滚动过程中实现内容的边界约束。
          physics: const ClampingScrollPhysics(), // 当header中只有一个SliverAppBar不用设置，其他情况要保证滑动效果统一
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item: No.$index')),
            );
          },
        ),
      ),
    );
  }

  // [int count = 5]
  // 在 [ ] 内的 count 表示可选，如果不传入参数，则默认 count = 5
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
