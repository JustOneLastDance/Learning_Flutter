import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/*
* 手势冲突
* - 手势冲突只是手势级别的，也就是说只会在组件树中的多个 GestureDetector 之间才有冲突的场景，
*   如果压根就没有使用 GestureDetector 则不存在所谓的冲突，因为每一个节点都能收到事件。
*
* - 如果我们的代码逻辑中，对于手指按下和抬起是强依赖的，比如在一个轮播图组件中，我们希望手指按下时，
*   暂停轮播，而抬起时恢复轮播，但是由于轮播图组件中本身可能已经处理了拖动手势（支持手动滑动切换），
*   甚至可能也支持了缩放手势，这时我们如果在外部再用onTapDown、onTapUp来监听的话是不行的。
*   这时我们应该怎么做？其实很简单，通过Listener监听原始指针事件就行
*
* - 解决手势冲突的方法有两种：
*   1. 使用 Listener。这相当于跳出了手势识别那套规则。Listener 监听的是原始指针事件
*   2. 自定义手势手势识别器（ Recognizer）。
*
* */

class GestureConflictRoute extends StatefulWidget {
  const GestureConflictRoute({super.key});

  @override
  _GestureConflictRouteState createState() => _GestureConflictRouteState();
}

class _GestureConflictRouteState extends State<GestureConflictRoute> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势冲突'),
      ),
      body: Stack(
        children: <Widget>[
          customGestureDetector(
            // 将 GestureDetector 换位 Listener 即可
            onTap: () => print("2"),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.red,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => print("1"),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// 自定义手势识别器
/// 自定义手势识别器的方式比较麻烦，原理时当确定手势竞争胜出者时，会调用胜出者的acceptGesture 方法，
/// 表示“宣布成功”，然后会调用其他手势识别其的rejectGesture 方法，表示“宣布失败”。既然如此，我们可以自定义手势识别器（Recognizer），
/// 然后去重写它的rejectGesture 方法：在里面调用acceptGesture 方法，这就相当于它失败是强制将它也变成竞争的成功者了，
/// 这样它的回调也就会执行。
class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    // 不，我不要失败，我要成功
    // super.rejectGesture(pointer);
    // 宣布成功
    super.acceptGesture(pointer);
  }
}

/// 创建一个新的GestureDetector，用我们自定义的 CustomTapGestureRecognizer 替换默认的
/// 从 RawGestureDetector 即底层逻辑修改手势逻辑
RawGestureDetector customGestureDetector({
  GestureTapCallback? onTap,
  GestureTapDownCallback? onTapDown,
  Widget? child,
}) {
  return RawGestureDetector(
    child: child,
    gestures: {
      CustomTapGestureRecognizer:
      GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
            () => CustomTapGestureRecognizer(),
            (detector) {
          detector.onTap = onTap;
        },
      )
    },
  );
}