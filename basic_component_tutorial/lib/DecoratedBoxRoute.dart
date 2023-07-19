import 'package:flutter/material.dart';

/*
* DecoratedBox
* DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。
* 内部属性：
* decoration：代表将要绘制的装饰，它的类型为Decoration。
* Decoration是一个抽象类，它定义了一个接口 createBoxPainter()，子类的主要职责是需要通过实现它来创建一个画笔，该画笔用于绘制装饰。
* position：此属性决定在哪里绘制Decoration，它接收DecorationPosition的枚举类型，该枚举类有两个值：
* background：在子组件之后绘制，即背景装饰。
* foreground：在子组件之上绘制，即前景。
*
* */

class DecoratedBoxRoute extends StatelessWidget {
  const DecoratedBoxRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DecoratedBox'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 18.0)),
          Align(
            alignment: Alignment.center,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
