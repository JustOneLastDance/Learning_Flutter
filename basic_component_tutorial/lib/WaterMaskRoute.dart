import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
*
* HitTestBehavior
* deferToChild  组件是否通过命中测试取决于子组件是否通过命中测试
* opaque  组件必然会通过命中测试，同时其 hitTest 返回值始终为 true
* translucent  组件必然会通过命中测试，但其 hitTest 返回值可能为 true 也可能为 false
*
*
* 总结：
* 1. 组件只有通过命中测试才能响应事件。
* 2. 一个组件是否通过命中测试取决于 hitTestChildren(...) || hitTestSelf(...) 的值。
* 3. 组件树中组件的命中测试顺序是深度优先的。
* 4. 组件子节点命中测试的循序是倒序的，并且一旦有一个子节点的 hitTest 返回了 true，就会终止遍历，
*    后续子节点将没有机会参与命中测试。这个原则可以结合 Stack 组件来理解。
* 5. 大多数情况下 Listener 的 HitTestBehavior 为 opaque 或 translucent 效果是相同的，
*    只有当其子节点的 hitTest 返回为 false 时才会有区别。
* 6. HitTestBlocker 是一个很灵活的组件，我们可以通过它干涉命中测试的各个阶段。
*
* */

class WaterMaskRoute extends StatelessWidget {
  const WaterMaskRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HitTestBehavior 实例 —— 水印'),
      ),
      body: Stack(
        children: <Widget>[
          // wChild(1, 200),
          // wChild(2, 200),

          // 实现控件都可以响应
          HitTestBlocker(child: wChild(1, 200)),
          HitTestBlocker(child: wChild(2, 200)),
        ],
      ),
    );
  }

  Widget wChild(int index, double size) {
    return Listener(
      onPointerDown: (e) => print(index),
      child: Container(
        width: size,
        height: size,
        color: Colors.grey,
      ),
    );
  }
}

/// 自定义一个拦截 HitTest 各个过程的组件，用于满足特定需求
class HitTestBlocker extends SingleChildRenderObjectWidget {
  const HitTestBlocker(
      {Key? key,
      this.up = true,
      this.down = false,
      this.self = false,
      Widget? child})
      : super(key: key, child: child);

  // up 为 true 时 , `hitTest()` 将会一直返回 false.
  final bool up;

  // down 为 true 时, 将不会调用 `hitTestChildren()`.
  final bool down;

  // `hitTestSelf` 的返回值
  final bool self;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderHitTestBlocker(up: up, down: down, self: self);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderHitTestBlocker renderObject) {
    renderObject
      ..up = up
      ..down = down
      ..self = self;
  }
}

class RenderHitTestBlocker extends RenderProxyBox {
  RenderHitTestBlocker({this.up = true, this.down = true, this.self = true});

  bool up;
  bool down;
  bool self;

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    bool hitTestDownResult = false;

    if (!down) {
      hitTestDownResult = hitTestChildren(result, position: position);
    }

    bool pass =
        hitTestSelf(position) || (hitTestDownResult && size.contains(position));

    if (pass) {
      result.add(BoxHitTestEntry(this, position));
    }

    return !up && pass;
  }

  @override
  bool hitTestSelf(Offset position) => self;
}
