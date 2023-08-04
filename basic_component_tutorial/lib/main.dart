import 'package:basic_component_tutorial/AIINotificationRoute.dart';
import 'package:basic_component_tutorial/AlignLayoutRoute.dart';
import 'package:basic_component_tutorial/AnimatedSwitcherRoute.dart';
import 'package:basic_component_tutorial/AnimationBasicPrincipleRoute.dart';
import 'package:basic_component_tutorial/AsyncBuilderRoute.dart';
import 'package:basic_component_tutorial/ChangableThemeRoute.dart';
import 'package:basic_component_tutorial/ChunkDownloadRoute.dart';
import 'package:basic_component_tutorial/ClipRoute.dart';
import 'package:basic_component_tutorial/ContainerRoute.dart';
import 'package:basic_component_tutorial/CustomCheckboxRoute.dart';
import 'package:basic_component_tutorial/CustomInheritedProviderRoute.dart';
import 'package:basic_component_tutorial/CustomPaintAndCanvasRoute.dart';
import 'package:basic_component_tutorial/CustomScrollViewRoute.dart';
import 'package:basic_component_tutorial/DecoratedBoxRoute.dart';
import 'package:basic_component_tutorial/DialogRoute.dart';
import 'package:basic_component_tutorial/EventBusRoute.dart';
import 'package:basic_component_tutorial/FileOperationRoute.dart';
import 'package:basic_component_tutorial/FittedBoxRoute.dart';
import 'package:basic_component_tutorial/FlexLayoutWidgetRoute.dart';
import 'package:basic_component_tutorial/FlowAndWrapLayoutRoute.dart';
import 'package:basic_component_tutorial/FormTestRoute.dart';
import 'package:basic_component_tutorial/GestureConflictRoute.dart';
import 'package:basic_component_tutorial/GestureTestRoute.dart';
import 'package:basic_component_tutorial/GradientButtonRoute.dart';
import 'package:basic_component_tutorial/GridViewRoute.dart';
import 'package:basic_component_tutorial/HTTPRequestRoute.dart';
import 'package:basic_component_tutorial/HeroAnimationRoute.dart';
import 'package:basic_component_tutorial/HitTestBehaviorRoute.dart';
import 'package:basic_component_tutorial/HttpRequestDioRoute.dart';
import 'package:basic_component_tutorial/InfiniteListViewRoute.dart';
import 'package:basic_component_tutorial/InheritedWidgetRoute.dart';
import 'package:basic_component_tutorial/JSONToDartModelRoute.dart';
import 'package:basic_component_tutorial/LayoutBuilderAndAfterLayoutRoute.dart';
import 'package:basic_component_tutorial/LinearLayoutWidgetRoute.dart';
import 'package:basic_component_tutorial/ListViewRoute.dart';
import 'package:basic_component_tutorial/NestedScrollViewRoute.dart';
import 'package:basic_component_tutorial/NestedTabBarViewRoute.dart';
import 'package:basic_component_tutorial/PaddingAndEdgeInsetsRoute.dart';
import 'package:basic_component_tutorial/PageViewRoute.dart';
import 'package:basic_component_tutorial/PointerEventRoute.dart';
import 'package:basic_component_tutorial/ProgressIndicatorRoute.dart';
import 'package:basic_component_tutorial/ScaffoldRoute.dart';
import 'package:basic_component_tutorial/ScrollControllerRoute.dart';
import 'package:basic_component_tutorial/ScrollNotificationRoute.dart';
import 'package:basic_component_tutorial/SingleChildScrollViewRoute.dart';
import 'package:basic_component_tutorial/SliverAppBarRoute.dart';
import 'package:basic_component_tutorial/SocketAPIRoute.dart';
import 'package:basic_component_tutorial/StackAndPositionedLayoutRoute.dart';
import 'package:basic_component_tutorial/StaggerAnimationRoute.dart';
import 'package:basic_component_tutorial/TabBarViewRoute.dart';
import 'package:basic_component_tutorial/TransformRoute.dart';
import 'package:basic_component_tutorial/ValueListenableBuilderRoute.dart';
import 'package:basic_component_tutorial/WaterMarkRoute.dart';
import 'package:basic_component_tutorial/WaterMaskRoute.dart';
import 'package:basic_component_tutorial/WebSocketRoute.dart';
import 'package:basic_component_tutorial/WillPopScopeRoute.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// 自带间距的悬浮按钮
class MyLuckyElevatedButton extends StatelessWidget {
  const MyLuckyElevatedButton(
      {Key? key, required this.routeName, required this.buttonName})
      : super(key: key);

  final String routeName;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(routeName);
        },
        child: Text(buttonName, textAlign: TextAlign.center),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Basic Component Demo'),
        'text_and_style_page': (context) => const TextStylePage(),
        'button_page': (context) => const ButtonPage(),
        'pic_and_icon_page': (context) => const IconAndPicsPage(),
        'switch_and_checkbox_page': (context) => const SwitchAndCheckBoxPage(),
        'login_page': (context) => const LoginPage(),
        'form_test_page': (context) => const FormTestRoute(),
        'progress_indicator_page': (context) => const ProgressIndicatorRoute(),
        'linear_layout_widget_page': (context) =>
            const LinearLayoutWidgetRoute(),
        'flex_layout_widget_page': (context) => const FlexLayoutWidgetRoute(),
        'flow_and_wrap_widget_page': (context) =>
            const FlowAndWrapLayoutRoute(),
        'stack_and_positioned_widget_page': (context) =>
            const StackAndPositionedLayoutRoute(),
        'align_layout_page': (context) => const AlignLayoutRoute(),
        'layout_builder_and_after_layout_page': (context) =>
            const LayoutBuilderAndAfterLayoutRoute(),
        'padding_and_edge_insets_page': (context) =>
            const PaddingAndEdgeInsetsRoute(),
        'decorated_box_page': (context) => const DecoratedBoxRoute(),
        'transform_page': (context) => const TransformRoute(),
        'container_page': (context) => const ContainerRoute(),
        'clip_page': (context) => const ClipRoute(),
        'fitted_box_page': (context) => const FittedBoxRoute(),
        'scaffold_page': (context) => const ScaffoldRoute(),
        'single_child_scroll_view_page': (context) =>
            const SingleChildScrollViewRoute(),
        'list_view_page': (context) => const ListViewRoute(),
        'infinite_list_view_page': (context) => const InfiniteListViewRoute(),
        'scroll_controller_page': (context) => const ScrollControllerRoute(),
        'scroll_notification_page': (context) =>
            const ScrollNotificationRoute(),
        'grid_view_page': (context) => const GridViewRoute(),
        'page_view_page': (context) => const PageViewRoute(),
        'tab_bar_view_page': (context) => const TabBarViewRoute(),
        'custom_scroll_view_page': (context) => CustomScrollViewRoute(),
        'nested_scroll_view_page': (context) => const NestedScrollViewRoute(),
        'sliver_app_bar_page': (context) => const SnapAppBar(),
        'nested_tab_bar_view_page': (context) => const NestedTabBarViewRoute(),
        'will_pop_scope_page': (context) => const WillPopScopeRoute(),
        'inherited_widget_page': (context) => const InheritedWidgetRoute(),
        'custom_inherited_provider_page': (context) =>
            const ShoppingCartRoute(),
        'changeable_theme_page': (context) => const ChangeableThemeRoute(),
        'value_listenable_page': (context) => const ValueListenableRoute(),
        'async_builder_page': (context) => const AsyncBuilderRoute(),
        'dialog_page': (context) => const ShowDialogRoute(),
        'pointer_event_page': (context) => const PointerEventRoute(),
        'gesture_test_page': (context) => const GestureTestRoute(),
        'hit_test_behavior_page': (context) => const PointerDownListenerRoute(),
        'water_mask_page': (context) => const WaterMaskRoute(),
        'gesture_conflict_page': (context) => const GestureConflictRoute(),
        'event_bus_page': (context) => const EventBusRoute(),
        'my_notification_page': (context) => const MyNotificationRoute(),
        'animation_basic_principle_page': (context) =>
            const ScaleAnimationRoute(),
        // 自定义 Hero
        // 'hero_animation_page': (context) => const CustomHeroAnimationRoute(),
        // Flutter 自带 Hero 动画
        'hero_animation_page': (context) => const HeroAnimationRouteA(),
        'stagger_animation_page': (context) => const StaggerAnimationRoute(),
        'animated_switcher_page': (context) =>
            const AnimatedSwitcherCounterRoute(),
        'gradient_button_page': (context) => const GradientButtonRoute(),
        'draw_chessboard_page': (context) => const DrawChessBoardRoute(),
        'custom_checkbox_page': (context) => const CustomCheckboxRoute(),
        'water_mark_page': (context) => const WaterMarkRoute(),
        'file_operation_page': (context) => const FileOperationRoute(),
        'http_request_page': (context) => const HTTPRequestRoute(),
        'http_request_dio_page': (context) => const HttpRequestDioRoute(),
        'chunk_download_page': (context) => const ChunkDownloadRoute(),
        'web_socket_page': (context) => const WebSocketRoute(),
        'socket_api_page': (context) => const SocketAPIRoute(),
        'json_to_dart_model_page': (context) => const JsonToDartModelRoute(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*主页*/
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 2.0,
          children: const <Widget>[
            MyLuckyElevatedButton(
                routeName: "text_and_style_page", buttonName: "文本以及样式"),
            MyLuckyElevatedButton(routeName: "button_page", buttonName: "各种按钮"),
            MyLuckyElevatedButton(
                routeName: "pic_and_icon_page", buttonName: "图片以及 Icon"),
            MyLuckyElevatedButton(
                routeName: "switch_and_checkbox_page", buttonName: "开关和复选框"),
            MyLuckyElevatedButton(routeName: "login_page", buttonName: "登陆页面"),
            MyLuckyElevatedButton(
                routeName: "form_test_page", buttonName: "表单 Form"),
            MyLuckyElevatedButton(
                routeName: "progress_indicator_page", buttonName: "进度指示器"),
            MyLuckyElevatedButton(
                routeName: "linear_layout_widget_page", buttonName: "线性布局类控件"),
            MyLuckyElevatedButton(
                routeName: "flex_layout_widget_page", buttonName: "弹性布局类控件"),
            MyLuckyElevatedButton(
                routeName: "flow_and_wrap_widget_page", buttonName: "流式布局控件"),
            MyLuckyElevatedButton(
                routeName: "flow_and_wrap_widget_page", buttonName: "流式布局控件"),
            MyLuckyElevatedButton(
                routeName: "stack_and_positioned_widget_page",
                buttonName: "堆叠布局"),
            MyLuckyElevatedButton(
                routeName: "align_layout_page", buttonName: "对齐与相对定位"),
            MyLuckyElevatedButton(
                routeName: "layout_builder_and_after_layout_page",
                buttonName: "LayoutBuilder"),
            MyLuckyElevatedButton(
                routeName: "padding_and_edge_insets_page",
                buttonName: "Padding & EdgeInsets"),
            MyLuckyElevatedButton(
                routeName: "decorated_box_page", buttonName: "DecoratedBox"),
            MyLuckyElevatedButton(
                routeName: "transform_page", buttonName: "变换"),
            MyLuckyElevatedButton(
                routeName: "container_page", buttonName: "Container"),
            MyLuckyElevatedButton(routeName: "clip_page", buttonName: "Clip"),
            MyLuckyElevatedButton(
                routeName: "fitted_box_page", buttonName: "FittedBox"),
            MyLuckyElevatedButton(
                routeName: "scaffold_page", buttonName: "Scaffold"),
            MyLuckyElevatedButton(
                routeName: "single_child_scroll_view_page",
                buttonName: "SingleChildScrollView"),
            MyLuckyElevatedButton(
                routeName: "list_view_page", buttonName: "ListView"),
            MyLuckyElevatedButton(
                routeName: "infinite_list_view_page", buttonName: "上拉菜单"),
            MyLuckyElevatedButton(
                routeName: "scroll_controller_page", buttonName: "滚动监听及控制"),
            MyLuckyElevatedButton(
                routeName: "scroll_notification_page",
                buttonName: "ScrollNotification"),
            MyLuckyElevatedButton(
                routeName: "grid_view_page", buttonName: "GridView"),
            MyLuckyElevatedButton(
                routeName: "page_view_page", buttonName: "PageView"),
            MyLuckyElevatedButton(
                routeName: "tab_bar_view_page", buttonName: "TabBarView"),
            MyLuckyElevatedButton(
                routeName: "custom_scroll_view_page",
                buttonName: "CustomScrollView & Sliver"),
            MyLuckyElevatedButton(
                routeName: 'nested_scroll_view_page',
                buttonName: 'NestedScrollView'),
            MyLuckyElevatedButton(
                routeName: 'sliver_app_bar_page', buttonName: "SliverAppBar"),
            MyLuckyElevatedButton(
                routeName: 'nested_tab_bar_view_page',
                buttonName: 'NestedTabBarView'),
            MyLuckyElevatedButton(
                routeName: 'will_pop_scope_page', buttonName: '导航返回拦截'),
            MyLuckyElevatedButton(
                routeName: 'inherited_widget_page',
                buttonName: 'InheritedWidget'),
            MyLuckyElevatedButton(
                routeName: 'custom_inherited_provider_page',
                buttonName: 'Provider'),
            MyLuckyElevatedButton(
                routeName: 'changeable_theme_page', buttonName: '主题换肤'),
            MyLuckyElevatedButton(
                routeName: 'value_listenable_page', buttonName: '按需 Rebuild'),
            MyLuckyElevatedButton(
                routeName: 'async_builder_page', buttonName: '异步 UI 更新'),
            MyLuckyElevatedButton(routeName: 'dialog_page', buttonName: '对话框'),
            MyLuckyElevatedButton(
                routeName: 'pointer_event_page', buttonName: '触摸事件'),
            MyLuckyElevatedButton(
                routeName: 'gesture_test_page', buttonName: '手势识别'),
            MyLuckyElevatedButton(
                routeName: 'hit_test_behavior_page',
                buttonName: 'HitTestBehavior'),
            MyLuckyElevatedButton(
                routeName: 'water_mask_page', buttonName: 'HitTestBehavior-水印'),
            MyLuckyElevatedButton(
                routeName: 'gesture_conflict_page', buttonName: '手势冲突'),
            MyLuckyElevatedButton(
                routeName: 'event_bus_page', buttonName: '事件总线'),
            MyLuckyElevatedButton(
                routeName: 'my_notification_page', buttonName: '通知'),
            MyLuckyElevatedButton(
                routeName: 'animation_basic_principle_page',
                buttonName: "Flutter 动画"),
            MyLuckyElevatedButton(
                routeName: 'hero_animation_page', buttonName: '自定义 Hero 动画'),
            MyLuckyElevatedButton(
                routeName: 'stagger_animation_page', buttonName: '交织动画'),
            MyLuckyElevatedButton(
                routeName: 'animated_switcher_page', buttonName: '动画切换组件'),
            MyLuckyElevatedButton(
                routeName: 'gradient_button_page', buttonName: '自定义渐变按钮'),
            MyLuckyElevatedButton(
                routeName: 'draw_chessboard_page', buttonName: '画棋盘'),
            MyLuckyElevatedButton(
                routeName: 'custom_checkbox_page', buttonName: '自定义选择框'),
            MyLuckyElevatedButton(
                routeName: 'water_mark_page', buttonName: '水印'),
            MyLuckyElevatedButton(
                routeName: 'file_operation_page', buttonName: '文件操作'),
            MyLuckyElevatedButton(
                routeName: 'http_request_page', buttonName: 'Http 请求'),
            MyLuckyElevatedButton(
                routeName: 'http_request_dio_page', buttonName: 'Http请求库-Dio'),
            MyLuckyElevatedButton(
                routeName: 'chunk_download_page', buttonName: 'Dio-分块下载'),
            MyLuckyElevatedButton(
                routeName: 'web_socket_page', buttonName: 'WebSocket'),
            MyLuckyElevatedButton(
                routeName: 'socket_api_page', buttonName: 'Socket API'),
            MyLuckyElevatedButton(
                routeName: 'json_to_dart_model_page', buttonName: 'JSON转模型'),
          ],
        ),
      ),
    );
  }
}

/* 输入框以及表单 -- 控制焦点 */
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  FocusNode focusNodeUserName = FocusNode(); // 用户名输入框的焦点
  FocusNode focusNodePassword = FocusNode(); // 密码输入框的焦点
  FocusScopeNode? focusScopeNode; // 焦点的控制范围

  @override
  void initState() {
    super.initState();
    userNameController.addListener(() {
      print(userNameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 在 Flutter 中，UI 更新和渲染是由框架自动触发的，一般发生在 build() 方法中。因此，对于需要更新 UI 的操作，
    // 例如修改文本内容和选中范围等，通常需要在 build() 方法中进行。
    userNameController.text = "Justin";
    userNameController.selection = TextSelection(
        baseOffset: 2, // 从第三个字符开始
        extentOffset: userNameController.text.length // 选中第三个字符之后所有的字符
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("登陆界面"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              autofocus: true, //焦点在用户名输入框
              focusNode: focusNodeUserName,
              controller: userNameController,
              decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              focusNode: focusNodePassword,
              decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            Builder(builder: (ctx) {
              return Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        // 确定焦点的范围
                        focusScopeNode ??= FocusScope.of(context); // 选取焦点的控制范围
                        focusScopeNode!.requestFocus(focusNodePassword);
                      },
                      child: const Text("移动焦点")),
                  ElevatedButton(
                      onPressed: () {
                        focusNodeUserName.unfocus();
                        focusNodePassword.unfocus();
                      },
                      child: const Text("隐藏键盘")),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

/*开关以及复选框*/
class SwitchAndCheckBoxPage extends StatefulWidget {
  const SwitchAndCheckBoxPage({super.key});

  @override
  SwitchAndCheckBoxPageState createState() => SwitchAndCheckBoxPageState();
}

class SwitchAndCheckBoxPageState extends State<SwitchAndCheckBoxPage> {
  bool _switchSelected = true;
  bool _checkBoxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("开关以及复选框"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
                value: _switchSelected,
                onChanged: (value) {
                  setState(() {
                    _switchSelected = value;
                  });
                }),
            Checkbox(
                value: _checkBoxSelected,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() {
                    _checkBoxSelected = value!;
                  });
                }),
          ],
        ),
      ),
    );
  }
}

// 图片以及 Icon
class IconAndPicsPage extends StatelessWidget {
  const IconAndPicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String icons = "";
// accessible: 0xe03e
    icons += "\uE03e";
// error:  0xe237
    icons += " \uE237";
// fingerprint: 0xe287
    icons += " \uE287";

    return Scaffold(
      appBar: AppBar(
        title: const Text("图片以及 Icon"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 使用 MaterialIcons，字体图标，可以像字体一样设置样式
            Text(icons,
                style: const TextStyle(
                    fontFamily: "MaterialIcons",
                    fontSize: 40.0,
                    color: Colors.lightGreen)),
            // 添加本地图片，首先要在.yaml中申明
            Image.asset("images/avatar.jpeg", width: 100),

            // 添加网络下载的图片
            Image.network(
              "https://pics5.baidu.com/feed/7e3e6709c93d70cfe95b5b64b46c0c0bbba12b76.png@f_auto?token=ab358909419f7d06c9f98d7719bd00ad",
              width: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}

// 各种按钮
class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("不同类型的按钮"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 漂浮按钮，自带阴影和灰色背景
            ElevatedButton(
                onPressed: () {
                  print("Click the Elevated Button!");
                },
                child: const Text("ElevatedButton")),

            // 文本按钮，默认背景透明且不具有阴影
            TextButton(
                onPressed: () {
                  print("Click the Text Button");
                },
                child: const Text("TextButton")),

            // 边框按钮，按钮周围有一圈边框，没有阴影效果
            OutlinedButton(
                onPressed: () {
                  print("Click the Outlined Button");
                },
                child: const Text("OutlinedButton")),

            // 带有图标的按钮，outlined button/elevated button/text button 都可以创建图标按钮
            ElevatedButton.icon(
              onPressed: () {
                print("click the icon button");
              },
              icon: const Icon(Icons.send),
              label: const Text("带有图标的发送按钮"),
            ),
          ],
        ),
      ),
    );
  }
}

// 文本以及样式
class TextStylePage extends StatelessWidget {
  const TextStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("文本以及样式"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Hello World!", textAlign: TextAlign.left),
            Text("Hello World! I'm Justin" * 4,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            const Text('Hello World!', textScaleFactor: 1.5),

            Text("Hello World!" * 6, textAlign: TextAlign.center),

            // 详细描述文本的样式
            const Text(
              "Hello World!",
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                  backgroundColor: Colors.yellow,
                  // 文本背景色
                  decoration: TextDecoration.underline,
                  // 文本下划线
                  decorationStyle: TextDecorationStyle.dashed // 横线样式
                  ),
            ),

            // 富文本：对于同一文本中的不同部分进行处理
            const Text.rich(TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(color: Colors.red))
            ])),

            // 可以为 widget 树中某一节点内的所有文本设置默认的文本样式
            const DefaultTextStyle(
                style: TextStyle(color: Colors.red, fontSize: 20.0),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Hello World!"),
                    Text("I'm Justin！"),
                    Text("I'm Rosie!",
                        // 若要使用特别样式，则 inherit: false
                        style: TextStyle(
                            inherit: false, // 不使用默认样式
                            color: Colors.grey))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
