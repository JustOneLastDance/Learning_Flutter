import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

/*
* WebSocket
* Http协议是无状态的，只能由客户端主动发起，服务端再被动响应，服务端无法向客户端主动推送内容，
* 并且一旦服务器响应结束，链接就会断开(见注解部分)，所以无法进行实时通信。
* WebSocket协议正是为解决客户端与服务端实时通信而产生的技术。
* Flutter提供了专门的包来支持WebSocket协议。
*
* WebSocket协议本质上是一个基于tcp的协议，它是先通过HTTP协议发起一条特殊的http请求进行握手后，
* 如果服务端支持WebSocket协议，则会进行协议升级。WebSocket会使用http协议握手后创建的tcp链接，
* 和http协议不同的是，WebSocket的tcp链接是个长链接（不会断开），所以服务端与客户端就可以通过此TCP连接进行实时通信。
*
* Notes
* 1. http协议无状态，指的是服务器不会保留之前请求的任何信息，每次请求是独立的，
*    服务器无法知道它是否是同一个用户发出的请求，也无法知道之前的请求的上下文信息。
*    优点：简单、容易实现、可扩展 缺点：无法知道用户状态、无法进行数据共享。
* 2. Http协议中虽然可以通过keep-alive机制使服务器在响应结束后链接会保持一段时间，但最终还是会断开，
*    keep-alive机制主要是用于避免在同一台服务器请求多个资源时频繁创建链接，它本质上是支持链接复用的技术，而并非用于实时通信。
*
* */

class WebSocketRoute extends StatefulWidget {
  const WebSocketRoute({super.key});

  @override
  _WebSocketRouteState createState() => _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = TextEditingController();
  late IOWebSocketChannel channel;
  String _text = '';

  @override
  void initState() {
    super.initState();
    //创建websocket连接
    channel = IOWebSocketChannel.connect('wss://echo.websocket.events');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  //网络不通会走到这
                  if (snapshot.hasError) {
                    _text = "网络不通...";
                  } else if (snapshot.hasData) {
                    _text = 'echo: ${snapshot.data}';
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(_text),
                  );
                }
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send Message',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    // 关闭 WebSocket 连接，避免资源泄漏。
    channel.sink.close();

    super.dispose();
  }

}
