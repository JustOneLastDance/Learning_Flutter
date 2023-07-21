import 'package:flutter/material.dart';

/*
* 很多时候我们会依赖一些异步数据来动态更新UI，比如在打开一个页面时我们需要先从互联网上获取数据，
* 在获取数据的过程中我们显示一个加载框，等获取到数据时我们再渲染页面；
* 又比如我们想展示Stream（比如文件流、互联网数据接收流）的进度。
* 当然，通过 StatefulWidget 我们完全可以实现上述这些功能。
* 但由于在实际开发中依赖异步数据更新UI的这种场景非常常见，
* 因此Flutter专门提供了FutureBuilder和StreamBuilder两个组件来快速实现这种功能。
*
* FutureBuilder
* - FutureBuilder会依赖一个Future，它会根据所依赖的Future的状态来动态构建自身。
*
*   future：FutureBuilder依赖的Future，通常是「一个」异步耗时任务。
*   initialData：初始数据，用户设置默认数据。
*   builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用，构建器签名如下：
*      Function (BuildContext context, AsyncSnapshot snapshot) (签名指的是函数中的参数如 context，snapshot)
*      - snapshot 包含的是当前异步任务的状态和结果信息
*
* StreamBuilder
* StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件。
* - 在Dart中Stream 也是用于接收异步事件数据，
*   和Future 不同的是，它可以接收「多个」异步操作的结果，它常用于会多次读取数据的异步任务场景，
*   如网络内容下载、文件读写等。
*
*
* Stream
* - 在 Flutter 中，Stream 是用于处理异步事件序列的抽象类。
*   它代表一系列异步事件，可以是异步操作的结果、用户输入、定时器事件等。
*   Stream 提供了一种在异步事件到达时通知监听者的机制。
*
* Stream 具有以下重要概念：
* 1. 事件：Stream 产生的异步事件，可以是任意类型的数据，比如整数、字符串、自定义对象等。
* 2. 订阅者（Listener）：通过监听（订阅）Stream，可以在事件到达时得到通知，并做出相应的处理。
* 3. StreamSubscription：表示一个订阅者和 Stream 之间的连接，用于取消订阅。
* 4. 发送事件：通过 StreamController 或其他方式产生事件并发送给订阅者。
*
* */


class AsyncBuilderRoute extends StatefulWidget {
  const AsyncBuilderRoute({super.key});

  @override
  // _AsyncBuilderRouteState_Future createState() => _AsyncBuilderRouteState_Future();
  _AsyncBuilderRouteState_Stream createState() => _AsyncBuilderRouteState_Stream();
}

/// StreamBuilder
class _AsyncBuilderRouteState_Stream extends State<AsyncBuilderRoute> {

  Stream<int> _counter() {
    return Stream.periodic(const Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder & StreamBuilder'),
      ),
      body: StreamBuilder<int> (
        stream: _counter(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('没有Stream');
            case ConnectionState.waiting:
              return const Text('等待数据...');
            case ConnectionState.active:
              return Center(
                child: Text('active: ${snapshot.data}', textScaleFactor: 3.0),
              );
            case ConnectionState.done:
              return const Text('Stream 已关闭');
          }

        },
      ),
    );
  }
}

/// FutureBuilder
class _AsyncBuilderRouteState_Future extends State<AsyncBuilderRoute> {

  Future<String> _mockNetworkData() async {
    return Future.delayed(const Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder & StreamBuilder'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _mockNetworkData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // 请求完成
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text('Error: ${snapshot.error}');
              } else {
                // 请求成功，显示数据
                return Text("Contents: ${snapshot.data}", textScaleFactor: 2.0);
              }
            } else {
              // 请求未结束，显示loading
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}