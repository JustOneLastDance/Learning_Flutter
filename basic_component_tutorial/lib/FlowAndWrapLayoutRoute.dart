import 'package:flutter/material.dart';

/*
* 在使用 Row/Column 时，如果展示内容超过屏幕的大小，则会报错，此时应该使用流式布局
* Flow
* 优点：性能好/灵活，可以自定义组件的位置
* 缺点：使用复杂/不能自适应子组件的大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。
*
*
* */

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0.0;
  double height = 0.0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return const Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class FlowAndWrapLayoutRoute extends StatelessWidget {
  const FlowAndWrapLayoutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("流式布局"),
      ),
      body: Wrap(
        spacing: 8.0, // 水平方向的间距
        runSpacing: 4.0, // 垂直方向的间距
        alignment: WrapAlignment.center, // 沿主轴方向居中
        children: <Widget>[
          const Chip(
            label: Text('Austin1111'),
            avatar: CircleAvatar(backgroundColor: Colors.blue, child:  Text('A'),),
          ),
          const Chip(
            label: Text('Bird2222'),
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('B')),
          ),
          const Chip(
            label: Text('Cindy3333'),
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('C')),
          ),
          const Chip(
            label: Text('David4444'),
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('D')),
          ),
          Flow(
            // 需要代理对子控件的位置进行处理
            delegate: TestFlowDelegate(margin: const EdgeInsets.all(10.0)),
            children: <Widget>[
              Container(width: 80.0, height:80.0, color: Colors.red),
              Container(width: 80.0, height:80.0, color: Colors.green),
              Container(width: 80.0, height:80.0, color: Colors.blue),
              Container(width: 80.0, height:80.0, color: Colors.yellow),
              Container(width: 80.0, height:80.0, color: Colors.orange),
              Container(width: 80.0, height:80.0, color: Colors.purple),
            ],
          ),
        ],
      )
    );
  }
}