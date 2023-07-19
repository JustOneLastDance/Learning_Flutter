import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class InfiniteListViewRoute extends StatefulWidget {
  const InfiniteListViewRoute({super.key});

  @override
  InfiniteListViewRouteState createState() => InfiniteListViewRouteState();
}

class InfiniteListViewRouteState extends State<InfiniteListViewRoute> {
  static const loadingTag = '##loading##';
  var words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('无限上拉菜单'),
      ),
      body: Column(
        children: <Widget>[
          // 表头
          const ListTile(title: Text('Word List')),
          // 利用拉伸控件 Expanded + Column 实现铺满屏幕的效果
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (words[index] == loadingTag) {
                      // 列表项少于100，提取更多数据
                      if (words.length - 1 < 100) {
                        // 加载时显示 loading
                        _retrieveData();
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          ),
                        );
                      } else {
                        // 没有更多数据提示
                        return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          child: const Text('无更多数据',
                              style: TextStyle(color: Colors.grey)),
                        );
                      }
                    }

                    return ListTile(
                        title: Text('${index + 1}   ${words[index]}'));
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1.0),
                  itemCount: words.length)),
        ],
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        words.insertAll(
          words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList(),
        );
      });
    });
  }
}
