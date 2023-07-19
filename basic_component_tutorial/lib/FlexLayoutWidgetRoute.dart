import 'package:flutter/material.dart';

/*
* 弹性布局
* 允许子组件按照一定的比例分配父组件容器的空间
* 弹性布局需要 Expanded 和 Flex 搭配使用来实现
* Expanded 只能作为 Flex 的子控件来使用，用来对 Flex 中的子控件按比例对控件进行分配
* Row Column 继承自 Flex
* */

class FlexLayoutWidgetRoute extends StatelessWidget {
  const FlexLayoutWidgetRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("弹性布局"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // 实现在水平方向上以1：2的比例对控件进行分配
          Flex(
            // *再次强调：Expanded 应该作为 Flex 的子控件*
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,  // 比例系数
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                ),
              ),
              Expanded(
                flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}