import 'package:flutter/material.dart';

/*
* InheritedWidget
* 提供了一种在 Widget 树中由上至下共享数据的方式。
* 当在根 Widget 中设置 InheritedWidget 后，可以在任意子 Widget 获取共享的数据
* 实现了跨组件式数据传递
* */

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({Key? key, required this.data, required Widget child}) : super(key: key, child: child);

  final int data; // 记录点击次数

  // 定义一个便捷方法，方便子树中的widget获取共享数据
  // 函数为 of(BuildContext context)
  // 利用 static 修饰，说明该函数是一个类函数，而不是实例函数
  // 通过 context.dependOnInheritedWidgetOfExactType<ShareDataWidget>()
  // 可以找到最近的 ShareDataWidget并返回，没有则会返回null，故返回类型为 ShareDataWidget?
  static ShareDataWidget? of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();

    // 不要每次调用 ShareDataWidget 都会触发 didChangeDependencies
    // 由于 count 的变化发生在 build() 中的 setState() 函数中，子节点会重新 build() 但没有必要，需要对数据进行缓存。
    // 两者在源码中看的话，dependOnInheritedWidgetOfExactType 是会注册依赖关系，而 getElementForInheritedWidgetOfExactType 不会
    return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>()!.widget as ShareDataWidget;
  }

  @override
  // 必要实现函数
  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

/// 实现一个子组件_TestWidget，在其build方法中引用ShareDataWidget中的数据。
/// 同时，在其didChangeDependencies() 回调中打印日志
class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context)!.data.toString(), textScaleFactor: 2.0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    // 如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print('__TestWidgetState Dependencies changed!');
  }
}



class InheritedWidgetRoute extends StatefulWidget {
  const InheritedWidgetRoute({super.key});

  @override
  _InheritedWidgetRouteState createState() => _InheritedWidgetRouteState();
}

class _InheritedWidgetRouteState extends State<InheritedWidgetRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidget 数据共享'),
      ),
      body: Center(
        child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                child: _TestWidget(),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ++count;
                    });
                  },
                  child: const Text('计数器+1', textScaleFactor: 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}