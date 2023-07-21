import 'package:flutter/material.dart';

class ShowDialogRoute extends StatelessWidget {
  const ShowDialogRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dialog'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    bool? delete = await _showAlertDialog(context);
                    if (delete == null) {
                      print('取消删除');
                    } else {
                      print('确认删除');
                    }
                  },
                  child: const Text('AlertDialog')),
              ElevatedButton(
                  onPressed: () async {
                    // 自定义 dialog，具有黑色背景遮罩以及动画效果
                    _showCustomDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("提示"),
                            content: const Text("您确定要删除当前文件吗?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("取消"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: const Text("删除"),
                                onPressed: () {
                                  // 执行删除操作
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text('自定义具有黑色遮罩以及动画效果的 Dialog')),
              ElevatedButton(
                  onPressed: () {
                    _showSimpleDialog(context);
                  },
                  child: const Text('SimpleDialog')),
              ElevatedButton(
                  onPressed: () => _showListDialog(context),
                  child: const Text('ListDialog')),
              ElevatedButton(
                onPressed: () async {
                  // 接收到对话框中的选中状态并加以处理
                  bool? result = await _showAlertDialogWithState(context);
                  print('result: $result');
                },
                child: const Text('带有状态的对话框'),
              ),
            ],
          ),
        ));
  }

  /// 通过 (context as Element).markNeedsBuild()
  /// 实现对对话框内的状态进行管理和操作
  Future<bool?> _showAlertDialogWithState(BuildContext context) {
    bool _withTree = false;

    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Tips'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text("您确定要删除当前文件吗?"),
                Row(
                  children: <Widget>[
                    const Text("同时删除子目录？"),
                    Checkbox(
                        value: _withTree,
                        onChanged: (value) {
                          // 将想要进行重构的组件标记为 dirty，在调用 setState() 会通知页面进行重构
                          (context as Element).markNeedsBuild();
                          _withTree = !_withTree;
                        }),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("取消"),
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(_withTree),
                  child: const Text("删除")),
            ],
          );
        });
  }

  /// 封装一个showCustomDialog方法，内部调用了 showGeneralDialog()，
  /// 它定制的对话框动画为缩放动画，并同时制定遮罩颜色为Colors.black87
  Future<T?> _showCustomDialog<T>(
      {required BuildContext context,
      bool barrierDismissible = true,
      required WidgetBuilder builder,
      ThemeData? theme}) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Theme(data: theme, child: pageChild);
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  /// 实际上AlertDialog和SimpleDialog都使用了Dialog类。
  /// 由于AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，
  /// 这就导致他们的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）
  /// 此时应该使用 Dialog 类。
  Future<void> _showListDialog(BuildContext context) async {
    int? i = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              children: <Widget>[
                const ListTile(title: Text('Please choose')),
                Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('No.$index'),
                        onTap: () => Navigator.of(context).pop(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
    if (i != null) {
      print('click the tile at Index: $i');
    }
  }

  /// SimpleDialog也是Material组件库提供的对话框，它会展示一个列表，用于列表选择的场景。
  Future<void> _showSimpleDialog(BuildContext context) async {
    int? i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  /// AlertDialog
  /// 注意：如果AlertDialog的内容过长，内容将会溢出，这在很多时候可能不是我们期望的，
  /// 所以如果对话框内容过长时，可以用SingleChildScrollView将内容包裹起来。
  Future<bool?> _showAlertDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Tips'),
            content: const Text('是否确定删除当前文件？'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  // 关闭对话框并返回 true
                  Navigator.of(context).pop(true);
                },
                child: const Text('确认'),
              ),
            ],
          );
        });
  }
}
