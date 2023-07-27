import 'package:flutter/material.dart';

/*
* 通知
* 通知（Notification）是Flutter中一个重要的机制，
* 在widget树中，每一个节点都可以分发通知，通知会沿着当前节点向上传递，所有父节点都可以通过NotificationListener来监听通知。
* Flutter中将这种「由子向父」的传递通知的机制称为通知冒泡（Notification Bubbling）。
* 通知冒泡和用户触摸事件冒泡是相似的，但有一点不同：
* 通知冒泡可以中止，但用户触摸事件不行。
*
* .dispatch(BuildContext context) 中会调用 context.visitAncestorElement
* 即从当前元素向上遍历父级元素，停止遍历的条件：
* 遍历到根 Element 或者在遍历回掉中返回 false
*
* .visitAncestorElement
* 首先会判断 widget 是否为 StatelessWidget (因为 NotificationListener 属于 StatelessWidget)
* 在判断是否为NotificationListener，是则调用 ._dispatch，反之则继续向上遍历
*
* */

class MyNotification extends Notification {
  MyNotification(this.message);

  final String message;
}

class MyNotificationRoute extends StatefulWidget {
  const MyNotificationRoute({super.key});

  @override
  _MyNotificationRouteState createState() => _MyNotificationRouteState();
}

class _MyNotificationRouteState extends State<MyNotificationRoute> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知 Notification'),
      ),
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _message += '${notification.message}   ';

          });
          return true; // true 表示通知冒泡中止
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 不能直接使用悬浮按钮，如果直接使用 context 就是最底层的 context 无法正常工作
              // 应该使用 NotificationListener 下的 context，故使用 Builder 再创建一个 context
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () => MyNotification('Foo').dispatch(context),
                    child: const Text('Send Notification'));
              }),

              Text(_message),
            ],
          ),
        ),
      ),
    );
  }
}
