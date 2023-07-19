import 'package:flutter/material.dart';


/*
* LeafRender  用于没有子节点的控件，如 image
* SingleChildRender 可包含一个控件，如 ConstrainedBox
* MultiChildRender 可包含多个控件，如 Row/Colum/Stack
* 布局控件一般都有 children/child 来接收其他控件
* 继承关系：Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget
* */

class LinearLayoutWidgetRoute extends StatelessWidget {
  const LinearLayoutWidgetRoute({super.key});

  @override
  Widget build(BuildContext context) {

    Widget redBox = const DecoratedBox(
        decoration: BoxDecoration(color: Colors.red)
    );

    Widget spaceBox = const SizedBox(
      height: 20.0,
      width: double.infinity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("布局类控件"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // ConstrainedBox用于对子组件添加额外的约束
          // 与之相反的有 UnconstrainedBox 即去除约束限制，例如子控件由于约束条件导致变形可用此布局控件进行修改
          ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50.0
              ),
              child: Container(
                height: 5.0, // 由于上层控件已经声明了最小为50，故在此处规定的高度为5，实际上必须为50
                child: redBox,
              )
          ),
          spaceBox,

          // SizedBox 给子控件规定宽高
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: redBox,
          ),
        ],
      ),
    );
  }
}