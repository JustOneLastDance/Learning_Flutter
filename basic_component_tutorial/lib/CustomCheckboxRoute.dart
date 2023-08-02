import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';


class CustomCheckboxRoute extends StatefulWidget {
  const CustomCheckboxRoute({super.key});

  @override
  _CustomCheckboxRouteState createState() => _CustomCheckboxRouteState();
}

class _CustomCheckboxRouteState extends State<CustomCheckboxRoute> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义选择框'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: CustomCheckbox(
                  strokeWidth: 2,
                  radius: 2,
                  value: _checked,
                  onChanged: _onChange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChange(value) {
    setState(() => _checked = value);
  }

}



// LeafRenderObjectWidget 是 Flutter 中的一个基本组件类，它用于创建只包含单个渲染对象的小部件。
// 它通常用于直接与底层渲染树交互或创建自定义的渲染逻辑。
class CustomCheckbox extends LeafRenderObjectWidget {
  const CustomCheckbox(
      {Key? key,
      this.strokeWidth = 2,
      this.strokeColor = Colors.white,
      this.fillColor = Colors.blue,
      this.value = false,
      this.radius = 2.0,
      this.onChanged})
      : super(key: key);

  /// “√”的线条宽度
  final double strokeWidth;

  /// “√”的线条宽度
  final Color strokeColor;

  /// 填充颜色
  final Color? fillColor;

  /// 选中状态
  final bool value;

  /// 圆角
  final double radius;

  /// 选中状态发生改变后的回调
  final ValueChanged<bool>? onChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckbox(
      strokeWidth,
      strokeColor,
      fillColor ?? Theme.of(context).primaryColor,
      value,
      radius,
      onChanged,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomCheckbox renderObject) {
    super.updateRenderObject(context, renderObject);

    if (renderObject.value != value) {
      renderObject.animationStatus =
          value ? AnimationStatus.forward : AnimationStatus.reverse;
    }

    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value
      ..onChanged = onChanged;
  }
}

/// 自定义一个选择框
class RenderCustomCheckbox extends RenderBox {
  RenderCustomCheckbox(this.strokeWidth, this.strokeColor, this.fillColor,
      this.value, this.radius, this.onChanged)
      : progress = value ? 1 : 0;


  /// 选中状态
  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  // 下面的属性用于调度动画
  double progress = 0; // 动画当前进度
  int? _lastTimeStamp; //上一次绘制的时间

  // 动画执行时长
  Duration get duration => const Duration(milliseconds: 150);

  // 动画当前状态
  AnimationStatus _animationStatus = AnimationStatus.completed;

  set animationStatus(AnimationStatus v) {
    if (_animationStatus != v) {
      markNeedsPaint();
    }
    _animationStatus = v;
  }

  // 背景动画时长占比（背景动画要在前40%的时间内执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;


  // 组件布局
  @override
  void performLayout() {
    // 如果父组件指定了固定宽高，则使用父组件指定的，否则宽高默认置为 25
    size = constraints.constrain(
      // .isTight: 父控件已经设置了宽高限制
      // .infinite: 当父控件指定了宽高，则可以直接扩展至父控件的宽高
      constraints.isTight ? Size.infinite : const Size(25, 25),
    );
  }


  @override
  void paint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    // 将绘制分为背景（矩形）和 前景（打勾）两部分，先画背景，再绘制'勾'
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
    // 调度动画
    _scheduleAnimation();
  }


  // 绘制的是动画执行过程中的一帧，所以需要通过动画执行的进度（progress）来计算每一帧要绘制的样子。
  // 画背景
  void _drawBackground(PaintingContext context, Rect rect) {
    // 实现的思路是先将整个背景矩形区域全部填充满蓝色，然后在上面绘制一个白色背景的矩形，
    // 根据动画进度来动态改变白色矩形区域大小即可。幸运的是 Canvas API 中已经帮助我们实现了我们期望的功能，
    // drawDRRect 他可以指定内外两个矩形，然后画出不相交的部分，并且可以指定圆角

    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..strokeWidth = strokeWidth
    ..color = color;

    // 算出每一帧里面矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    // RRect.fromRectXY 是一个静态方法，用于创建一个圆角矩形（RRect）对象，
    // 通过指定矩形的边界和圆角的 X 和 Y 方向半径来定义圆角矩形的形状。
    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth), // 以自身为基础，根据参数值进行膨胀，返回一个新的 rect
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];

    // 根据动画执行进度调整来确定里面矩形在每一帧的大小
    // Rect.lerp() 是一个静态方法，用于在两个矩形之间进行线性插值，返回一个新的矩形，
    // 表示两个矩形之间的中间状态。这在动画中非常有用，可以平滑地从一个矩形过渡到另一个矩形。
    var rectProgress = Rect.lerp(
        rects[0], 
        rects[1],
        // 背景动画的执行时长是前 40% 的时间
        min(progress, bgAnimationInterval) / bgAnimationInterval
    )!;

    final inner = RRect.fromRectXY(rectProgress, 0, 0);

    // 开始绘制
    context.canvas.drawDRRect(outer, inner, paint);

  }


  // 画 "勾"(前景)
  void _drawCheckMark(PaintingContext context, Rect rect) {
    // 在画好背景后再画前景
    if (progress > bgAnimationInterval) {

      //确定中间拐点位置
      final secondOffset = Offset(
        rect.left + rect.width / 2.5,
        rect.bottom - rect.height / 4,
      );
      // 第三个点的位置
      final lastOffset = Offset(
        rect.right - rect.width / 6,
        rect.top + rect.height / 4,
      );

      // 我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(
        secondOffset,
        lastOffset,
        (progress - bgAnimationInterval) / (1 - bgAnimationInterval), // 得到进度
      )!;

      // 将三个点连起来
      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
    }
  }


  // Flutter 的动画框架是依赖于 StatefulWidget 的，即当状态改变时显式或隐式的去调用 setState 触发更新。
  // 但是我们直接通过定义 RenderObject 的方式来实现的 CustomCheckbox，并不是基于 StatefulWidget ，那该怎么来调度动画呢
  // 第一种是让 checkbox 继承自 StatefulWidget，但此处用的是 RenderObject，方法如下：
  // 在一帧绘制结束后判断动画是否结束，如果动画未结束，则将将当前组件标记为”需要重绘“，然后等待下一帧即可

  // 调度动画
  void _scheduleAnimation() {
    if (_animationStatus != AnimationStatus.completed) {
      // 需要在 Flutter 当前的 frame 结束之前再执行，因为不能在绘制过程中又将组件标记为需要重绘
      // 用于在当前帧绘制完成后执行回调函数。这个方法常用于在绘制完成后执行一些需要在界面更新后进行的操作，
      // 比如获取组件的尺寸、触发动画或执行其他与界面相关的操作。
      // SchedulerBinding 是 Flutter 中用于管理任务调度的类。
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (_lastTimeStamp != null) {
          double delta = (timeStamp.inMilliseconds - _lastTimeStamp!) /
              duration.inMilliseconds;
          // 如果是反向动画，则 progress值要逐渐减小
          if (_animationStatus == AnimationStatus.reverse) {
            delta = -delta;
          }
          //更新动画进度
          progress = progress + delta;

          if (progress >= 1 || progress <= 0) {
            //动画执行结束
            _animationStatus = AnimationStatus.completed;
            progress = progress.clamp(0, 1);
          }
        }

        //标记为需要重绘
        markNeedsPaint();
        _lastTimeStamp = timeStamp.inMilliseconds;
      });
    } else {
      _lastTimeStamp = null;
    }
  }

  // 必须置为true，确保能通过命中测试
  @override
  bool hitTestSelf(Offset position) => true;

  // 只有通过命中测试，才会调用本方法，我们在手指抬起时触发事件即可
  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    super.handleEvent(event, entry);

    if (event.down) {
      pointerId = event.pointer;
    } else if (pointerId == event.pointer) {
      // 手指抬起时触发回调
      onChanged?.call(!value);
    }
  }
}
