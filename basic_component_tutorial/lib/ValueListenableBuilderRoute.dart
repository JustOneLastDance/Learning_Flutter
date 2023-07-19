import 'package:flutter/material.dart';

/*
* ValueListenableBuilder
* - InheritedWidget 提供一种在 widget 树中从上到下共享数据的方式，
*   但是也有很多场景数据流向并非从上到下，比如从下到上或者横向等。为了解决这个问题，
*   Flutter 提供了一个 ValueListenableBuilder 组件，它的功能是监听一个数据源，
*   如果数据源发生变化，则会重新执行其 builder
* 属性说明：
* valueListenable：类型为 ValueListenable<T>，表示一个可监听的数据源。
* builder：数据源发生变化通知时，会重新调用 builder 重新 build 子组件树。
* child: builder 中每次都会重新构建整个子组件树，如果子组件树中有一些不变的部分，
*        可以传递给child，child 会作为builder的第三个参数传递给 builder，
*        通过这种方式就可以实现组件缓存，原理和AnimatedBuilder 第三个 child 相同。
*
* ValueListenableBuilder 和数据流向是无关的，只要数据源发生变化它就会重新构建子组件树，
* 因此可以实现任意流向的数据共享。
* */

class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({super.key});

  @override
  _ValueListenableRouteState createState() => _ValueListenableRouteState();
}

class _ValueListenableRouteState extends State<ValueListenableRoute> {
  // ***定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    print("build");
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableBuilder'),
      ),

      body: Center(
        child: ValueListenableBuilder<int>(
          builder: (BuildContext context, int value, Widget? child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child!, // 该组件即文本（点击了 ）不会发生改变
                Text('$value 次',textScaleFactor: textScaleFactor), // 该组件中的 value 会发生改变
              ],
            );
          },
          valueListenable: _counter,
          // 当子组件不依赖变化的数据，且子组件创建开销比较大时，指定 child 属性来缓存子组件非常有用
          // 该组件实际上就是替代了 上面 Row 中的 child!
          child: const Text('点击了 ', textScaleFactor: textScaleFactor),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        // 点击后值 +1，触发 ValueListenableBuilder 重新构建
        onPressed: () => _counter.value += 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}





