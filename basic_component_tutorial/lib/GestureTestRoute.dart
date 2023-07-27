import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/*
* GestureDetector(识别多种手势)
* GestureDetector是一个用于手势识别的功能性组件，我们通过它可以来识别各种手势。
* GestureDetector 内部封装了 Listener，用以识别语义化的手势。
*
* GestureRecognizer(指定一种手势)
* GestureDetector内部是使用一个或多个GestureRecognizer来识别各种手势的，
* 而GestureRecognizer的作用就是通过Listener来将原始指针事件转换为语义手势，
* GestureDetector直接可以接收一个子widget。GestureRecognizer是一个抽象类，
* 一种手势的识别器对应一个GestureRecognizer的子类，Flutter实现了丰富的手势识别器，我们可以直接使用。
*
* */

class GestureTestRoute extends StatefulWidget {
  const GestureTestRoute({super.key});

  @override
  _GestureTestRouteState createState() => _GestureTestRouteState();
}

class _GestureTestRouteState extends State<GestureTestRoute> {
  // 与滑动事件相关的状态
  double _top = 0.0; // 距顶部的偏移
  double _left = 0.0; // //距左边的偏移

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('拖动'),
  //     ),
  //     body: Stack(
  //       children: <Widget>[
  //         // 拖动，滑动
  //         Positioned(
  //           top: _top,
  //           left: _left,
  //           child: GestureDetector(
  //             child: const CircleAvatar(child: Text('A')),
  //             // 手指按下时会触发此回调
  //             onPanDown: (DragDownDetails e) {
  //               // 打印手指按下的位置(相对于屏幕)
  //               print("用户手指按下：${e.globalPosition}");
  //             },
  //             //手指滑动时会触发此回调
  //             onPanUpdate: (DragUpdateDetails e) {
  //               //用户手指滑动时，更新偏移，重新构建
  //               setState(() {
  //                 _left += e.delta.dx;
  //                 _top += e.delta.dy;
  //               });
  //             },
  //             onPanEnd: (DragEndDetails e){
  //               //打印滑动结束时在x、y轴上的速度
  //               print(e.velocity);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //============== GestureRecognizer ==============================

  // 与点击事件相关的状态
  String _opertaion = "No Gesture Touched!";

  // GestureRecognizer 相关状态
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    // 用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('手势识别'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // GestureRecognizer
          Center(
            child: Text.rich(TextSpan(
              children: [
                const TextSpan(text: "你好世界"),

                TextSpan(
                  text: "点我变色",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: _toggle ? Colors.greenAccent : Colors.red,
                  ),
                  recognizer: _tapGestureRecognizer
                    ..onTap = () {
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                ),

                const TextSpan(text: "你好世界"),
              ],
            )),
          ),


          // 单击，双击，长按
          Center(
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 200.0,
                height: 100.0,
                child: Text(_opertaion,
                    style: const TextStyle(color: Colors.white)),
              ),
              onTap: () => _updateText('Tap'),
              onDoubleTap: () => _updateText('DoubleTap'),
              onLongPress: () => _updateText('LongPress'),
            ),
          ),

        ],
      ),
    );
  }

  void _updateText(String text) {
    setState(() {
      _opertaion = text;
    });
  }
}
