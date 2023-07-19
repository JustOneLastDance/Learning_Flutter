import 'package:flutter/material.dart';

/*
* 裁剪类组件
* ClipOval 子组件为正方形时剪裁成内贴圆形；为矩形时，剪裁成内贴椭圆
* ClipRRect 将子组件剪裁为圆角矩形
* ClipRect 默认剪裁掉子组件布局空间之外的绘制内容（溢出部分剪裁）
* ClipPath 按照自定义的路径剪裁
* */

// 自定义裁剪
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(
        10.0, 15.0, 40.0, 30.0); // 依次分别是 left/top/width/height，裁剪出 40x30 的图片
  }

  @override
  // 裁剪区域不发生变化时，返回 false，可以减少性能的开销
  // 假如裁剪区域发生变化，例如有动画执行，那么返回 true，会在动画结束后进行裁剪
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

class ClipRoute extends StatelessWidget {
  const ClipRoute({super.key});

  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/avatar.jpeg", width: 80.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('裁剪类'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 原图
            avatar,
            // 裁剪成圆形
            ClipOval(child: avatar),
            // 裁剪成圆角矩形
            ClipRRect(borderRadius: BorderRadius.circular(5.0), child: avatar),

            // 原图
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                const Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  //将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, //宽度设为原来宽度一半
                    child: avatar,
                  ),
                ),
                const Text("你好世界", style: TextStyle(color: Colors.green))
              ],
            ),

            // 自定义裁剪（不会影响组件的大小）
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red),
              child: ClipRect(
                clipper: MyClipper(),
                child: avatar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
