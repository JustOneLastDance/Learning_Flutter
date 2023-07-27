import 'package:flutter/material.dart';

/*
* 事件总线
* 在 App 中，我们经常会需要一个广播机制，用以跨页面事件通知，比如一个需要登录的 App 中，
* 页面会关注用户登录或注销事件，来进行一些状态更新。
* 这时候，一个事件总线便会非常有用，事件总线通常实现了订阅者模式，订阅者模式包含发布者和订阅者两种角色，
* 可以通过事件总线来触发事件和监听事件。
*
* 这种设计模式具有松耦合的特点，因为组件之间不需要直接引用或了解对方的存在，它们只需要通过共享的事件总线进行通信。
* 这样，组件之间的耦合度降低，代码的可维护性和扩展性得到提高。
*
* 此处实现一个简单的全局事件总线，我们使用单例模式
*
* */

// 订阅者回调签名
typedef void EventCallback(arg);

//定义一个top-level（全局）变量，页面引入该文件后可以直接使用bus
var eventbus = EventBus();

class EventBus {
  // 私有构造函数
  EventBus._internal();

  // Dart中实现单例模式的标准做法就是使用static变量+工厂构造函数的方式，
  // 这样就可以保证EventBus()始终返回都是同一个实例，应该理解并掌握这种方法。

  // 保存单例
  static final EventBus _singleton = EventBus._internal();

  // 工厂构造函数
  factory EventBus() => _singleton;

  // 保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  // 每个事件对象作为键，对应的回调函数列表作为值，以便在事件发生时可以快速找到对应的回调函数，并执行它们。
  // 在使用时需要先进行空值判断
  final _emap = <Object, List<EventCallback>?>{};

  // 上述代码如果在后续代码中直接操作 _emap 时，可能会遇到一些潜在的空指针异常（NullPointerException）。
  // 故使用以下方式对列表进行初始化
  // 在后续代码中操作 _emap 时，也可以放心地使用而不需要进行额外的空值检查。
  // final _emap = <Object, List<EventCallback>?>{};

  // 添加订阅者
  void on(eventName, EventCallback func) {
    // ??=: 这是 Dart 中的空值合并运算符。它的作用是判断左侧的操作数是否为 null，
    // 如果是 null，则将右侧的值赋给左侧的操作数；如果左侧的操作数不为 null，则保持左侧的值不变，不执行赋值操作。
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(func);
  }

  // 移除订阅者
  void off(eventName, [EventCallback? func]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;

    if (func == null) {
      _emap[eventName] = null;
    } else {
      list.remove(func);
    }
  }

  // 触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;

    int length = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = length; i > -1; --i) {
      list[i](arg);
    }
  }
}

class EventBusRoute extends StatefulWidget {
  const EventBusRoute({super.key});

  @override
  _EventBusRouteState createState() => _EventBusRouteState();
}

class _EventBusRouteState extends State<EventBusRoute> {
  String message = 'Waiting...';

  @override
  void initState() {
    super.initState();

    // 在组件初始化阶段订阅事件
    eventbus.on('ClickButtonEvent', (data) {
      setState(() {
        message = data;
      });
    });
  }

  @override
  void dispose() {
    // 不能忘记移除订阅，否则会报错
    eventbus.off('ClickButtonEvent');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: message == 'Waiting...'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // 成功解决 title 未居中显示的问题
                  children: <Widget>[
                    const CircularProgressIndicator(color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(message),
                    ),
                  ],
                )
              : Text(message)),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // 点击按钮时触发事件并发送数据
                eventbus.emit('ClickButtonEvent', '实例：事件总线');
              },
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
