import 'package:flutter/material.dart';

/*
* CustomScrollView
* 一个完整的可滚动组件包括：Scrollable, ViewPort, Sliver
* 若想要实现两个滚动组件头尾相接，第一个组件滚动至尾部则立刻显示第二个滚动组件的头部这种效果，可使用 CustomScrollView
* 作用是将两个 ListView(可滚动组件)的 Sliver 添加到 CustomScrollView 中可共用的 Viewport 对象中，Scrollable 也是共用的
* 即 CustomScrollView 提供 scrollable 和 viewport，listview 提供 sliver(展示内容)
*
* SliverToBoxAdapter
* 作用是将 RenderBox 适配成 Sliver，并不是所有组件都有 Sliver
*
* */

class CustomScrollViewRoute extends StatelessWidget {
  CustomScrollViewRoute({super.key});

  var listView = SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((_, index) => ListTile(title: Text('$index')),
        childCount: 20
      ),
      itemExtent: 56 // 列表项默认高度
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomScrollView & Sliver'),
      ),
      body: CustomScrollView(
        slivers: [
          listView,
          listView
        ],
      ),
    );
  }
}