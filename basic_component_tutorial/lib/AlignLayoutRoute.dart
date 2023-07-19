import 'package:flutter/material.dart';

/*
* Align
* Align({
  Key key,
  this.alignment = Alignment.center,
  this.widthFactor,
  this.heightFactor,
  Widget child,
  })
*
* widthFactor heightFactor 确定 Align 自身控件的宽高缩放系数，通过系数确定组件最终的宽高
* 如果系数为 null，则表示尽可能多地占据空间
*
*
* Alignment
* Alignment(this.x, this.y) 用于表示矩形内的一个点，x水平方向的偏移量，y垂直方向上的偏移量
* 以矩形的中心点作为坐标原点
* 通过坐标转换公式确定控件的最终位置
* (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
*
*
* FractionalOffset
* 坐标原点为矩形的左侧上顶点
* 实际偏移 = (FractionalOffset.x * childWidth, FractionalOffset.y * childHeight)
*
* */

class AlignLayoutRoute extends StatelessWidget {
  const AlignLayoutRoute({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('对齐与相对定位'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            // 指定宽高，有无宽高系数的区别
            height: 120.0,
            width: 120.0,
            color: Colors.blue.shade50,
            child: const Align(
              alignment: Alignment.topRight,
              child: FlutterLogo(size: 60),
            ),
          ),
          Container(
            color: Colors.blue.shade50,
            child: const Align(
              // 没有指定宽高，但是有宽高系数，最终的显示效果同上
              widthFactor: 2.0,
              heightFactor: 2.0,
              alignment: Alignment.topRight,
              child: FlutterLogo(size: 60),
            ),
          ),

          // Align 的作用
          Container(
            color: Colors.blue.shade50,
            child: const Align(
              widthFactor: 2.0,
              heightFactor: 2.0,
              // Alignment(0, 0) 表示在正中央
              // 根据控件的中心位置点进行偏移操作，实际偏移坐标为（90，30）
              alignment: Alignment(2.0, 0),
              child: FlutterLogo(
                size: 60,
              ),
            ),
          ),

          // FractionalOffset
          Container(
            height: 120.0,
            width: 120.0,
            color: Colors.blue.shade50,
            child: const Align(
              // 以矩形左侧上顶点为坐标原点，实际偏移为（12，36）
              alignment: FractionalOffset(0.2, 0.6),
              child: FlutterLogo(size: 60),
            ),
          ),
        ],
      ),
    );
  }
}