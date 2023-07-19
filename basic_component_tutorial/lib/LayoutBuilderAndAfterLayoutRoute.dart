import 'package:flutter/material.dart';

/*
* LayoutBuilder
* 通过 LayoutBuilder 可以在 '布局过程' 中拿到父组件的约束信息，根据约束信息动态地构建不同的布局
*
* 通过观察 LayoutBuilder 的示例，我们还可以发现一个关于 Flutter 构建（build）和 布局（layout）的结论：
* Flutter 的 build 和 layout 是可以交错执行的，并不是严格的按照先 build 再 layout 的顺序。
* 比如在示例中，在build过程中遇到了LayoutBuilder组件，而LayoutBuilder的builder是在layout阶段执行
* （layout阶段才能取到布局过程的约束信息），
* 在 builder 中新建了一个 widget 后，Flutter 框架随后会调用该 widget 的 build 方法，又进入了build阶段。
*
* */


// 响应式 Column，当此时可用的宽度小于200时，将子组件显示为一列，否则以多列形式展现
class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);
  
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // 通过 LayoutBuilder 拿到父组件传递的约束，然后判断 maxWidth 是否小于200
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 200) {
            return Column(mainAxisSize: MainAxisSize.min, children: children);
          } else {
            var _children = <Widget>[];
            for (var i=0; i<children.length; i+=2) {
              if (i+1 < children.length) {
                _children.add(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [children[i], children[i+1]],
                ));
              } else {
                _children.add(children[i]);
              }
            }
            return Column(mainAxisSize: MainAxisSize.min, children: _children);
          }
        },
    );
  }
}

// 打印布局时的约束信息，便于检查错误
class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({Key? key, this.tag, required this.child}) : super(key: key);

  final Widget child;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}

class LayoutBuilderAndAfterLayoutRoute extends StatelessWidget {
  const LayoutBuilderAndAfterLayoutRoute({super.key});
  
  @override
  Widget build(BuildContext context) {

    var _children = List.filled(6, const Text('B'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('LayoutBuilder AfterLayout'),
      ),
      body: Column(
        children: [
          // 父控件即 SizedBox 宽度小于200
          SizedBox(width: 190, child: ResponsiveColumn(children: _children)),
          // 父控件即外层 Column 宽度大于200
          ResponsiveColumn(children: _children),
          const LayoutLogPrint(child:Text("xx")),
        ],
      ),
    );
  }
}