import 'package:flutter/material.dart';

/*
* 实现页面换肤功能
*
* */

class ChangeableThemeRoute extends StatefulWidget {
  const ChangeableThemeRoute({super.key});

  @override
  _ChangeableThemeRouteState createState() => _ChangeableThemeRouteState();
}

class _ChangeableThemeRouteState extends State<ChangeableThemeRoute> {
  var _themeColor = Colors.teal; // 当前路由颜色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
        data: ThemeData(
            primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
            iconTheme: IconThemeData(color: _themeColor) // 用于 Icon 颜色
            ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Theme Color Changeable'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text('颜色跟随主题')
                ],
              ),

              // 为 Icon 自定义颜色为黑色，为指定 Icon 进行 Theme 样式修改时用 Theme 进行包裹
              // 通过 局部主题 覆盖 全局主题的方式修改指定组件的样式
              Theme(
                data: themeData.copyWith(
                    iconTheme:
                        themeData.iconTheme.copyWith(color: Colors.black)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("颜色固定黑色")
                  ],
                ),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                // 改变 Theme 颜色
                _themeColor = _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
            child: const Icon(Icons.palette),
          ),

        ));
  }
}
