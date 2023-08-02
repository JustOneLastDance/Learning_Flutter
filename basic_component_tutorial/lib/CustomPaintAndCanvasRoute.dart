import 'package:flutter/material.dart';
import 'dart:math';

/*
* CustomPaint & Canvas
* 几乎所有的UI系统都会提供一个自绘UI的接口，这个接口通常会提供一块2D画布Canvas，
* Canvas内部封装了一些基本绘制的API，开发者可以通过Canvas绘制各种自定义图形。
* 在Flutter中，提供了一个CustomPaint 组件，它可以结合画笔CustomPainter来实现自定义图形绘制。
*
*
* 绘制性能
* 绘制是比较昂贵的操作，所以我们在实现自绘控件时应该考虑到性能开销，下面是两条关于性能优化的建议：
* 1. 尽可能的利用好shouldRepaint返回值；在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；
*    假如我们绘制的UI不依赖外部状态，即外部状态改变不会影响我们的UI外观，那么就应该返回false；
*    如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，
*    如果已改变则应返回true来重绘，反之则应返回false不需要重绘。
*
* 2. 绘制尽可能多的分层；在上面五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，
*    这样会有一个问题：由于棋盘始终是不变的，用户每次落子时变的只是棋子，
*    但是如果按照上面的代码来实现，每次绘制棋子时都要重新绘制一次棋盘，这是没必要的。
*    优化的方法就是将棋盘单独抽为一个组件，并设置其shouldRepaint回调值为false，然后将棋盘组件作为背景。
*    然后将棋子的绘制放到另一个组件中，这样每次落子时只需要绘制棋子。
* */

class DrawChessBoardRoute extends StatelessWidget {
  const DrawChessBoardRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CustomPaint&Canvas —— 棋盘'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomPaint(
                  size: const Size(300.0, 300.0), // 指定画布的大小
                  painter: MyPainter()),

              // 添加一个刷新button：查看是否发生重绘
              // 发生重绘，原因如下：
              // 刷新按钮的画布和CustomPaint的画布是同一个，刷新按钮点击时会执行一个水波动画，
              // 水波动画执行过程中画布会不停的刷新，所以就导致了CustomPaint 不停的重绘。
              // 解决方案：
              // 给刷新按钮 或 CustomPaint 任意一个添加一个 RepaintBoundary 父组件即可
              RepaintBoundary(
                child: ElevatedButton(onPressed: () {}, child: const Text("刷新")),
              )
            ],
          ),
        ));
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('start paint');

    var rect = Offset.zero & size;
    //画棋盘
    drawChessboard(canvas, rect);
    //画棋子
    drawPieces(canvas, rect);
  }

  @override
  // 绘制的 UI 不依赖外部状态即不会改变时，返回 false 表示不会进行重新绘制
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  /// 画棋盘
  void drawChessboard(Canvas canvas, Rect rect) {
    // 棋盘背景
    var paint = Paint()
      ..isAntiAlias = true // 控制绘制图形时是否使用抗锯齿效果
      ..style = PaintingStyle.fill // 填充
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);

    // 画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black38
      ..strokeWidth = 1.0;

    // 画横线
    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }
  }

  /// 画棋子
  void drawPieces(Canvas canvas, Rect rect) {
    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;

    // 设置画笔
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    // 画黑子
    canvas.drawCircle(
        Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2, // -2 为了不让一个棋子占满棋格
        paint);

    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2, // min() 比较二者大小并取得较小的值
      paint,
    );
  }
}
