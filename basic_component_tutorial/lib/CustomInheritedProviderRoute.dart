import 'dart:collection';

import 'package:flutter/material.dart';

/*
* 跨组件的数据共享
* 通过将需要跨组件的数据存放在 InheritedWidget 中实现数据共享
*
* */

class ShoppingCartRoute extends StatefulWidget {
  const ShoppingCartRoute({super.key});

  @override
  _ShoppingCartRouteState createState() => _ShoppingCartRouteState();
}

class _ShoppingCartRouteState extends State<ShoppingCartRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 50)),

                // Builder 组件是 Flutter 中的一个常用组件，
                // 它的主要作用是创建一个新的 BuildContext，并在该新的上下文中构建子树。
                // Builder(builder: (context) {
                //   var cart = ChangeNotifierProvider.of<CartModel>(context);
                //   return Text('TotalPrice: ${cart.totalPrice}');
                // }),

                Consumer<CartModel>(
                    builderX: (context, cart) =>
                        Text("总价: ${cart?.totalPrice}", textScaleFactor: 2.0)),

                Builder(builder: (context) {
                  // of函数修改之后，没有任何变化的按钮不会重新构建
                  print('ElevatedButton clicked');
                  return ElevatedButton(
                      onPressed: () {
                        //给购物车中添加商品，添加后总价会更新
                        // ChangeNotifierProvider.of<CartModel>(context)
                        //     .add(Item(20.0, 1));

                        // of函数修改之后
                        ChangeNotifierProvider.of<CartModel>(context,
                                listen: false)
                            .add(Item(30.0, 1));
                      },
                      child: const Text('add Goods'));
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/// 便捷类：封装了显示价格的组件，会获得当前context和指定数据类型的Provider
/// 代码更直观简洁
/// builder 是一个回调函数，在代码回调中具体构建 UI 组件
class Consumer<T> extends StatelessWidget {
  const Consumer({Key? key, required this.builderX}) : super(key: key);

  // Widget 返回类型 Function 表示 参数 builder 是一个函数
  final Widget Function(BuildContext context, T? value) builderX;

  @override
  Widget build(BuildContext context) {
    return builderX(context, ChangeNotifierProvider.of<T>(context));
  }
}

/// Cart Model
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息(禁止从外部对 _items 进行修改)
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // fold(initialValue, (previousValue, element) => null)
  // 是一种迭代将集合中的元素累积起来的函数
  // initialValue 表示初始数据，previousValue 表示前一个累加值，element 表示当前元素
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 只能通过该函数对 _items 进行修改
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

/// Item Model(CartModel 中的一个嵌套 Model)
class Item {
  Item(this.price, this.count);

  double price;
  int count;
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key? key, required this.data, required this.child});

  final Widget child;
  final T data;

  static T of<T>(BuildContext context, {bool listen = true}) {
    // 添加商品按钮在状态发生改变也会被重新构建，但是按钮本身并没有发生任何改变，需要打破这层依赖关系
    // final provider =
    //     context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();

    // 根据传入的 listen 的布尔值判断是否需要添加依赖关系
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;

    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    // 如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      // 当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

/// 一个通用的InheritedWidget，保存需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider(
      {super.key, required this.data, required Widget child})
      : super(child: child);

  // 通过泛型确保可以保存各种类型的 data
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    // 在此简单返回true，则每次更新都会调用依赖其的子孙节点的 didChangeDependencies。
    return true;
  }
}
