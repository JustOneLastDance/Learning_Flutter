import 'package:flutter/material.dart';

/*
* Pointer Event
* 一些常用的属性说明：
* 1. position：它是指针相对于当对于全局坐标的偏移。
* 2. localPosition: 它是指针相对于当对于本身布局坐标的偏移。
* 3. delta：两次指针移动事件（PointerMoveEvent）的距离。
* 4. pressure：按压力度，如果手机屏幕支持压力传感器(如iPhone的3D Touch)，此属性会更有意义，如果手机不支持，则始终为1。
* 5. orientation：指针移动方向，是一个角度值。
*
* 忽略指针事件
* 假如我们不想让某个子树响应PointerEvent的话，我们可以使用IgnorePointer和AbsorbPointer，
* 这两个组件都能阻止子树接收指针事件，
* 不同之处在于AbsorbPointer本身会参与命中测试，而IgnorePointer本身不会参与，
* 这就意味着AbsorbPointer本身是可以接收指针事件的(但其子树不行)，而IgnorePointer不可以。
*
*
* */

class PointerEventRoute extends StatefulWidget {
  const PointerEventRoute({super.key});

  @override
  _PointerEventRouteState createState() => _PointerEventRouteState();
}

class _PointerEventRouteState extends State<PointerEventRoute> {
  PointerEvent? _pointerEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pointer Event'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.pinkAccent,
              width: 300.0,
              height: 150.0,
              child: Text('${_pointerEvent?.localPosition ?? ''}',
                  style: const TextStyle(color: Colors.yellow)),
            ),
            onPointerDown: (PointerDownEvent event) =>
                setState(() => _pointerEvent = event),
            onPointerMove: (PointerMoveEvent event) =>
                setState(() => _pointerEvent = event),
            onPointerUp: (PointerUpEvent event) =>
                setState(() => _pointerEvent = event),
          ),

          Listener(
            child: AbsorbPointer(
              // AbsorbPointer 的子树可以接收触摸事件，但是不会响应
              child: Listener(
                child: Container(
                  color: Colors.red,
                  width: 200.0,
                  height: 150.0,
                ),
                onPointerDown: (event) => print('in'), // 不会打印 'in'
              ),
            ),
            
            onPointerDown: (event) => print('up'),
          ),
        ],
      ),
    );
  }
}
