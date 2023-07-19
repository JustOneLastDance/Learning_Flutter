import 'package:flutter/material.dart';

class ScrollNotificationRoute extends StatefulWidget {
  const ScrollNotificationRoute({super.key});

  @override
  ScrollNotificationRouteState createState() => ScrollNotificationRouteState();
}

class ScrollNotificationRouteState extends State<ScrollNotificationRoute> {
  String _progress = '0%'; // 保存滚动进度

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动监听'),
      ),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress = '${(progress * 100).toInt()}%';
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            return false;
            //return true; //放开此行注释后，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('$index'));
                },
              ),

              // 滚动进度显示
              CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.black54,
                child: Text(_progress),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
