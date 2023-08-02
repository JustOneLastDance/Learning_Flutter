import 'package:flutter/material.dart';

class GradientButtonRoute extends StatefulWidget {
  const GradientButtonRoute({super.key});

  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渐变按钮'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GradientButton(
            colors: const [Colors.orange, Colors.red],
            height: 50.0,
            onPress: _onTap,
            child: const Text("Submit"),
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green.shade700], // 类似 Colors.green.shade700 情况下不能加 const
            height: 50.0,
            onPress: _onTap,
            child: const Text("Submit"),
          ),
          GradientButton(
            colors: [Colors.lightBlue.shade300, Colors.blueAccent],
            height: 50.0,
            onPress: _onTap,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  _onTap() {
    print('Click the GradientButton');
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key,
      this.colors,
      this.height,
      this.width,
      this.borderRadius,
      this.onPress,
      required this.child});

  // 渐变颜色数组
  final List<Color>? colors;

  // 按钮的 frame 设置
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  // 点击回调
  final GestureTapCallback? onPress;

  /// 传入一个文本组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // 确保颜色数组不为空，若为空则与 app 主题色保持一致
    List<Color> _colors =
        colors ?? [themeData.primaryColor, themeData.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell( // InkWell 点击自带波纹效果
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPress,
          child: ConstrainedBox(
            // tightFor 严格限制控件的宽高，不会超过其数值
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
