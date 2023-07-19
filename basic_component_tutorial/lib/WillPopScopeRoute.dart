import 'package:flutter/material.dart';

/*
* 导航返回拦截
* 防止用户误触导致 app 退出
* 在很多 App 中都拦截了用户点击返回键的按钮，然后进行一些防误触判断。
* 比如当用户在某一个时间段内点击两次时，才会认为用户是要退出（而非误触）。
*
* */

class WillPopScopeRoute extends StatefulWidget {
  const WillPopScopeRoute({super.key});

  @override
  _WillPopScopeRouteState createState() => _WillPopScopeRouteState();
}

// 利用_(下划线)将一个属性或者方法定义成私有
class _WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime? _lastPressedAt; // 最近一次点击的时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  const Duration(seconds: 1)) {
            // 两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('导航返回拦截'),
          ),
          body: Container(
            alignment: Alignment.center,
            child: const Text('1秒内连续点击两次返回按钮退出', textScaleFactor: 2.0),
          ),
        ));
  }
}
