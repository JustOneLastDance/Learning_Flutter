import 'package:flutter/material.dart';

/*
* ListView 主要属性说明
* itemExtent：当属性不为 Null 时，则会强制让 children 的长度等于 itemExtent 的值，
* 这样会与让子组件自己决定长度会有更好的性能。
* 因为提前确定了长度，父组件就不用在构建的时候重新进行计算，特别是在频繁滚动控件的时候。
*
* prototypeItem： 与 itemExtent 互斥，不能同时指定。（类似于指定 Cell 的类型是什么）
*
* shrinkWrap：决定 ListView 的长度，默认为 false，则 ListView 会在滚动方向上占据尽可能多的控件。
* 如果 ListView 在无边界的视窗中滚动，必须设置为 true
*
* addRepaintBoundaries: 表示是否将列表项封装在 RepaintBoundary 中。
* 可以避免列表项不必要的重复绘制。有时列表项的绘制开销非常小，不加 RepaintBoundary 性能反而更好。
*
* */

/*
* ListView.builder
* 适合在列表项很多或者列表项不确定的时候使用
* itemBuilder: 当滚动到具体的 index 位置时，开始构建相应的列表项
* itemCount: 列表项的个数，当值为 null 时表示无限个
* */

class ListViewRoute extends StatelessWidget {
  const ListViewRoute({super.key});

  @override
  Widget build(BuildContext context) {

    Widget dividerRed = const Divider(color: Colors.red);
    Widget dividerGreen = const Divider(color: Colors.green);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView'),
      ),
      body: ListView.separated( // 给列表项添加分割线
          itemBuilder: (BuildContext context, int index) {
            int realIndex = index+1;
            return ListTile(title: Text('$realIndex'));
          },
          separatorBuilder: (BuildContext context, int index) { // 分割线构造器
            return index % 2 == 0 ? dividerRed : dividerGreen;
          },
          itemCount: 20,
      ),
    );
  }
}
