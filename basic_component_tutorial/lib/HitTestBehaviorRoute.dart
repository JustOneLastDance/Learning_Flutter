import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
* HitTestBehavior
* 为了让因为被迫中断命中测试的后续兄弟节点可以被响应而产生的一个机制，使得兄弟节点仍然可以被响应。
*
*
* Listener 的实现和 PointerDownListener 的实现原理差不多，有两点不同：
* 1. Listener 监听的事件类型更多一些。
* 2. Listener的 hitTestSelf 并不是一直返回 true。
*
* */

class PointerDownListener extends SingleChildRenderObjectWidget {
  const PointerDownListener({Key? key, this.onPointerDown, Widget? child})
      : super(key: key, child: child);

  final PointerDownEventListener? onPointerDown;

  // 在 Dart 语言中，「..」 是一种「级联操作符」（cascade notation），它允许在同一个对象上执行多个操作，而不必反复引用同一个对象。
  // 以下代码实现了2个操作
  // 1. 创建了一个 RenderPointerListener 对象：RenderPointerListener()。
  // 2. 设置了 RenderPointerListener 对象的 onPointerDown 属性：..onPointerDown = onPointerDown。
  // 使用级联操作符 .. 可以将上述两行代码合并成一行，使代码更加简洁和紧凑。
  // 注意，级联操作符只能用于在同一个对象上进行连续操作，并且返回的是该对象本身，因此可以连续对同一个对象的属性和方法进行设置和调用。
  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderPointerListener()..onPointerDown = onPointerDown;

  @override
  void updateRenderObject(
      BuildContext context, RenderPointerDownListener renderObject) {
    renderObject.onPointerDown = onPointerDown;
  }
}

class RenderPointerDownListener extends RenderProxyBox {
  PointerDownEventListener? onPointerDown;

  @override
  bool hitTestSelf(Offset position) => true; //始终通过命中测试

  @override
  void handleEvent(PointerEvent event, covariant HitTestEntry entry) {
    //事件分发时处理事件
    if (event is PointerDownEvent) onPointerDown?.call(event);
  }
}


class PointerDownListenerRoute extends StatelessWidget {
  const PointerDownListenerRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HitTestBehavior'),
      ),
      body: PointerDownListener(
        child: const Text('Click Me', textScaleFactor: 2.0),
        onPointerDown: (e) => print('down!!!'),
      ),
    );
  }
}
