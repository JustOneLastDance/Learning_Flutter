import 'package:flutter/material.dart';

class ScaffoldRoute extends StatefulWidget {
  const ScaffoldRoute({super.key});

  @override
  ScaffoldRouteState createState() => ScaffoldRouteState();
}

class ScaffoldRouteState extends State<ScaffoldRoute> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Home'),

        // 自定义左侧抽屉菜单图标
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); // 获取父级最近的Scaffold 组件的State对象
              },
              icon: const Icon(Icons.dashboard, color: Colors.white));
        }),

        actions: <Widget>[
          // 顶部导航栏右侧按钮菜单
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),

      // 左侧抽屉菜单
      drawer: const MyDrawer(),

      // 底部导航栏，类似 TabBar
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     // 底部导航栏的 Item 数量必须 >= 2
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      //     BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business')
      //   ],
      //   currentIndex: selectedIndex,
      //   fixedColor: Colors.blue, // 选中状态的颜色
      //   onTap: _onItemTapped,
      // ),

      // 实现正下方中央为悬浮按钮腾出空间
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // 底部打孔
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,  // 平分bottomBar 的空间
          children: <Widget>[
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.home)
            ),
            const SizedBox(), // 为按钮留出位置
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.business)),
          ],
        ),
      ),

      // 悬浮按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 设置悬浮按钮的位置
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onAdd() {
    print('Click the floating button!');
  }
}

// 自定义抽屉菜单
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding( // 移除默认的留白
          context: context,
          removeTop: true, // 移除顶部默认留白
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipOval(
                        child: Image.asset('images/avatar.jpeg', width: 80),
                      ),
                    ),
                    const Text('Justin',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  children: const <Widget>[
                    ListTile(
                      title: Text('Add account'),
                      leading: Icon(Icons.add),
                    ),
                    ListTile(
                      title: Text('Manage accounts'),
                      leading: Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
