import 'package:flutter/material.dart';

/*
* 滚动监听以及控制
* ScrollController -> Listenable
*
* 滚动位置恢复
* PageStorage 是一个用于保存页面相关信息的组件，和 UI 无关，不影响 UI
* 组件可以通过指定不同的 PageStorageKey 来存储数据或者当前状态
*
* 在一个页面中可能包含多个可滚动组件，但并不意味着需要给他们分别指定 PageStorageKey。
* 由于可滚动组件都继承自 StatefulWidget，在其 state 中会保存当前滚动的位置，除非组件销毁或者 Widget 树被重构导致
* state被销毁，此时需要 PageStorageKey 来保存组件的数据或者状态。
*
* 一个典型的场景是在使用TabBarView：
* 在Tab发生切换时，Tab页中的可滚动组件的State就会销毁，这时如果想恢复滚动位置就需要指定PageStorageKey。
*
* 在 Flutter 中子组件可以通过 NotificationListener/ScrollNotification(通知) 的方式和父组件进行通信
*
* NotificationListener 和 ScrollController 的不同点：
* 1.
* */

class ScrollControllerRoute extends StatefulWidget {
  const ScrollControllerRoute({super.key});

  @override
  ScrollControllerRouteState createState() => ScrollControllerRouteState();
}

class ScrollControllerRouteState extends State<ScrollControllerRoute> {
  final ScrollController _controller = ScrollController();
  bool showToTopButton = false; // 是否显示返回顶部按钮

  @override
  void initState() {
    super.initState();
    // 添加滚动监听
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopButton) {
        setState(() {
          showToTopButton = false;
        });
      } else if (_controller.offset > 1000 && showToTopButton == false) {
        setState(() {
          showToTopButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // 为了避免出现内存泄漏，及时释放 _controller
    _controller.dispose();
    // 注意顺序
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动监听及控制'),
      ),
      body: Scrollbar(
        child: ListView.builder(
            controller: _controller,
            itemCount: 50,
            itemExtent: 50.0,
            itemBuilder: (context, index) {
              return ListTile(title: Text('$index'));
            }),
      ),

      // 悬浮按钮的出现和消失自带弹性动画效果
      floatingActionButton: !showToTopButton ? null : FloatingActionButton(
          onPressed: () {
            // 动画滚动至指定位置
            _controller.animateTo(
                .0, // 位置
                duration: const Duration(milliseconds: 200), // 持续时间
                curve: Curves.ease // 动画样式
            );
          },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
