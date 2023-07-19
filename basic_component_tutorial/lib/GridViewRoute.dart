import 'package:flutter/material.dart';

/*
* GridView
* 网格布局组件
* SliverGridDelegate: 用于控制子组件如何进行排列
*
* SliverGridDelegateWithFixedCrossAxisCount: 横轴上固定个数的子元素布局算法
* 子元素的大小是通过crossAxisCount(主轴方向上的间距)和childAspectRatio(宽高比例)两个参数共同决定的
*
* SliverGridDelegateWithMaxCrossAxisExtent: 横轴子元素为固定最大长度的layout算法
* childAspectRatio: 子元素横轴和主轴的长度比为最终的长度比
* */

class GridViewRoute extends StatefulWidget {
  const GridViewRoute({super.key});

  @override
  GridViewRouteState createState() => GridViewRouteState();
}

class GridViewRouteState extends State<GridViewRoute> {
  final List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();

    _retrieveIcons();
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 每行3个子元素
            childAspectRatio: 1.0 // 子元素宽高比1：1
          ),
          itemCount: _icons.length,
          itemBuilder: (context, index) {
            if (index == _icons.length - 1 && _icons.length < 200) {
              _retrieveIcons();
            }
            return Icon(_icons[index]);
          }
      ),
    );
  }
}